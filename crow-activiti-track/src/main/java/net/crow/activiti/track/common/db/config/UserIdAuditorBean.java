package net.crow.activiti.track.common.db.config;

import java.util.Optional;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;

import net.crow.activiti.track.common.constant.ConstGlobal;
import net.crow.activiti.track.common.db.entity.IdUser;
import net.crow.activiti.track.common.util.SessionUtil;

@Configuration
public class UserIdAuditorBean implements AuditorAware<String> {

	@Override
	public Optional<String> getCurrentAuditor() {
		IdUser user = (IdUser)SessionUtil.getSession(ConstGlobal.USER_SESSION_KEY);
		if (null == user || user.getNo() == null || user.getNo().toString().trim().length()==0){
			return null;
		} else {
			return Optional.of(user.getId());
		}
	}
}
