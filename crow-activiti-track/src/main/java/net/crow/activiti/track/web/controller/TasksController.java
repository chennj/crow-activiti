package net.crow.activiti.track.web.controller;

import java.text.SimpleDateFormat;
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

import net.crow.activiti.track.common.cache.LocalCache;
import net.crow.activiti.track.common.constant.ConstGlobal;
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
import net.crow.activiti.track.common.util.MapUtils;

@Controller
@RequestMapping("/tasks")
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
    @RequestMapping("/add/batch")
    @ResponseBody
    public ReturnT<String> addTasks(
    		@RequestParam(required = true) String tasks){
    	
    	logger.info("tasks/add/batch>>>receive json string:"+tasks);
    	
    	List<RuTask> list = new ArrayList<>();
    	
    	try {
    		Map<String,Object> eq = new HashMap<String,Object>(){
    			/**
				 * 
				 */
				private static final long serialVersionUID = 1L;

				{
    				this.put("category", "Task");
    				this.put("flag", "0");
    			}
    		};    		
    		SysStatusDict defaultStatus = sStatusService.getSingle(null,eq);
    		if (defaultStatus == null){
    			logger.warn("tasks/add/batch>>> default status entity is empty,Default status value not set for client." );
        		return new ReturnT<>(ReturnT.FAIL_CODE, "Please Set Default Status Value for Client");
    		}

	    	JSONArray jaryTask = JSONArray.parseArray(tasks);
	    	
	    	for(int i=0; i<jaryTask.size(); i++){
	    		RuTask entity = JSON.toJavaObject(jaryTask.getJSONObject(i), RuTask.class);
	    		if (entity.getSysStatusId()==null){
	    			entity.setSysStatusId(defaultStatus.getId());
	    		}
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
     * 分页查询（任务）
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
    		String clientOrJobId, 
    		String clientOrJob ,
    		String sSearch,
    		String order){
    	
    	logger.info("enter tasks/getTasks 分页查询（任务）");
    	
    	if (
    			clientOrJobId == null || clientOrJobId.trim().length() == 0 
    			|| clientOrJob == null || clientOrJob.trim().length() == 0 ){
    		
    		JSONObject result = new JSONObject();
    		result.put("recordsTotal", 0);
    		result.put("recordsFiltered", 0);
    		result.put("data", new JSONArray());
    		return result.toJSONString();
    	}
    	    	
        JSONObject resultJson = new JSONObject();
        
        // 获取任务工作类型信息
        Map<String,Object> taskTypes 	= LocalCache.taskTypeCache();        
        // 获取任务状态信息
        Map<String, Object> taskStatus 	= LocalCache.taskStatusCache();

    	JSONObject statusdata = JSONObject.parseObject(JSON.toJSONString(taskStatus));
    	resultJson.put("statusmap", statusdata);
    	
        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        
    	if (sSearch != null && sSearch.trim().length() > 0){
    		
    		Page<?> page = ruTaskService.page(start, length, clientOrJob, clientOrJobId, sSearch, order);
    			        
	        resultJson.put("data", new JSONArray());
	        resultJson.put("recordsTotal", page.getTotal());
	        resultJson.put("recordsFiltered", page.getTotal());
	        
	        List<Map<String, Object>> list = page.getMapResult();
	        
	        for (Map<String, Object> one : list){
	        	
	        	resultJson.getJSONArray("data").add(new JSONObject(){
	        		/**
					 * 
					 */
					private static final long serialVersionUID = 1L;

					{
	        			this.put("id", 				one.get("id"));
	        			this.put("name", 			one.get("name"));
	        			this.put("desc", 			one.get("desc"));
	        			this.put("spentTime", 		one.getOrDefault("spentTime", ""));
	        			this.put("estimate", 		one.getOrDefault("estimate",""));
	        			this.put("overdueDate", 	fmt.format(one.get("overdueDate")));
	        			this.put("lastTrackingDate", fmt.format(one.get("lastTrackingDate")));
	        			this.put("createTime", 		fmt.format(one.get("createTime")));
	        			this.put("jobId", 			one.get("jobId"));
	        			this.put("jobName", 		one.getOrDefault("jobName",one.get("jobId")));
	        			this.put("clientId", 		one.get("business_key_"));
	        			this.put("clientName", 		one.getOrDefault("clientName",one.get("clientId")));
	        			this.put("sysTypeId", 		one.get("sysTypeId"));
	        			this.put("sysTypeName", 	((SysType)taskTypes.get(one.get("sysTypeId"))).getName());
	        			this.put("sysStatusId", 	one.get("sysStatusId"));
	        			this.put("sysStatusName", 	((SysStatusDict)taskStatus.get(one.get("sysStatusId"))).getName());
	        			
	        		}
	        	});	        	
	        }
    	} else {   
    		
        	Map<String, Object> eq = new HashMap<String, Object>(){
        		/**
    			 * 
    			 */
    			private static final long serialVersionUID = 1L;

    			{
        			if(ConstGlobal.CLIENT_KEY.equals(clientOrJob)){
        				this.put("businessKey", clientOrJobId);
        			} else if (ConstGlobal.JOB_KEY.equals(clientOrJob)){
        				this.put("procInstId",clientOrJobId);
        			}
        		}
        	};
        	
        	Page<RuTask> page = ruTaskService.page(start, length, order, eq);
	        
	        resultJson.put("data", new JSONArray());
	        resultJson.put("recordsTotal", page.getTotal());
	        resultJson.put("recordsFiltered", page.getTotal());
	        	        
	        List<String> inJobList 		 = new ArrayList<>();
	        List<String> inClientList 	 = new ArrayList<>();
	        
	        for (RuTask one : page.getResults()){
	        	if (!inJobList.contains(one.getProcInstId().trim())){
	        		inJobList.add(one.getProcInstId().trim());
	        	}
	        	if (!inClientList.contains(one.getBusinessKey().trim())){
	        		inClientList.add(one.getBusinessKey().trim());
	        	}
	        }
	        
	        if (inClientList.size() == 0){
	        	inClientList.add(null);
	        }
	        if (inJobList.size() == 0){
	        	inJobList.add(null);
	        }
	        
	        List<GeClient> clientList 		= geClientService.getList("id", inClientList);
	        List<RuJob> jobList 			= ruJobService.getList("id", inJobList);
	        
	        Map<String, GeClient> clientMap = MapUtils.listToMap("getId", clientList);
	        Map<String, RuJob> jobMap 		= MapUtils.listToMap("getId", jobList);
	        
	    	// 获取任务相关信息
	        for (RuTask one : page.getResults()){
	        	
	        	resultJson.getJSONArray("data").add(new JSONObject(){
	        		/**
					 * 
					 */
					private static final long serialVersionUID = 1L;

					{
	        			this.put("id", 				one.getId());
	        			this.put("name", 			one.getName());
	        			this.put("desc", 			one.getDesc());
	        			this.put("spentTime", 		one.getSpentTime()==null?"":one.getSpentTime());
	        			this.put("estimate", 		one.getEstimate());
	        			this.put("overdueDate", 	fmt.format(one.getOverdueDate()));
	        			this.put("lastTrackingDate", fmt.format(one.getLastTrackingDate()));
	        			this.put("createTime", 		fmt.format(one.getCreateTime()));
	        			this.put("jobId", 			one.getProcInstId());
	        			this.put("jobName", 		jobMap.get(one.getProcInstId()).getName());
	        			this.put("clientId", 		one.getBusinessKey());
	        			this.put("clientName", 		clientMap.get(one.getBusinessKey()).getName());
	        			this.put("sysTypeId", 		one.getSysTypeId());
	        			this.put("sysTypeName", 	((SysType)taskTypes.get(one.getSysTypeId())).getName());
	        			this.put("sysStatusId", 	one.getSysStatusId());
	        			this.put("sysStatusName", 	((SysStatusDict)taskStatus.get(one.getSysStatusId())).getName());
	        			
	        		}
	        	});
	        }

    	} 
    	    	
    	return resultJson.toJSONString();

    }
    
    /**
     * 获取任务的所有类型（列表）
     * 
     * @param request
     * @return
     */
    @RequestMapping("/getTaskTypeList")
    @ResponseBody
    public ReturnT<JSONArray> getTaskTypeList(HttpServletRequest request){
    	
    	JSONArray jary = new JSONArray();
    	
    	Map<String,Object> taskTypes 	= LocalCache.taskTypeCache();  
    	try {
    		for (Map.Entry<String, Object> entry : taskTypes.entrySet()){
    			JSONObject jo = new JSONObject();
    			jo.put("id", entry.getKey());
    			jo.put("name", ((SysType)entry.getValue()).getName());
    			jo.put("parentId", ((SysType)entry.getValue()).getParentId()==null?0:((SysType)entry.getValue()).getParentId());
    			jo.put("isdefault", "0".equals(((SysType)entry.getValue()).getFlag()));
    			jary.add(jo);
    		}
    		return new ReturnT<JSONArray>(jary); 
    	} catch (Exception e){
    		logger.error("tasks/getTaskTypeList>>>",e);
    		return new ReturnT<>(ReturnT.FAIL_CODE, e.getMessage());
    	}
    }
    
    /**
     * 获取任务的所有类型（映射）
     * 
     * @param request
     * @return
     */
    @RequestMapping("/getTaskTypeMap")
    @ResponseBody
    public ReturnT<JSONObject> getTaskTypeMap(HttpServletRequest request){
    	
    	logger.info("enter tasks/getTaskTypeMap");
    	
    	Map<String,Object> taskTypes 	= LocalCache.taskTypeCache();  
    	
    	try {
    		JSONObject jo = JSONObject.parseObject(JSON.toJSONString(taskTypes));
    		return new ReturnT<JSONObject>(jo);
    	} catch (Exception e){
    		logger.error("tasks/getTaskTypeMap>>>",e);
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
