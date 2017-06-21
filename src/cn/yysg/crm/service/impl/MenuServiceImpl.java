package cn.yysg.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.Menu;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.MenuMapper;
import cn.yysg.crm.service.IMenuService;

@Service
public class MenuServiceImpl extends BaseServiceImpl<Menu> implements IMenuService {
	
	@Autowired
	private MenuMapper menuMapper;
	@Override
	protected BaseMapper<Menu> getMapper() {
		return menuMapper;
	}
	@Override
	public List<Menu> getUserMenu(Long id) {
		// TODO Auto-generated method stub
		return menuMapper.getUserMenu(id);
	}
	
}
