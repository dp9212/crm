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
		var roleDialog = $("#roleDialog");
		var roleForm = $("#roleForm");
		var roleDataGrid = $("#roleDataGrid");
		
		var selectedPermissionDlg = $('#selectedPermissionDlg');
		var allPermissionDlg = $('#allPermissionDlg');

		allPermissionDlg.datagrid({
		    url:'/permission/json',
		    title:'所有权限',
		    pagination:true,
		    width:500,
		    height:300,
		    singleSelect:true,
		    columns:[[
		        {field:'id',title:'ID',width:100},    
		        {field:'name',title:'资源名',width:100},
		        {field:'resource',title:'资源',width:100},
		        {field:'state',title:'状态',width:100}
		    ]],
		    onDblClickRow : function(rowIndex, rowData){
		    	//console.debug(rowData);
		    	var rows = selectedPermissionDlg.datagrid('getRows');
		    	if(rows && rows.length>0){
		    		for(var i=0;i<rows.length;i++){
		    			if(rowData.id == rows[i].id){
		    				$.messager.alert('友情提示','请不要重复选择权限','info');
		    				return ;
		    			}
		    		}
		    	}
		    	selectedPermissionDlg.datagrid('appendRow',rowData);
		    }
		});
		
		selectedPermissionDlg.datagrid({
		    title:'已选权限',
		    width:300,
		    height:300,
		    columns:[[
		        {field:'id',title:'ID',width:100},    
		        {field:'name',title:'角色名',width:100}
		    ]],
		    onDblClickRow : function(rowIndex, rowData){
		    	selectedPermissionDlg.datagrid('deleteRow',rowIndex);
		    }
		});
		
		var cmdObj = {
			create : function(){//添加
				roleForm.form("clear");
				roleDialog.dialog("open");
				selectedPermissionDlg.datagrid('loadData',{ total: 0, rows: []});
			},
			edit : function(){//编辑
				var  existRP= { total: 0, rows: []};
				selectedPermissionDlg.datagrid('loadData',{ total: 0, rows: []});
				var row = roleDataGrid.datagrid("getSelected");
				if (row) {
					//加载本地数据
					roleForm.form("load", row);
					roleDialog.dialog("open");
					$.get('/permission/json',{roleId:row.id},function(data){
						console.debug(data);
						existRP = data;
						selectedPermissionDlg.datagrid('loadData',existRP);
					});
				} else {
					jQuery.messager.alert('警告信息', '请选中行再修改!', 'warning');//警告
				}
			},
			simpleSearch : function(){
				var params = $('#simpleSearchForm').serializeJson();
				if(params){
					roleDataGrid.datagrid('load',params);
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
		
		roleForm.form({
			onSubmit : function(params){
				var rows = selectedPermissionDlg.datagrid('getRows');
		    	if(rows && rows.length>0){
		    		for(var i=0;i<rows.length;i++){
						params['permissions['+i+'].id']=rows[i].id;
		    		}
		    	}
			},
			success : function(data) {
				console.debug(typeof data);
				data = jQuery.parseJSON(data);
				if (data.success) {
					roleDialog.dialog("close");
					roleDataGrid.datagrid("reload");
				} else {
					jQuery.messager.alert('Error', data.msg, 'error');
				}
			}
		});
		
		
		
	});
	
	
</script>
</head>
<body>
	<table id="roleDataGrid" class="easyui-datagrid" title="角色"
		fit="true" style="width: 700px; height: 250px" toolbar="#toolbar" 
		rownumbers="true" pagination="true" pageList="[10,20,50]"
		fitColumns="true"  
		data-options="singleSelect:true,url:'/role/json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:10">ID</th>
				<th data-options="field:'name',width:20">名称</th>
				<th data-options="field:'sn',width:20">编号</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a id="addrole" href="javascript:void(0)" class="easyui-linkbutton" data-cmd="create" 
			iconCls="icon-add" plain="true">添加</a> <a id="editrole"  data-cmd="edit"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true">编辑</a> 
	</div>

	<div id="roleDialog" class="easyui-dialog" title="保存角色"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 900px; height: 450px; padding: 20px" buttons="#btns">
		<form id="roleForm" method="post" action="/role/save">
			<input type="hidden" name="id" />
			<table>
				<tr>
					<td colspan="2">名称:<input class="easyui-validatebox" type="text" name="name"
						data-options="required:true"/>
						SN:<input class="easyui-validatebox" type="text" name="sn"/>
						</td>
				</tr>
				<tr>
					<td><table id="selectedPermissionDlg"></table></td>
					<td><table id="allPermissionDlg"></table></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#roleForm').submit();">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="$('#roleDialog').dialog('close')">取消</a>
	</div>
</body>
</html>