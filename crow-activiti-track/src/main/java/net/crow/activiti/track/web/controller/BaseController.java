package net.crow.activiti.track.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.crow.activiti.track.common.constant.ConstGlobal;
import net.crow.activiti.track.common.modal.UserInfo;

public abstract class BaseController {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	protected UserInfo getUserInfo(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		return (UserInfo) session.getAttribute(ConstGlobal.USER_INFO_SESSION_KEY);
	}
}
