package net.crow.activiti.track.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityNotFoundException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import net.crow.activiti.track.common.db.Page;
import net.crow.activiti.track.common.db.dao.model.ReturnT;
import net.crow.activiti.track.common.db.entity.GeClient;
import net.crow.activiti.track.common.db.entity.RuJob;
import net.crow.activiti.track.common.db.entity.RuTask;
import net.crow.activiti.track.common.db.entity.SysStatusDict;
import net.crow.activiti.track.common.db.entity.SysType;
import net.crow.activiti.track.common.db.service.GeClientService;
import net.crow.activiti.track.common.db.service.RuJobService;
import net.crow.activiti.track.common.db.service.RuTaskService;
import net.crow.activiti.track.common.db.service.SysStatusDictService;
import net.crow.activiti.track.common.db.service.SysTypeService;

@Controller
@RequestMapping("tasks")
public class TasksController extends BaseController{

	@Autowired
	GeClientService geClientService;
	
	@Autowired
	RuJobService ruJobService;
	
	@Autowired
	RuTaskService ruTaskService;
	
	@Autowired
	SysStatusDictService sStatusService;
	
	@Autowired
	SysTypeService sTypeService;
	
	@RequestMapping("")
	public String tasksView(Model model, HttpServletRequest request){
		
		Map<String, Object> info = new HashMap<>();
		model.addAllAttributes(info);

		return "tasks/tasks-view";
	}

	/**
	 * 新增客户
	 * @param geClient
	 * @return
	 */
    @RequestMapping("/add/client")
    @ResponseBody
    public ReturnT<JSONObject> addClient(GeClient geClient){
    	//valid
    	if (geClient.getName() == null || geClient.getName().trim().length()==0){
    		logger.error("tasks/add/client>>>client name is empty");
    		return new ReturnT<>(ReturnT.FAIL_CODE, "Please Enter Client Name");
    	}
    	
    	try{
    		Map<String,Object> eq = new HashMap<String,Object>(){
    			/**
				 * 
				 */
				private static final long serialVersionUID = 1L;

				{
    				this.put("category", "Client");
    				this.put("flag", "0");
    			}
    		};
    		
    		SysStatusDict statusEntity = sStatusService.getSingle(null,eq);
    		if (statusEntity == null){
    			logger.warn("tasks/add/client>>> "+geClient.getName()+",sysStatusDict entity is empty,Default status value not set for client." );
        		//return new ReturnT<>(ReturnT.FAIL_CODE, "Please Set Default Status Value for Client");
    		} else {
    			geClient.setSysStatusId(statusEntity.getId());
    		}
    		
    		geClient.setTenantId("beta-demo-2020");
	    	GeClient entity = geClientService.add(geClient);
	    	if (entity != null) {
	    		String jsonString = JSON.toJSONString(entity);
	    		JSONObject jo = JSON.parseObject(jsonString);
	            return new ReturnT<JSONObject>(jo);
	        } else {
	        	return new ReturnT<>(ReturnT.FAIL_CODE, "operator failed!");
	        }
    	} catch (Exception e){
    		logger.error("tasks/add/client>>>",e);
    		return new ReturnT<>(ReturnT.FAIL_CODE, e.getMessage());
    	}
    }

    /**
     * 分页查询客户
     * @param start
     * @param length
     * @param request
     * @return
     */
    @RequestMapping("/getClients")
    @ResponseBody
    public ReturnT<JSONObject> getClients(
    		@RequestParam(required = false, defaultValue = "0") int start,
    		@RequestParam(required = false, defaultValue = "100") int length,
    		HttpServletRequest request){
    	
    	String likeSearch = request.getParameter("sSearch");
    	logger.info("task/getClients>>>search str:"+likeSearch);
    	Page<GeClient> page;
    	if (likeSearch == null || likeSearch.trim().length() == 0){
    		page = geClientService.page(start, length, null);
    	} else {
    		page = geClientService.pageLk(start, length, new HashMap<String, Object>(){
    			/**
				 * 
				 */
				private static final long serialVersionUID = 1L;

				{this.put("name", likeSearch);}
    		});
    	}
    	try{
	    
    		JSONObject jResult	= new JSONObject();
    		JSONArray jary 		= new JSONArray();
    		
    		for (GeClient one : page.results){
    			JSONObject tmpJo = new JSONObject();
    			tmpJo.put("id", one.getId());
    			tmpJo.put("name", one.getName());
    			jary.add(tmpJo);
    		}
    		
    		jResult.put("recordsTotal", page.getTotal());
    		jResult.put("recordsFiltered", page.getTotal());
    		jResult.put("params","{page:"+page.getPage()+"}");
    		jResult.put("data", jary);
	    	
	    	logger.info("tasks/getClietns.result>>>"+jResult.toString());
	    	return new ReturnT<JSONObject>(jResult); 
    	} catch(Exception e){
    		logger.error("tasks/getClients>>>",e);
    		return new ReturnT<>(ReturnT.FAIL_CODE, e.getMessage());
    	}
    }
    
