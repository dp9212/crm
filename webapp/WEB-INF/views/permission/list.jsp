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
		var permissionDialog = $("#permissionDialog");
		var permissionForm = $("#permissionForm");
		var permissionDataGrid = $("#permissionDataGrid");

		var cmdObj = {
			create : function(){//添加
				permissionForm.form("clear");
				permissionDialog.dialog("open");
			},
			edit : function(){//编辑
				var row = permissionDataGrid.datagrid("getSelected");
				console.debug(row);
				if (row) {
					//加载本地数据
					permissionForm.form("load", row);
					permissionDialog.dialog("open");
				} else {
					jQuery.messager.alert('警告信息', '请选中行再修改!', 'warning');//警告
				}
			},
			simpleSearch : function(){
				var params = $('#simpleSearchForm').serializeJson();
				if(params){
					permissionDataGrid.datagrid('load',params);
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
		
		permissionForm.form({
			success : function(data) {
				data = jQuery.parseJSON(data);
				if (data.success) {
					permissionDialog.dialog("close");
					permissionDataGrid.datagrid("reload");
				} else {
					jQuery.messager.alert('Error', data.msg, 'error');
				}
			}
		});
	});
	
	
</script>
</head>
<body>
	<table id="permissionDataGrid" class="easyui-datagrid" title="权限"
		fit="true" style="width: 700px; height: 250px" toolbar="#toolbar" 
		rownumbers="true" pagination="true" pageList="[10,20,50]"
		fitColumns="true"  
		data-options="singleSelect:true,url:'/permission/json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:10">ID</th>
				<th data-options="field:'name',width:20">名称</th>
				<th data-options="field:'resource',width:20">资源</th>
				<th data-options="field:'state',width:20">加锁</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a id="addpermission" href="javascript:void(0)" class="easyui-linkbutton" data-cmd="create" 
			iconCls="icon-add" plain="true">添加</a> <a id="editpermission"  data-cmd="edit"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true">编辑</a> 
	</div>

	<div id="permissionDialog" class="easyui-dialog" title="保存权限"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#btns">
		<form id="permissionForm" method="post" action="/permission/save">
			<input type="hidden" name="id" />
			<table>
				<tr>
					<td>名称:</td>
					<td><input class="easyui-validatebox" type="text" name="name"
						data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>资源:</td>
					<td><input class="easyui-validatebox" type="text" name="resource"></input></td>
				</tr>
				<tr>
					<td>是否加锁:</td>
					<td>
						<select name="state" class="easyui-combobox">
							<option value="1">加锁</option>
							<option value="0">不加锁</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#permissionForm').submit();">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="$('#permissionDialog').dialog('close')">取消</a>
	</div>
</body>
</html>