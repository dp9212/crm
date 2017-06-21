package cn.yysg.crm.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.SystemDictionaryItem;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.query.SystemDictionaryItemQuery;
import cn.yysg.crm.service.ISystemDictionaryItemService;
import cn.yysg.crm.util.JsonResult;

@Controller
@RequestMapping("/systemDictionaryItem")
public class SystemDictionaryItemController {
  @Autowired
  private ISystemDictionaryItemService systemDictionaryItemService;

  // 显示列表页面
  @RequestMapping("/list")
  public String list() {
    return "systemDictionaryItem/list";
  }


  // 从列表页面发出ajax请求获取json数据
  @RequestMapping("/json")
  @ResponseBody
  public PageList<SystemDictionaryItem> json(SystemDictionaryItemQuery qo) {
	 if(qo.getParentId()==null){
		 return new PageList<SystemDictionaryItem>();
	 }else{
	  return systemDictionaryItemService.getPageList(qo);
	 }
  }


  // 处理save
  @RequestMapping("/save")
  @ResponseBody
  public JsonResult save(SystemDictionaryItem systemDictionaryItem) {
    try {
      if (systemDictionaryItem.getId() == null) {
    	  systemDictionaryItemService.save(systemDictionaryItem);
      } else {
    	  systemDictionaryItemService.update(systemDictionaryItem);
      }
      return new JsonResult();
    } catch (Exception e) {
      return new JsonResult("异常：" + e.getMessage());
    }
  }
}
