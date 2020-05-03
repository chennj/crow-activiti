package net.crow.activiti.track.common.constant;

public interface ConstGlobal {

	String USER_SESSION_KEY = "user_login_key";
	String USER_INFO_SESSION_KEY = "user_info_key";
	
	String Task_CATEGORY = "Task";
	
	String TASK_KEY = "task";
	String JOB_KEY = "job";
	String CLIENT_KEY = "client";
	String ALL_CLIENT_KEY = "allClients";
	
	Long TS_AUTO_FIND_TASK_WORK_TYPE = (long) (60*1000);
	Long TS_AUTO_FIND_TASK_STATUS = (long) (60*1000);
}
