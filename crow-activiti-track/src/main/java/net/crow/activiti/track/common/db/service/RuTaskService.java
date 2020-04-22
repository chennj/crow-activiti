package net.crow.activiti.track.common.db.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.crow.activiti.track.common.db.AbstractBaseService;
import net.crow.activiti.track.common.db.dao.RuTaskDao;
import net.crow.activiti.track.common.db.entity.RuTask;

@Service
@Transactional
public class RuTaskService extends AbstractBaseService<RuTask> {
	
	@Autowired
	public void setBaseDao(RuTaskDao ruTaskDao){
		
		super.setBaseDao(ruTaskDao);
	}

}
