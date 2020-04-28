package net.crow.activiti.track.common.db.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.crow.activiti.track.common.db.AbstractBaseService;
import net.crow.activiti.track.common.db.dao.SysTypeDao;
import net.crow.activiti.track.common.db.entity.SysType;

@Service
@Transactional
public class SysTypeService extends AbstractBaseService<SysType> {
	
	@Autowired
	public void setBaseDao(SysTypeDao sysTypeDao){
		
		super.setBaseDao(sysTypeDao);
	}

}
