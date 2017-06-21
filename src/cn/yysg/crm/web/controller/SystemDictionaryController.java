package cn.yysg.crm.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.SystemDictionary;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.query.SystemDictionaryQuery;
import cn.yysg.crm.service.ISystemDictionaryService;
import cn.yysg.crm.util.JsonResult;

@Controller
@RequestMapping("/systemDictionary")
public class SystemDictionaryController {
  @Autowired
  private ISystemDictionaryService systemDictionaryService;

  // 显示列表页面
  @RequestMapping("/list")
  public String list() {
    return "systemDictionary/list";
  }


  // 从列表页面发出ajax请求获取json数据
  @RequestMapping("/json")
  @ResponseBody
  public PageList<SystemDictionary> json(SystemDictionaryQuery qo) {
	  return systemDictionaryService.getPageList(qo);
  }

  @RequestMapping("/save")
  @ResponseBody
  public JsonResult save(SystemDictionary systemDictionary) {
    try {
      if (systemDictionary.getId() == null) {
    	  systemDictionaryService.save(systemDictionary);
      } else {
    	  systemDictionaryService.update(systemDictionary);
      }
      return new JsonResult();
    } catch (Exception e) {
      return new JsonResult("异常：" + e.getMessage());
    }
  }
}
