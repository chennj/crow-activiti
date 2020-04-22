package net.crow.activiti.track.common.db.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.crow.activiti.track.common.db.AbstractBaseService;
import net.crow.activiti.track.common.db.dao.GeClientDao;
import net.crow.activiti.track.common.db.entity.GeClient;

@Service
@Transactional
public class GeClientService extends AbstractBaseService<GeClient> {
	
	@Autowired
	public void setBaseDao(GeClientDao geClientDao){
		
		super.setBaseDao(geClientDao);
	}

}
