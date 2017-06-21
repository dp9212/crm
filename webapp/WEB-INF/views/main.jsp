<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CRM主页</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<style type="text/css">
	.loginuserinfo {
		font-size: 16px;
		font-family:华文楷体;
		position: absolute;/* 让第一个DIV显示在第二个DIV之上 */
		bottom:8px;
		right: 130px;
	}
</style>
<script type="text/javascript">
	$(function() {
		//展示登录人
		$.messager.show({
			title:'欢迎登录CRM系统',
			msg:'<strong>${LOGINUSER.realName }</strong>  ,  欢迎使用!',
			showType:'show'
		});
		//主题
		$("#mm1 > div").bind('click',function(){
			//console.debug($(this).data("theme"));
			var themes = $(this).data("theme");
			//修改主页面
			$("#themeCssLink").attr('href',"/static/easyui/themes/"+themes+"/easyui.css");
			//修改数据展示页面iframe i索引
			$("iframe").each(function(i,iframeDom){
				//console.debug(iframeDom);
				$(iframeDom.contentDocument).find("#themeCssLink").attr('href',"/static/easyui/themes/"+themes+"/easyui.css");
			});
			//把当前样式更新到全局对象中
			window.Config={
				"theme" : themes,
			};
		});
		//监控菜单树的点击事件
		//去掉class="easyui-tree"
		$("#leftMenu").tree(
						{
							onClick : function(node) {
								var text = node.text; // 获取点击的菜单名称
								//alert(node.url); // 在用户点击的时候提示
								//console.dir(node);
								//如果使用jQuery EasyUI 1.3以下，不能直接获取json数据的属性url的值
								//必须通过node.attributes[url]获取
								var url = node.url;
								//"iconCls":"icon-save"
								var iconCls = node.icon;
								if (!url) {//没有url属性直接返回
									return;
								}
								//获取选项卡组件
								var tt = $("#tt");
								//先判断当前面板是否已经存在了
								//exists which 表明指定的面板是否存在，'which'参数可以是选项卡面板的标题或索引。
								if (tt.tabs("exists", text)) {
									//选中对应面板
									//select which 选择一个选项卡面板，'which'参数可以是选项卡面板的标题或者索引 
									tt.tabs("select", text);
								} else {
									//调用add方法
									tt.tabs(
										'add',
										{
											title : text,
											content : '<iframe frameborder="0" src="'
												+ url
												+ '" style="width: 100%; height: 99.3%;"></iframe>',
										closable : true
									});
								}
							}
						});
	});
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north'" style="height: 50px">
		<span class="loginuserinfo">
			欢迎你：<strong style="color:blue;" >${LOGINUSER.realName }</strong>
			&emsp;<a href="/logout" style="color: red;">注销</a>
			<!-- <a href="/logout"><img src="/static/img/zhuxiao.png"></a> -->
		</span>
		<!-- 换肤 -->
		<div style="position:absolute; right: 30px; bottom: 6px " >
			<a class="easyui-menubutton" data-options="menu:'#mm1',iconCls:'icon-tip'">主题</a>
		</div>
		<!-- 主题下拉选择框 -->
		<div id="mm1" style="width: 150px;">
			<div data-theme="default" data-options="iconCls:'icon-cut'">默认</div>
			<div data-theme="metro" data-options="iconCls:'icon-cut'">白色</div>
			<div data-theme="black" data-options="iconCls:'icon-cut'">黑色</div>
			<div data-theme="bootstrap" data-options="iconCls:'icon-cut'">bootstrap</div>
			<!-- <div class="menu-sep"></div> --><!-- 横线效果 -->
		</div>
		<img src="/static/img/logoTouming.png" width="100%" height="48px" />
	</div>
	<div data-options="region:'south',split:true" style="height: 50px; text-align: center;">
		<span >2016-2017第五组 版权所有 蜀ICP备14030149号-1 蜀公网安备510114990541</span>
		<!-- <img src="/static/img/bottom.png" width="100%" height="100%" /> -->
	</div>
	<div  data-options="region:'west',split:true" title="菜单" style="width: 200px;" >
		<!--创建easyui树组件 -->
		<ul style="position: absolute;" id="leftMenu" data-options="url:'/menu/getUserMenu',method:'post',animate:true"></ul>
		<!-- <img src="/static/img/left.png" width="100%" height="100%" /> -->
	</div>
	<!--中：主体内容 -->
	<div data-options="region:'center'">
		<div id="tt" class="easyui-tabs" fit="true" border="false" title="aaa">
			<div title="欢迎使用">
				<img src="/static/img/beijing.jpg" width="100%" height="100%">
			</div>
		</div>
	</div>
</body>
</html>