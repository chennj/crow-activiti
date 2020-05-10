package net.crow.activiti.track.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("test")
public class DemoController extends BaseController{

	@RequestMapping("/test-view-tasks")
	public String test(Model model, HttpServletRequest request){
		
		Map<String, Object> info = new HashMap<>();
		model.addAllAttributes(info);

		return "demo/test";
	}

	@RequestMapping("/test-mytable")
	public String test2(Model model, HttpServletRequest request){
		
		Map<String, Object> info = new HashMap<>();
		model.addAllAttributes(info);

		return "demo/test2";
	}

}
