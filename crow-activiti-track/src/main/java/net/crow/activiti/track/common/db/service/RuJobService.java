package net.crow.activiti.track.common.db.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.crow.activiti.track.common.db.AbstractBaseService;
import net.crow.activiti.track.common.db.dao.RuJobDao;
import net.crow.activiti.track.common.db.entity.RuJob;

@Service
@Transactional
public class RuJobService extends AbstractBaseService<RuJob> {
	
	@Autowired
	public void setBaseDao(RuJobDao ruJobDao){
		
		super.setBaseDao(ruJobDao);
	}
	
	@Autowired
	RuJobDao dao;

	public List<RuJob> page(int page, int pageSize){
		
		int first = (page-1)*pageSize;
		return dao.findPage(first, pageSize);
	}
}
