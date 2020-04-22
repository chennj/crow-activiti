package net.crow.activiti.track.common.db.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.crow.activiti.track.common.db.AbstractBaseService;
import net.crow.activiti.track.common.db.dao.SysStatusDictDao;
import net.crow.activiti.track.common.db.entity.SysStatusDict;

@Service
@Transactional
public class SysStatusDictService extends AbstractBaseService<SysStatusDict> {
	
	@Autowired
	public void setBaseDao(SysStatusDictDao sysStatusDictDao){
		
		super.setBaseDao(sysStatusDictDao);
	}

}
