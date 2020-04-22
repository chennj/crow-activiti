package net.crow.activiti.track.common.db.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.crow.activiti.track.common.db.AbstractBaseService;
import net.crow.activiti.track.common.db.dao.ReTenantDao;
import net.crow.activiti.track.common.db.entity.ReTenant;

@Service
@Transactional
public class ReTenantService extends AbstractBaseService<ReTenant> {
	
	@Autowired
	public void setBaseDao(ReTenantDao reTenantDao){
		
		super.setBaseDao(reTenantDao);
	}

}
