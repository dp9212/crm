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
		var employeeDialog = $("#employeeDialog");
		var employeeForm = $("#employeeForm");
		var employeeDataGrid = $("#employeeDataGrid");

		//添加用户
		$("#addEmployee").on("click", function() {
			employeeForm.form("clear");
			employeeDialog.dialog("open");
		});

		//编辑用户
		$("#editEmployee").on("click", function() {
			var row = employeeDataGrid.datagrid("getSelected");
			console.debug(row);
			if (row) {
				//加载本地数据
				employeeForm.form("load", row);
				employeeDialog.dialog("open");
			} else {
				jQuery.messager.alert('警告信息', '请选中行，在修改!', 'warning');//警告
			}
		});

		//删除用户
		$("#deleteEmployee").on(
				"click",
				function() {
					var row = employeeDataGrid.datagrid("getSelected");
					console.debug(row);
					if (row) {
						//发出一个ajax请求去后台删除
						var url = "/employee/delete?id=" + row.id;
						jQuery.get(url, function(data) {
							console.debug(data);
							if (data instanceof Object) {
								if (data.success) {//删除成功
									jQuery.messager.alert('消息提示', '删除成功!',
											'info', function() {
												//调用重新加载数据的方法
												employeeDataGrid
														.datagrid("reload");
											});//消息							
								}
							} else {
								jQuery.messager
										.alert('错误提示', '后台出现异常', 'error');
							}
						}, 'json');
					} else {
						jQuery.messager.alert('警告信息', '请选中行，在删除!', 'warning');//警告
					}
		});
		
		//添加或修改提交数据
		$('#saveBtn').on('click',function(){
			$('#employeeForm').submit();
		});
		//添加或修改时取消
		$('#closeBtn').on('click',function(){
			$('#employeeDialog').dialog('close');
		});
		
		//easyui 把一个普通的表单的提交方式,修改为ajax提交.
		//<a href="javascript:void(0)" class="easyui-linkbutton" 
		//onclick="javascript:$('#employeeForm').submit();">保存</a>
		employeeForm.form({
			//数据提交成功后执行 (不管操作是否成功或失败).
			success : function(data) {
				//data 是一个json字符串,我们需要通过jQuery.parseJSON转换为JSON对象.
				data = jQuery.parseJSON(data);
				if (data.success) {
					//弹出窗体dialog必须关闭
					employeeDialog.dialog("close");
					//调用重新加载数据的方法
					employeeDataGrid.datagrid("reload");
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
	<table id="employeeDataGrid" class="easyui-datagrid"
		title="Basic DataGrid" fit="true" style="width: 700px; height: 250px"
		toolbar="#toolbar" rownumbers="true" pagination="true"
		pageList="[10,20,50]" fitColumns="true"
		data-options="singleSelect:true,url:'/employee/json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:10">编号</th>
				<th data-options="field:'name',width:10">名称</th>
				<th data-options="field:'username',width:10">员工姓名</th>
				<th data-options="field:'realName',width:10">realName</th>
				<th data-options="field:'password',width:10">password</th>
				<th data-options="field:'tel',width:10">tel</th>
				<th data-options="field:'email',width:10">email</th>
				<th data-options="field:'inputTime',width:10">inputTime</th>
				<th data-options="field:'state',width:10">state</th>
				<th data-options="field:'department',width:10,formatter:objectFormatter ">department</th>
			</tr>
		</thead>
	</table>
	
	<!-- 工具按钮 -->
	<div id="toolbar">
		<a id="addEmployee" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a> <a
			id="editEmployee" href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true">编辑</a> <a id="deleteEmployee"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true">删除 </a>
	</div>
	
	<!-- 添加，编辑对话框 -->
	<div id="employeeDialog" class="easyui-dialog" title="保存用户"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#btns">
		<!-- 		加上employee.前缀 -->
		<form id="employeeForm" method="post" action="/employee/save">
			<input type="hidden" name="id">
			<table>
				<tr>
					<td>名称:</td>
					<td><input class="easyui-validatebox" type="text" name="name"
						data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>username:</td>
					<td><input class='easyui-validatebox' type='text'
						name='username'></input></td>
				</tr>
				<tr>
					<td>realName:</td>
					<td><input class='easyui-validatebox' type='text'
						name='realName'></input></td>
				</tr>
				<tr>
					<td>password:</td>
					<td><input class='easyui-validatebox' type='text'
						name='password'></input></td>
				</tr>
				<tr>
					<td>tel:</td>
					<td><input class='easyui-validatebox' type='text' name='tel'></input></td>
				</tr>
				<tr>
					<td>email:</td>
					<td><input class='easyui-validatebox' type='text' name='email'></input></td>
				</tr>
				<tr>
					<td>inputTime:</td>
					<td><input class='easyui-validatebox' type='text'
						name='inputTime'></input></td>
				</tr>
				<tr>
					<td>state:</td>
					<td><input class='easyui-validatebox' type='text' name='state'></input></td>
				</tr>
				<tr>
					<td>department.id:</td>
					<td><input class='easyui-validatebox' type='text'
						name='department.id'></input></td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 对话框按钮 -->
	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a id="saveBtn" href="javascript:void(0)" class="easyui-linkbutton">保存</a>
		<a id="closeBtn" href="javascript:void(0)" class="easyui-linkbutton">取消</a>
	</div>
	
</body>
</html>