package net.crow.activiti.track.common.db.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	public Page<RuTask> page(int start, int length, String clientOrJob, String clientOrJobId, String sSearch) {
		
		String Sql = 
				"Select task.id_ id, task.name_ name, task.spent_time_ spentTime, task.estimate_ estimate, "
				+ "task.overdue_date_ overdueDate, task.create_time_ createTime, task.last_tracking_date_ lastTrackingDate,"
				+ "task.sys_status_id_, task.sys_type_id_, "
				+ "";
		return null;
	}
}