    /**
     * 新增工作
     * @param ruJob
     * @return
     */
    @RequestMapping("/add/job")
    @ResponseBody
    public ReturnT<JSONObject> addJob(RuJob ruJob){
    	
    	//valid
    	String clientId = ruJob.getBusinessKey();
    	if (clientId == null || clientId.trim().length() == 0){
    		logger.error("tasks/add/job>>>client id is empty");
    		return new ReturnT<>(ReturnT.FAIL_CODE, "client id is empty");
    	}
    	if (ruJob.getName() == null || ruJob.getName().trim().length()==0){
    		logger.error("tasks/add/job>>>job name is empty");
    		return new ReturnT<>(ReturnT.FAIL_CODE, "please enter job name");
    	}
    	
    	try {
    		Map<String,Object> eq = new HashMap<String,Object>(){
    			/**
				 * 
				 */
				private static final long serialVersionUID = 1L;

				{
    				this.put("category", "job");
    				this.put("flag", "0");
    			}
    		};
    		
    		SysStatusDict statusEntity = sStatusService.getSingle(null,eq);
    		if (statusEntity == null){
    			logger.error("tasks/add/job>>> "+ruJob.getName()+",sysStatusDict entity is empty,Default status value not set for job." );
        		return new ReturnT<>(ReturnT.FAIL_CODE, "Please Set Default Status Value for Job");
    		}
    		
    		GeClient clientEntity = geClientService.getUnique("id", clientId);
    		ruJob.setSysStatusId(statusEntity.getId());
    		ruJob.setTenantId("beta-demo-2020");
    		RuJob jobEntity = ruJobService.add(ruJob);
	    	if (jobEntity != null) {
	    		JSONObject result = new JSONObject(){
	    			/**
					 * 
					 */
					private static final long serialVersionUID = 1L;

					{
	    				this.put("client", clientEntity);
	    				this.put("job", jobEntity);
	    			}
	    		};
	            return new ReturnT<JSONObject>(result);
	        } else {
	        	return new ReturnT<>(ReturnT.FAIL_CODE, "operator failed!");
	        }
    	} catch(EntityNotFoundException e){
    		logger.error("tasks/add/job>>>"+clientId+" not exist, please check client");
    		return new ReturnT<>(ReturnT.FAIL_CODE, e.getMessage());
    	} catch (Exception e){
    		logger.error("tasks/add/job>>>",e);
    		return new ReturnT<>(ReturnT.FAIL_CODE, e.getMessage());
    	}
    }

    /**
     * 分页查询工作
     * @param start
     * @param length
     * @param request
     * @return
     */
    @RequestMapping("/getJobs")
    @ResponseBody
    public ReturnT<JSONObject> getJobs(
    		@RequestParam(required = false, defaultValue = "0") int start,
    		@RequestParam(required = false, defaultValue = "100") int length,
    		HttpServletRequest request){
    	
    	String likeSearch = request.getParameter("sSearch");
    	String clientId = request.getParameter("clientId");
    	Page<RuJob> page;
    	if (likeSearch == null || likeSearch.trim().length() == 0){
    		page = ruJobService.page(start, length, new HashMap<String, Object>(){
    			/**
				 * 
				 */
				private static final long serialVersionUID = 1L;

				{this.put("businessKey", clientId);}
    		});
    	} else {
    		if (clientId == null || clientId.trim().length() == 0){
	    		page = ruJobService.pageLk(start, length, new HashMap<String, Object>(){
	    			/**
					 * 
					 */
					private static final long serialVersionUID = 1L;
	
					{this.put("name", likeSearch);}
	    		});
    		} else {
    			page = ruJobService.pageEqLk(start, length, new HashMap<String, Object>(){
	    			/**
					 * 
					 */
					private static final long serialVersionUID = 1L;
	
					{this.put("businessKey", clientId);}
	    		}, new HashMap<String, Object>(){
	    			/**
					 * 
					 */
					private static final long serialVersionUID = 1L;

					{this.put("name", likeSearch);}
	    		});
    		}
    	}
    	try{
	    
    		JSONObject jResult	= new JSONObject();
    		JSONArray jary 		= new JSONArray();
    		
    		for (RuJob one : page.results){
    			JSONObject tmpJo = new JSONObject();
    			tmpJo.put("id", one.getId());
    			tmpJo.put("name", one.getName());
    			jary.add(tmpJo);
    		}
    		
    		jResult.put("recordsTotal", page.getTotal());
    		jResult.put("recordsFiltered", page.getTotal());
    		jResult.put("params","{page:"+page.getPage()+"}");
    		jResult.put("data", jary);
	    	
	    	logger.info("tasks/getJobs.result>>>"+jResult.toString());
	    	return new ReturnT<JSONObject>(jResult); 
    	} catch(Exception e){
    		logger.error("tasks/getJobs>>>",e);
    		return new ReturnT<>(ReturnT.FAIL_CODE, e.getMessage());
    	}
    }

