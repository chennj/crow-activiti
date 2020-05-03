package net.crow.activiti.track.common.cache;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.crow.activiti.track.common.constant.ConstGlobal;
import net.crow.activiti.track.common.db.entity.SysStatusDict;
import net.crow.activiti.track.common.db.entity.SysType;
import net.crow.activiti.track.common.db.service.SysStatusDictService;
import net.crow.activiti.track.common.db.service.SysTypeService;
import net.crow.activiti.track.common.util.ApplicationUtil;

/**
 * 本地缓存，无锁同步
 * @author chenn
 *
 */
public final class LocalCache {

	private static final Logger logger = LoggerFactory.getLogger(LocalCache.class);
	
	/**
	 * 任务工作类别缓存
	 */
	private static volatile Map<String, Object> taskTypeCache = new HashMap<>();
	
	/**
	 * 任务状态缓存
	 */
	private static volatile Map<String, Object> taskStatusCache = new HashMap<>();
	
	/**
	 * 任务工作类别最后更新时间
	 */
	private static volatile Timestamp taskTypeLastUpdateTime = new Timestamp(System.currentTimeMillis());
	
	/**
	 * 任务工作状态最后更新时间
	 */
	private static volatile Timestamp taskStatusLastUpdateTime = new Timestamp(System.currentTimeMillis());
	
	/**
	 * 任务工作类别是否需要更新
	 */
	private static volatile AtomicBoolean taskTypeNeedReset = new AtomicBoolean(true);
	
	/**
	 * 任务工作状态是否需要更新
	 */
	private static volatile AtomicBoolean taskStatusNeedReset = new AtomicBoolean(true);
	
	static {
		
		/**
		 * 初始化任务工作类别
		 */
		SysTypeService stService = ApplicationUtil.getBean(SysTypeService.class);
		if (null == stService){
			logger.error(">>>failed getting SysTypeService Bean");
		} else {
			List<SysType> list = stService.getList("category", ConstGlobal.Task_CATEGORY);
			for (SysType one : list){
				taskTypeCache.put(one.getId(), one);
			}
		}
		
		/**
		 * 初始化任务状态
		 */
		SysStatusDictService ssService = ApplicationUtil.getBean(SysStatusDictService.class);
		if (null == ssService){
			logger.error(">>>failed getting SysStatusDictService Bean");
		} else {
			List<SysStatusDict> list = ssService.getList("category", ConstGlobal.Task_CATEGORY);
			for (SysStatusDict one : list){
				taskStatusCache.put(one.getId(), one);
			}
		}
	}
	
	/**
	 * 缓存任务工作类别
	 * @return Object => SysType
	 */
	public static Map<String, Object> taskTypeCache(){
		
		Timestamp now = new Timestamp(System.currentTimeMillis());
		Long diff = now.getTime() - taskTypeLastUpdateTime.getTime();
		
		if (diff > ConstGlobal.TS_AUTO_FIND_TASK_WORK_TYPE){
			
			if (taskTypeNeedReset.compareAndSet(true, false)){
				
				try {
					taskTypeLastUpdateTime = new Timestamp(System.currentTimeMillis());
					logger.info(">>>task work type cache update");
					SysTypeService service = ApplicationUtil.getBean(SysTypeService.class);
					if (null == service){
						logger.error(">>>failed getting SysTypeService Bean");
					} else {
						List<SysType> list = service.getList("category", ConstGlobal.Task_CATEGORY);
						for (SysType one : list){
							taskTypeCache.put(one.getId(), one);
						}
					}
				} catch (Exception e){
					e.printStackTrace();
					logger.error(">>>failed getting task work type cache cause:",e.getMessage());
				} finally{
					taskTypeNeedReset.compareAndSet(false, true);
				}
				
			}
		}
		
		return taskTypeCache;
	}

	/**
	 * 缓存任务工作状态
	 * @return Object => SysStatusDict
	 */
	public static Map<String, Object> taskStatusCache() {

		Timestamp now = new Timestamp(System.currentTimeMillis());
		Long diff = now.getTime() - taskStatusLastUpdateTime.getTime();
		
		if (diff > ConstGlobal.TS_AUTO_FIND_TASK_STATUS){
			
			if (taskStatusNeedReset.compareAndSet(true, false)){
				
				try {
					taskStatusLastUpdateTime = new Timestamp(System.currentTimeMillis());
					logger.info(">>>task work status cache update");
					SysStatusDictService service = ApplicationUtil.getBean(SysStatusDictService.class);
					if (null == service){
						logger.error(">>>failed getting SysStatusDictService Bean");
					} else {
						List<SysStatusDict> list = service.getList("category", ConstGlobal.Task_CATEGORY);
						for (SysStatusDict one : list){
							taskStatusCache.put(one.getId(), one);
						}
					}
				} catch (Exception e){
					e.printStackTrace();
					logger.error(">>>failed getting task work status cache cause:",e.getMessage());
				} finally{
					taskStatusNeedReset.compareAndSet(false, true);
				}
				
			}
		}
		
		return taskStatusCache;
	}
}
