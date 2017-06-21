package cn.yysg.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import cn.yysg.crm.domain.SystemLog;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.SystemLogMapper;
import cn.yysg.crm.service.ISystemLogService;
import cn.yysg.crm.util.UserContext;

@Service
public class SystemLogServiceImpl extends BaseServiceImpl<SystemLog> implements ISystemLogService {
	@Autowired
	private SystemLogMapper systemLogmapper;

	@Override
	protected BaseMapper<SystemLog> getMapper() {
		return systemLogmapper;
	}
	
	//拿到当前登录用户的ID
	@Override
	public Long loginUserId() {
		Long loginUserId = UserContext.getSessionUser().getId();
		System.out.println("当前登录用户的ID:"+loginUserId);
		return loginUserId;
	}
	//保存日志
	@Override
	public void writeLog(SystemLog systemlog) {
		systemLogmapper.writeLog(systemlog);
	}
}
