<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CRM系统-登录</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<link rel="stylesheet" type="text/css" href="/static/css/login.css"/>
<script type="text/javascript">
	if (top != window) {// 如果不是顶级
			//把子页面的地址，赋值给顶级页面显示
		window.top.location.href = window.location.href;
	}
	//重置按钮
	function resetForm() {
		$("#loginForm").form("clear");
	}
	$(function() {
		$('#loginForm').form({
			success : function(data) {
				console.debug(data);
				var ret = $.parseJSON(data);//将json返回的字符串数据转换成对象
				if(ret.success){
					location.href="/main";
				}else{
					$('#errmsg').html(ret.msg);
				}
			}
		});
	});
</script>
</head>
<body>
	<div class="container">
	<section id="content">
		<form id="loginForm" action="/login" method="post" >
			<h1>CRM系统登录</h1>
			<div>
				<input type="text" placeholder="用户名" required="true" name="username" value="admin" />
			</div>
			<div>
				<input type="password" placeholder="密码" required="true" name="password" value="admin"/>
			</div>
			<span id="errmsg"></span>
			<div>
				<button name="login">登录</button>
				<button name="reset" onclick="resetForm();" >重置</button>
			</div>
		</form>
		<div class="button">
			<a href="#">联系我们</a>
		</div>
	</section>
</div>
</body>
</html>