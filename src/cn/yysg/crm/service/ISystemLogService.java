package cn.yysg.crm.service;

import org.springframework.transaction.annotation.Transactional;
import cn.yysg.crm.domain.SystemLog;

public interface ISystemLogService extends IBaseService<SystemLog>{
	
	//将此方法事务交给Spring处理，成功提交，失败回滚，原子性
    @Transactional
    public void writeLog(SystemLog systemlog);  
     
    //获取登录管理员ID 
    public Long loginUserId(); 

}
