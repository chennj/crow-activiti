package net.crow.activiti.track.web.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.servlet.http.HttpServletRequest;

import org.redisson.api.RRateLimiter;
import org.redisson.api.RateIntervalUnit;
import org.redisson.api.RateType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import net.crow.activiti.track.common.modal.ReturnT;
import net.crow.activiti.track.plugin.redisson.DistributedRedisLock;
import net.crow.activiti.track.plugin.redisson.RedissonManager;

@Controller
@RequestMapping("test")
public class DemoController extends BaseController{

    @Autowired
    private StringRedisTemplate redisTemplate;
    
	@RequestMapping("/test-view-tasks")
	public String test(Model model, HttpServletRequest request){
		
		Map<String, Object> info = new HashMap<>();
		model.addAllAttributes(info);

		return "demo/test";
	}

	@RequestMapping("/test-mytable")
	public String test2(Model model, HttpServletRequest request){
		
		Map<String, Object> info = new HashMap<>();
		model.addAllAttributes(info);

		return "demo/test2";
	}

	@RequestMapping(value = "redisson")
	@ResponseBody
	public ReturnT<?> redisson(){
		
        RedissonManager.init(); //初始化
        for (int i = 0; i < 100; i++) {
            Thread t = new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        String key = "test123";
                        DistributedRedisLock.acquire(key);
                        Thread.sleep(1000); //获得锁之后可以进行相应的处理
                        System.err.println("======获得锁后进行相应的操作======");
                        DistributedRedisLock.release(key);
                        System.err.println("=============================");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            });
            t.start();
        }
        
        return success("redisson 测试启动");
	}
	
	@RequestMapping(value = "redisson-rate-limiter1")
	@ResponseBody
	public ReturnT<?> redissonRateLimiter1(){		

		RRateLimiter limiter = RedissonManager.getRedisson().getRateLimiter("myLimiter11");
		// Initialization required only once.
		// 5 permits per 2 seconds
		limiter.trySetRate(RateType.OVERALL, 5, 2, RateIntervalUnit.MINUTES);
		
        ExecutorService executorService= Executors.newFixedThreadPool(10);
        for (int i=0;i<20;i++){
            executorService.submit(()->{
               try{
            	   limiter.acquire();
                   System.out.println("limit-1 线程"+Thread.currentThread().getId()+"进入数据区："+System.currentTimeMillis());
               }catch (Exception e){
                   e.printStackTrace();
               }
            });
        }
		
		return success("redisson 分布式流量控制测试启动1");
	}

	@RequestMapping(value = "redisson-rate-limiter2")
	@ResponseBody
	public ReturnT<?> redissonRateLimiter2(){		

		RRateLimiter limiter = RedissonManager.getRedisson().getRateLimiter("myLimiter12");
		// Initialization required only once.
		// 5 permits per 2 seconds
		limiter.trySetRate(RateType.OVERALL, 25, 2, RateIntervalUnit.MINUTES);  
		
        ExecutorService executorService= Executors.newFixedThreadPool(10);
        for (int i=0;i<100;i++){
            executorService.submit(()->{
               try{
            	   limiter.acquire();
                   System.out.println("limit-2 线程"+Thread.currentThread().getId()+"进入数据区："+System.currentTimeMillis());
               }catch (Exception e){
                   e.printStackTrace();
               }
            });
        }
		
		return success("redisson 分布式流量控制测试启动2");
	}

	@RequestMapping(value = "redis")
	@ResponseBody
	public ReturnT<?> redis(){
		
		Map<String, Object> result = new HashMap<>();
		result.put("userOnline size before added", redisTemplate.boundSetOps("userOnline").size());
		redisTemplate.boundSetOps("userOnline").add("user01");
        redisTemplate.boundSetOps("userOnline").add("user02");
        result.put("userOnline size after added", redisTemplate.boundSetOps("userOnline").size());
        logger.debug(redisTemplate.boundSetOps("userOnline").size() + "");
        redisTemplate.boundSetOps("userOnline").remove("user01");
        logger.debug(redisTemplate.boundSetOps("userOnline").size() + "");
        result.put("userOnline size after remove", redisTemplate.boundSetOps("userOnline").size());
        
        return success(result);
	}
}
