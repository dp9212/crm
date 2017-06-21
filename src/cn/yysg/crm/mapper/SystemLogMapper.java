package cn.yysg.crm.mapper;

import cn.yysg.crm.domain.SystemLog;

public interface SystemLogMapper extends BaseMapper<SystemLog>{
	//保存日志
	public void writeLog(SystemLog systemlog);
}
