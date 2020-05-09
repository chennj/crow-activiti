package net.crow.activiti.track.common.db.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.crow.activiti.track.common.constant.ConstGlobal;
import net.crow.activiti.track.common.db.AbstractBaseService;
import net.crow.activiti.track.common.db.Page;
import net.crow.activiti.track.common.db.dao.RuJobDao;
import net.crow.activiti.track.common.db.dao.RuTaskDao;
import net.crow.activiti.track.common.db.entity.RuJob;
import net.crow.activiti.track.common.db.entity.RuTask;

@Service
@Transactional
public class RuTaskService extends AbstractBaseService<RuTask> {
	
	@Autowired
	RuJobDao jobDao;
	
	@Autowired
	RuTaskDao taskDao;
	
	@Autowired
	public void setBaseDao(RuTaskDao ruTaskDao){
		
		super.setBaseDao(ruTaskDao);
	}

	@Override
	public void addList(List<RuTask> list) throws Exception {
		
		RuJob t = jobDao.get(list.get(0).getProcInstId());
		if (t == null){
			throw new Exception("Job:"+list.get(0).getProcInstId()+" is not exists, Please check!");
		}
		super.addList(list);
	}

	@Transactional(readOnly=true)
	public Page<?> page(int start, int length, String clientOrJob, String clientOrJobId, String sSearch, String order) {
		
		StringBuilder sql = new StringBuilder()
				.append("task.id_ id, task.name_ name, task.spent_time_ spentTime, task.estimate_ estimate,")
				.append("task.proc_inst_id_ jobId, task.business_key_ clientId,task.desc_ desc, task.create_time_ createTime,")
				.append("task.last_tracking_date_ lastTrackingDate, task.sys_status_id_ sysStatusId,")
				.append("task.sys_type_id_ sysTypeId, task.overdue_date_ overdueDate,task.start_time_ startTime ");
		String selectJob = 
				"job.name_ jobName ";
		String selectClient = 
				"client.name_ clientName ";
		
		List<Object> params = new ArrayList<Object>(){
			/**
			 * 
			 */
			private static final long serialVersionUID = 1L;

			{
				this.add(sSearch);
			}
		};
		
		if (ConstGlobal.ALL_CLIENT_KEY.equals(clientOrJob)){
			sql
			.append(",").append(selectJob)
			.append(",").append(selectClient)
			.append("from actt_ru_task task, actt_hi_procinst job, actt_ge_client client ")
			.append("where task.proc_inst_id_ = job.id_ and job.business_key_ = client.id_ ")
			.append("and ")
			.append("( ")
			.append("or task.name_ like %?1% ")
			.append("or job.name_ like %?1% ")
			.append("or client.name_ like %?1% ")
			.append("")
			.append(") ");
			if (order !=null && order.trim().length() > 0){
				sql.append("order by ?2");
				params.add(order);
			}
		} else if (ConstGlobal.CLIENT_KEY.equals(clientOrJob)){
			sql
			.append(",").append(selectJob)
			.append("from actt_ru_task task, actt_hi_procinst job ")
			.append("where task.proc_inst_id_ = job.id_")
			.append("and task.business_key_ =?2")
			.append("( ")
			.append("or task.name_ like %?1% ")
			.append("or job.name_ like %?1% ")
			.append(") ");
			params.add(clientOrJobId);
			if (order !=null && order.trim().length() > 0){
				sql.append("order by ?3");
				params.add(order);
			}
		} else if (ConstGlobal.JOB_KEY.equals(clientOrJob)){
			sql
			.append(",").append(selectJob)
			.append("from actt_ru_task task")
			.append("where")
			.append("and task.proc_inst_id_ =?2")
			.append("and task.name_ like %?1% ");	
			params.add(clientOrJobId);
			if (order !=null && order.trim().length() > 0){
				sql.append("order by ?3");
				params.add(order);
			}
		} else {
			return null;
		}
				
		return taskDao.findPage(sql.toString(), start, length, params.toArray());
		
	}
}
