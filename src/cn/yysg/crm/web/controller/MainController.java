package cn.yysg.crm.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

  // 显示后台主页
  @RequestMapping("/main")
  public String main() {
    return "main";
  }

}
