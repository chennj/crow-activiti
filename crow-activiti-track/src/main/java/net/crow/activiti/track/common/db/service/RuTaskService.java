package net.crow.activiti.track.common.db.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.crow.activiti.track.common.db.AbstractBaseService;
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
}
