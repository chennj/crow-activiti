package net.crow.activiti.track.common.db.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.crow.activiti.track.common.db.AbstractBaseService;
import net.crow.activiti.track.common.db.dao.IdUserDao;
import net.crow.activiti.track.common.db.entity.IdUser;

@Service
@Transactional
public class IdUserService extends AbstractBaseService<IdUser> {
	
	@Autowired
	public void setBaseDao(IdUserDao idUserDao){
		
		super.setBaseDao(idUserDao);
	}

}
