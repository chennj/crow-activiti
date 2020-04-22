package net.crow.activiti.track.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("help")
public class HelpController extends BaseController{

	@RequestMapping("")
	public String help(Model model, HttpServletRequest request){
		
		Map<String, Object> info = new HashMap<>();
		model.addAllAttributes(info);

		return "help/help";
	}

}
