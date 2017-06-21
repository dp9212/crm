<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">
	$(function() {
		//公用的对象
		var departmentDialog = $("#departmentDialog");
		var departmentForm = $("#departmentForm");
		var departmentDataGrid = $("#departmentDataGrid");

		//添加用户
		$("#addDepartment").on("click", function() {
			departmentForm.form("clear");
			departmentDialog.dialog("open");
		});

		//编辑用户
		$("#editDepartment").on("click", function() {
			var row = departmentDataGrid.datagrid("getSelected");
			console.debug(row);
			if (row) {
				//加载本地数据
				departmentForm.form("load", row);
				departmentDialog.dialog("open");
			} else {
				jQuery.messager.alert('警告信息', '请选中行，在修改!', 'warning');//警告
			}
		});

		//删除用户
		$("#deleteDepartment")
				.on("click",
						function() {
							var row = departmentDataGrid.datagrid("getSelected");
							console.debug(row);
							if (row) {
								//发出一个ajax请求去后台删除
								var url = "/department/delete?id=" + row.id;
								jQuery.get(url,
												function(data) {
													console.debug(data);
													if (data instanceof Object) {
														if (data.success) {//删除成功
															jQuery.messager
																	.alert(
																			'消息提示',
																			'删除成功!',
																			'info',
																			function() {
																				//调用重新加载数据的方法
																				departmentDataGrid
																						.datagrid("reload");
																			});//消息							
														}
													} else {
														jQuery.messager.alert(
																'错误提示',
																'后台出现异常',
																'error');
													}
												}, 'json');
							} else {
								jQuery.messager
										.alert('警告信息', '请选中行，在删除!', 'warning');//警告
							}
						});

		//easyui 把一个普通的表单的提交方式,修改为ajax提交.
		//<a href="javascript:void(0)" class="easyui-linkbutton" 
		//onclick="javascript:$('#departmentForm').submit();">保存</a>
		departmentForm.form({
			//数据提交成功后执行 (不管操作是否成功或失败).
			success : function(data) {
				//data 是一个json字符串,我们需要通过jQuery.parseJSON转换为JSON对象.
				data = jQuery.parseJSON(data);
				if (data.success) {
					//弹出窗体dialog必须关闭
					departmentDialog.dialog("close");
					//调用重新加载数据的方法
					departmentDataGrid.datagrid("reload");
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
	<table id="departmentDataGrid" class="easyui-datagrid" title="Basic DataGrid"
		fit="true" style="width: 700px; height: 250px" toolbar="#toolbar"
		rownumbers="true" pagination="true" pageList="[10,20,50]"
		fitColumns="true"
		data-options="singleSelect:true,url:'/department/json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:10">编号</th>
				<th data-options="field:'name',width:10">名称</th>
				<th data-options="field:'sn',width:10">sn</th><th data-options="field:'dirPath',width:10">dirPath</th><th data-options="field:'manager',width:10">manager</th><th data-options="field:'parent',width:10">parent</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a id="addDepartment" href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true">添加</a> <a id="editDepartment"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true">编辑</a> <a id="deleteDepartment"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true">删除 </a>
	</div>

	<div id="departmentDialog" class="easyui-dialog" title="保存用户"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#btns">
		<!-- 		加上employee.前缀 -->
		<form id="departmentForm" method="post" action="/department/save">
			<input type="hidden" name="id">
			<table>
				<tr><td>名称:</td> <td><input class="easyui-validatebox" type="text" name="name" data-options="required:true"></input></td> </tr>
				<tr><td>sn:</td><td><input class='easyui-validatebox' type='text' name='sn' data-options="required:true"></input></td></tr>
				<tr><td>路径:</td><td><input class='easyui-validatebox' type='text' name='dirPath'></input></td></tr>
				<tr><td>经理:</td><td><input class='easyui-validatebox' type='text' name='manager.id'></input></td></tr>
				<tr><td>父级:</td><td><input class='easyui-validatebox' type='text' name='parent.id'></input></td></tr>
			</table>
		</form>
	</div>
	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#departmentForm').submit();">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="$('#departmentDialog').dialog('close')">取消</a>
	</div>
</body>
</html>