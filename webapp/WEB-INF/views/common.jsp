<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@taglib prefix="p" uri="/WEB-INF/tld/permission.tld"%> 
<!-- 引入easyui的东东 -->
<!-- easyui的样式主题文件 id为主题设置使用  换肤-->
<script type="text/javascript">
	//设置默认
	var themes = "default";
	//判断是否有全局样式 默认window,层级对象，从顶级对象top中改
	if(top.Config && top.Config.theme){
		themes = top.Config.theme;
	}
	//动态引入样式
	document.write('<link id="themeCssLink" rel="stylesheet" type="text/css" href="/static/easyui/themes/'+themes+'/easyui.css">');
</script>
<!-- easyui的图标文件 -->
<link rel="stylesheet" type="text/css" href="/static/easyui/themes/icon.css">
<!-- 自定义公共CSS -->
<link rel="stylesheet" type="text/css" href="/static/css/common.css">
<link rel="stylesheet" type="text/css" href="/static/css/color.css">
<!-- jQuery核心js文件 -->
<script type="text/javascript" src="/static/easyui/jquery.min.js"></script>
<!-- jQuery easyui核心js文件 -->
<script type="text/javascript" src="/static/easyui/jquery.easyui.min.js"></script>
<!-- jQuery easyui 国际化：中文js文件 -->
<script type="text/javascript" src="/static/easyui/locale/easyui-lang-zh_CN.js"></script>
<!-- 自定义公共js -->
<script type="text/javascript" src="/static/js/common.js"></script>