    /**
     * 根据客户id，查询所有工作
     * @param clientId
     * @return
     */
    @RequestMapping("/job/all")
    @ResponseBody
    public ReturnT<JSONArray> getJobByClientId(
    		@RequestParam(required = true) String clientId){
    	
    	//valid
    	if (clientId == null || clientId.trim().length() == 0){
    		logger.error("tasks/job/all>>>clientId is empty");
    		return new ReturnT<>(ReturnT.FAIL_CODE, "Lost Client ID");
    	}
    	
    	try{
    		JSONArray jResult = new JSONArray();
	    	List<RuJob> list = ruJobService.getList("businessKey", clientId);
	    	for (RuJob one : list){
	    		jResult.add(new JSONObject(){
	    			/**
					 * 
					 */
					private static final long serialVersionUID = 1L;

					{
	    				this.put("id", one.getId());
	    				this.put("name", one.getName());
	    			}
	    		});
	    	}
	    	logger.info("tasks/job/all.result>>>"+jResult.toString());
	    	return new ReturnT<JSONArray>(jResult); 
    	} catch (Exception e){
    		logger.error("tasks/job/all>>>",e);
    		return new ReturnT<>(ReturnT.FAIL_CODE, e.getMessage());
    	}
    }
    
    /**
     * 新增多个任务
     * @param tasks
     * @return
     */
    @RequestMapping("/add/tasks")
    public ReturnT<String> addTasks(
    		@RequestParam(required = true) String tasks){
    	
    	logger.info("tasks/add/tasks>>>receive json string:"+tasks);
    	
    	List<RuTask> list = new ArrayList<>();
    	
    	try {
	    	JSONArray jaryTask = JSONArray.parseArray(tasks);
	    	
	    	for(int i=0; i<jaryTask.size(); i++){
	    		RuTask entity = JSON.toJavaObject(jaryTask.getJSONObject(i), RuTask.class);
	    		list.add(entity);
	    	}
	    	ruTaskService.addList(list);
	    	return new ReturnT<>("Add Operator SUCCESS");
    	} catch (Exception e){
    		logger.error("tasks/add/tasks>>>",e);
    		return new ReturnT<>(ReturnT.FAIL_CODE, e.getMessage());
    	}
    	
    }

    /**
     * 分页查询任务
     * @param start
     * @param length
     * @param jobId
     * @return
     */
    @RequestMapping("/getTasks")
    @ResponseBody
    public String taskPage(
    		@RequestParam(required = false, defaultValue = "0") int start,
    		@RequestParam(required = false, defaultValue = "20") int length,
    		String jobId){
    	
    	if (jobId == null || jobId.trim().length() == 0){
    		JSONObject result = new JSONObject();
    		result.put("recordsTotal", 0);
    		result.put("recordsFiltered", 0);
    		result.put("data", new JSONArray());
    		return result.toJSONString();
    	}
    	
    	Map<String, Object> eq = new HashMap<>();
    	eq.put("sysStatusId", jobId);
        Page<RuTask> page = ruTaskService.page(start, length, eq);
        return page.toJsonString();
    }
    
    /**
     * 获取任务的所有类型
     * @param request
     * @return
     */
    @RequestMapping("/getTaskType")
    @ResponseBody
    public ReturnT<JSONArray> getTaskTypes(HttpServletRequest request){
    	
    	JSONArray jary = new JSONArray();
    	
    	List<SysType> list = sTypeService.getList("category", "Task");
    	try {
    		for (SysType one : list){
    			JSONObject jo = new JSONObject();
    			jo.put("id", one.getId());
    			jo.put("name", one.getName());
    			jo.put("isdefault", "0".equals(one.getFlag().trim()));
    			jary.add(jo);
    		}
    		return new ReturnT<JSONArray>(jary); 
    	} catch (Exception e){
    		logger.error("tasks/getUserBelong>>>",e);
    		return new ReturnT<>(ReturnT.FAIL_CODE, e.getMessage());
    	}
    }
    
    @RequestMapping("/getUserBelong")
    @ResponseBody
    public ReturnT<JSONArray> getUserBelong(HttpServletRequest request){
    	
    	JSONArray jary = new JSONArray();
    	
    	List<GeClient> clients = geClientService.getAll();
    	try{
	    	for (GeClient one : clients){
	    		JSONObject jo = (JSONObject) JSON.toJSON(one);
	    		jary.add(jo);
	    	}
	    	
	    	return new ReturnT<JSONArray>(jary); 
    	} catch(Exception e){
    		logger.error("tasks/getUserBelong>>>",e);
    		return new ReturnT<>(ReturnT.FAIL_CODE, e.getMessage());
    	}
    }
    


}
