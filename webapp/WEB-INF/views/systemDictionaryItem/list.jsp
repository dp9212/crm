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
		var systemDictionaryItemDialog = $("#systemDictionaryItemDialog");
		var systemDictionaryItemForm = $("#systemDictionaryItemForm");
		var systemDictionaryItemDataGrid = $("#systemDictionaryItemDataGrid");

		var cmdObj = {
			create : function(){//添加
				systemDictionaryItemForm.form("clear");
				systemDictionaryItemDialog.dialog("open");
			},
			edit : function(){//编辑
				var row = systemDictionaryItemDataGrid.datagrid("getSelected");
				console.debug(row);
				if (row) {
					//加载本地数据
					systemDictionaryItemForm.form("load", row);
					systemDictionaryItemDialog.dialog("open");
				} else {
					jQuery.messager.alert('警告信息', '请选中行，在修改!', 'warning');//警告
				}
			},
			simpleSearch : function(){
				var params = $('#simpleEmpSearchForm').serializeJson();
				if(params){
					systemDictionaryItemDataGrid.datagrid('load',params);
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
		
		systemDictionaryItemForm.form({
			success : function(data) {
				data = jQuery.parseJSON(data);
				if (data.success) {
					systemDictionaryItemDialog.dialog("close");
					systemDictionaryItemDataGrid.datagrid("reload");
				} else {
					jQuery.messager.alert('Error', data.msg, 'error');
				}
			}
		});
	});
	
	
</script>
</head>
<body>
	<table id="systemDictionaryItemDataGrid" class="easyui-datagrid" title="字典项"
		fit="true" style="width: 700px; height: 250px" toolbar="#toolbar" 
		rownumbers="true" pagination="true" pageList="[10,20,50]"
		fitColumns="true"  
		data-options="singleSelect:true,url:'/systemDictionaryItem/json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:10">ID</th>
				<th data-options="field:'name',width:20">名称</th>
				<th data-options="field:'intro',width:20">简介</th>
				<th data-options="field:'sequence',width:10">序号</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a id="addsystemDictionaryItem" href="javascript:void(0)" class="easyui-linkbutton" data-cmd="create" 
			iconCls="icon-add" plain="true">添加</a> <a id="editsystemDictionaryItem"  data-cmd="edit"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true">编辑</a> 
			<div>
				<form id="simpleEmpSearchForm">
					关键字  <input type="text" name="keyword" /> 
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" data-cmd="simpleSearch">搜索</a> 
				</form>
			</div>
	</div>

	<div id="systemDictionaryItemDialog" class="easyui-dialog" title="保存字典项"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#btns">
		<form id="systemDictionaryItemForm" method="post" action="/systemDictionaryItem/save">
			<input type="hidden" name="id" />
			<input type="hidden" name="parent.id" />
			<table>
				<tr>
					<td>名称:</td>
					<td><input class="easyui-validatebox" type="text" name="name"
						data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>简介:</td>
					<td><input class="easyui-validatebox" type="text" name="intro"></input></td>
				</tr>
				<tr>
					<td>序号:</td>
					<td><input class="easyui-validatebox" type="text" name="sequence"></input></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#systemDictionaryItemForm').submit();">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="$('#systemDictionaryItemDialog').dialog('close')">取消</a>
	</div>
</body>
</html>