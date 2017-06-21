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
		var menuDialog = $("#menuDialog");
		var menuForm = $("#menuForm");
		var menuDataGrid = $("#menuDataGrid");

		var cmdObj = {
			create : function(){//添加
				menuForm.form("clear");
				menuDialog.dialog("open");
			},
			edit : function(){//编辑
				var row = menuDataGrid.datagrid("getSelected");
				console.debug(row);
				if (row) {
					//加载本地数据
					menuForm.form("load", row);
					menuDialog.dialog("open");
				} else {
					jQuery.messager.alert('警告信息', '请选中行，在修改!', 'warning');//警告
				}
			},
			del : function(){ //删除
				var row = menuDataGrid.datagrid("getSelected");
				console.debug(row);
				if (row) {
					//发出一个ajax请求去后台删除
					var url = "/menu/delete?id=" + row.id;
					jQuery.get(
									url,
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
																	menuDataGrid
																			.datagrid("reload");
																});//消息							
											}else{
												$.messager.alert('消息提示',data.msg,'info');
											}
										} else {
											jQuery.messager.alert(
													'错误提示',
													'后台出现异常',
													'error');
										}
									}, 'json');
				} else {
					jQuery.messager.alert('警告信息', '请选中行，在删除!', 'warning');//警告
				}
			},
			simpleSearch : function(){
				
				var params = $('#simpleEmpSearchForm').serializeJson();
				if(params){
					menuDataGrid.datagrid('load',params);
				}
			}
		};
		
		
		$('a[data-cmd]').on('click',function(){
			if($(this).hasClass('l-btn-disabled')){
				return ;
			}
			var cmd = $(this).data('cmd');
			if(cmd){
				cmdObj[cmd]();
			}
		});
		
		//easyui 把一个普通的表单的提交方式,修改为ajax提交.
		//<a href="javascript:void(0)" class="easyui-linkbutton" 
		//onclick="javascript:$('#menuForm').submit();">保存</a>
		menuForm.form({
			//数据提交成功后执行 (不管操作是否成功或失败).
			success : function(data) {
				//data 是一个json字符串,我们需要通过jQuery.parseJSON转换为JSON对象.
				data = jQuery.parseJSON(data);
				if (data.success) {
					//弹出窗体dialog必须关闭
					menuDialog.dialog("close");
					//调用重新加载数据的方法
					menuDataGrid.datagrid("reload");
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
	<table id="menuDataGrid" class="easyui-datagrid" title="Basic DataGrid"
		fit="true" style="width: 700px; height: 250px" toolbar="#toolbar" 
		rownumbers="true" pagination="true" pageList="[10,20,50]"
		fitColumns="true"  
		data-options="singleSelect:true,url:'/menu/json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:10">编号</th>
				<th data-options="field:'name',width:10">名称</th>
				<th data-options="field:'sn',width:10">编号</th>
				<th data-options="field:'icon',width:10">图标</th>
				<th data-options="field:'intro',width:10">介绍</th>
				<th data-options="field:'url',width:10">路径</th>
				<th data-options="field:'parent',width:10" formatter="objectFormatter">父菜单</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a id="addEmployee" href="javascript:void(0)" class="easyui-linkbutton" data-cmd="create" 
			iconCls="icon-add" plain="true">添加</a> <a id="editEmployee"  data-cmd="edit"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true">编辑</a> 
			<a id="deleteEmployee"  data-cmd="del" href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true">删除 </a>
			
			<div>
				<form id="simpleEmpSearchForm">
					关键字  <input type="text" name="keyword" /> 
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" data-cmd="simpleSearch">搜索</a> 
				</form>
			</div>
	</div>

	<div id="menuDialog" class="easyui-dialog" title="保存"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#btns">
		<!-- 		加上menu.前缀 -->
		<form id="menuForm" method="post" action="/menu/save">
			<input type="hidden" name="id">
			<table>
				<tr>
					<td>名称:</td>
					<td><input class="easyui-validatebox" type="text" name="name"
						data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>SN:</td>
					<td><input class="easyui-validatebox" type="text" name="sn"
						data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>图标:</td>
					<td><input class="easyui-validatebox" type="text" name="icon"
						data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>介绍:</td>
					<td><input class="easyui-validatebox" type="text" name="intro"
						data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>URL:</td>
					<td><input class="easyui-validatebox" type="text" name="url"
						data-options="required:true"></input></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#menuForm').submit();">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="$('#menuDialog').dialog('close')">取消</a>
	</div>
</body>
</html>