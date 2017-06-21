package cn.yysg.crm.service;

import java.util.List;

import cn.yysg.crm.domain.Menu;

public interface IMenuService extends IBaseService<Menu> {
	List<Menu> getUserMenu(Long id);
}
