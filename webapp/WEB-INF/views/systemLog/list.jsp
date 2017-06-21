<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工信息</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">
	$(function() {
		//公用的对象
		var systemLogDialog = $("#systemLogDialog");
		var systemLogForm = $("#systemLogForm");
		var systemLogDataGrid = $("#systemLogDataGrid");
		var systemLogSearchDlg = $("#complexSearchDialog");
		var systemLogSearchForm = $("#systemLogSearchForm");
		//easyui 把一个普通的表单的提交方式,修改为ajax提交.
		//<a href="javascript:void(0)" class="easyui-linkbutton" 
		//onclick="javascript:$('#systemLogForm').submit();">保存</a>
		systemLogForm.form({
			//数据提交成功后执行 (不管操作是否成功或失败).
			success : function(data) {
				//data 是一个json字符串,我们需要通过jQuery.parseJSON转换为JSON对象.
				data = jQuery.parseJSON(data);
				if (data.success) {
					//弹出窗体dialog必须关闭
					systemLogDialog.dialog("close");
					//调用重新加载数据的方法
					systemLogDataGrid.datagrid("reload");
				} else {
					jQuery.messager.alert('Error', data.msg, 'error');
				}
			}
		});
		//真正的提交操作:$('#ff').submit();,修改为ajax提交.
	});
</script>
</head>
<body>
	<!-- 表格数据 -->
	<table id="systemLogDataGrid" class="easyui-datagrid"
		title="系统日志" fit="true" style="width: 700px; height: 250px"
		toolbar="#toolbar" rownumbers="true" pagination="true"
		pageList="[10,20,50]" fitColumns="true"
		data-options="singleSelect:true,url:'/systemLog/json',method:'get'">
		<thead>
			<tr>
				<!-- sortable="true" 开启排序 -->
				<th sortable="true" data-options="field:'id',width:5">编号</th>
				<th data-options="field:'opUser',width:5,formatter:objectFormatterLog">登录用户</th>
				<th sortable="true" data-options="field:'opTime',width:10,formatter:formatDateBoxFull">操作时间</th>
				<th data-options="field:'opIp',width:10">IP地址</th>
				<th data-options="field:'function',width:30">访问方法</th>
			</tr>
		</thead>
	</table>
</body>
</html>