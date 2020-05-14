package net.crow.activiti.track.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/users")
public class UserController extends BaseController{

	@RequestMapping("")
	public String index(Model model,HttpServletRequest request){
		
		return "users/users-view";		
	}
}
