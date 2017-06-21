package cn.yysg.crm.util;

import java.util.Date;
import org.aspectj.lang.JoinPoint;
import org.springframework.beans.factory.annotation.Autowired;
import cn.yysg.crm.domain.SystemLog;
import cn.yysg.crm.service.ISystemLogService;

//系统日志

public class SystemLogUtils {
	@Autowired
	private ISystemLogService logService;
	
	public void writeLog(JoinPoint joinPoint){
		Object targetService = joinPoint.getTarget();
		if(targetService instanceof ISystemLogService){
			return ;
		}
		Class cls = joinPoint.getTarget().getClass();
		String methodName = joinPoint.getSignature().getName();
		String function = cls.getName()+":"+methodName;
		SystemLog log = new SystemLog();
		log.setOpUser(UserContext.getSessionUser());
		log.setOpTime(new Date());
		log.setOpIp(UserContext.getRequest().getRemoteAddr());
		log.setFunction(function);
		logService.save(log);
	}
}

