package net.crow.activiti.track.web.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;

import net.crow.activiti.track.common.db.dao.model.ReturnT;
import net.crow.activiti.track.common.db.entity.IdUser;
import net.crow.activiti.track.common.db.service.IdUserService;
import net.crow.activiti.track.common.db.service.MessageService;
import net.crow.activiti.track.web.controller.annotation.PermessionLimit;
import net.crow.activiti.track.web.controller.interceptor.PermissionInterceptor;

@Controller
@RequestMapping("/")
public class IndexController extends BaseController{

	@Autowired
	IdUserService idUserService;
	
	@Autowired
	MessageService messageService;
	
	@RequestMapping("demo")
    @ResponseBody
    public String demo() {
		
		JSONArray jary = new JSONArray();
		
        List<IdUser> list = idUserService.getAll();
        for (IdUser one : list){
        	jary.add(one);
        }
        return jary.toJSONString();
    }
	
	@RequestMapping("/")
	public String index(Model model, HttpServletRequest request){
		
		Map<String, Object> dashboardMap = messageService.dashboardInfo();
		model.addAllAttributes(dashboardMap);

		return "index";
	}
	
	@RequestMapping("/toLogin")
	@PermessionLimit(limit=false)
	public String toLogin(Model model, HttpServletRequest request) {
		if (PermissionInterceptor.ifLogin(request)) {
			return "redirect:/";
		}
		return "login";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	@ResponseBody
	@PermessionLimit(limit=false)
	public ReturnT<String> loginDo(HttpServletRequest request, HttpServletResponse response, String userName, String password, String ifRemember){
		
		// valid
		if (PermissionInterceptor.ifLogin(request)) {
			return ReturnT.SUCCESS;
		}

		// param
		if (userName==null || userName.trim().length()==0 || password==null || password.trim().length()==0){
			return new ReturnT<String>(500, "请输入账号密码");
		}
		boolean ifRem = (ifRemember!=null && "on".equals(ifRemember))?true:false;

		// do login
		boolean loginRet = PermissionInterceptor.login(response, request, userName, password, ifRem);
		if (!loginRet) {
			return new ReturnT<String>(500, "账号密码错误");
		}
		return ReturnT.SUCCESS;
	}

	@RequestMapping(value="logout", method=RequestMethod.POST)
	@ResponseBody
	@PermessionLimit(limit=false)
	public ReturnT<String> logout(HttpServletRequest request, HttpServletResponse response){
		if (PermissionInterceptor.ifLogin(request)) {
			PermissionInterceptor.logout(request, response);
		}
		return ReturnT.SUCCESS;
	}

	@RequestMapping("/chartInfo")
	@ResponseBody
	public ReturnT<Map<String, Object>> chartInfo(String startDate, String endDate) {
		ReturnT<Map<String, Object>> chartInfo = messageService.chartInfo(startDate, endDate);
		return chartInfo;
	}

}
