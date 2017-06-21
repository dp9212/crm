package cn.yysg.crm.mapper;

import java.util.List;

import cn.yysg.crm.domain.Menu;

public interface MenuMapper extends BaseMapper<Menu> {

	List<Menu> getUserMenu(Long id);

}
