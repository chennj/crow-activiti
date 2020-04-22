package net.crow.activiti.track.web.controller.interceptor;

import java.math.BigInteger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import net.crow.activiti.track.common.constant.ConstGlobal;
import net.crow.activiti.track.common.db.entity.IdUser;
import net.crow.activiti.track.common.db.service.IdUserService;
import net.crow.activiti.track.common.util.CookieUtil;
import net.crow.activiti.track.common.util.DigestUtils;
import net.crow.activiti.track.common.util.SessionUtil;
import net.crow.activiti.track.web.controller.annotation.PermessionLimit;

/**
 * 权限拦截，简易版
 * @author chenn
 *
 */
@Component
public class PermissionInterceptor extends HandlerInterceptorAdapter implements InitializingBean {

	/**
	 * 密码加盐
	 */
	@Value("${acti.time.salt}")
	private String salt;
	
	private static String pwdSalt;
	
	/**
	 * 地址白名单
	 */
	@Value("${acti.time.excludeUrl}")
	private String excludeUrl;
	
	private static String[] excludeUrls;
	
	private static IdUserService userService;
	
	@Override
	public void afterPropertiesSet() throws Exception {
		
		if (	excludeUrl == null 
				|| excludeUrl.trim().length() == 0
				|| salt == null
				|| salt.trim().length() == 0){
			throw new RuntimeException("Address White List And Salt Cann't Be Empty! In Application Property File");
		}
		
		pwdSalt = salt;
		
		excludeUrls = excludeUrl.split(",");
		
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpServletRequest req = (HttpServletRequest) request;
		//HttpServletResponse resp = (HttpServletResponse) response;
		//HttpSession session = req.getSession();
		
		String contextName = req.getContextPath();
		String url = req.getRequestURI();
		url = url.replace(contextName, "");
				
		// 在地址白名单中不进行拦截(例如isAlive)
		for (int i = 0; i < excludeUrls.length; i++) {
			String excludeUrl = excludeUrls[i];
			if (url.startsWith(excludeUrl)) {
				return true;
			}
		}
		
		if (!(handler instanceof HandlerMethod)) {
			return super.preHandle(request, response, handler);
		}

		if (!ifLogin(request)) {
			HandlerMethod method = (HandlerMethod)handler;
			PermessionLimit permission = method.getMethodAnnotation(PermessionLimit.class);
			if (permission == null || permission.limit()) {
				response.sendRedirect(request.getContextPath() + "/toLogin");
				//request.getRequestDispatcher("/toLogin").forward(request, response);
				return false;
			}
		}

		return super.preHandle(request, response, handler);
	}

    // ---------------------- tool ----------------------

	public static final String LOGIN_IDENTITY_KEY = "CROW_ACTT_LOGIN_IDENTITY";
	
	public static boolean login(
			HttpServletResponse response, 
			HttpServletRequest request,
			String username, 
			String password, 
			boolean ifRemember){
		
		if (null == userService){
			WebApplicationContext applicationContext = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext());
			userService = applicationContext.getBean(IdUserService.class);
			if (null == userService){
				throw new RuntimeException("User Service Bean Init Failed!");
			}
		}
		
		IdUser userInfo = userService.getUnique("no", username);
		if (null == userInfo){
			return false;
		}
		
		String pwd = DigestUtils.encryptMd5(DigestUtils.encryptMd5(password)+pwdSalt);
		if (!userInfo.getPwd().equals(pwd)){
			return false;
		}
		
		String tokenTmp = new BigInteger(1, pwd.getBytes()).toString(16);
		
		SessionUtil.setSession(ConstGlobal.USER_SESSION_KEY, userInfo);
		CookieUtil.set(response, LOGIN_IDENTITY_KEY, tokenTmp, ifRemember);
		return true;
	}
	
	public static void logout(HttpServletRequest request, HttpServletResponse response){
		request.getSession().removeAttribute(ConstGlobal.USER_SESSION_KEY);
		CookieUtil.remove(request, response, LOGIN_IDENTITY_KEY);
	}
	
	public static boolean ifLogin(HttpServletRequest request){
		String indentityInfo = CookieUtil.getValue(request, LOGIN_IDENTITY_KEY);
		if (indentityInfo==null) {
			return false;
		}
		
		HttpSession session = request.getSession();
		IdUser user = (IdUser)session.getAttribute(ConstGlobal.USER_SESSION_KEY);
		if (user == null){
			return false;
		}
		return true;
	}
}
