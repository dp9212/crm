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
		var managerCombogrid = $('#managerCombogrid');
		var complexDeptSearchDialog = $('#complexDeptSearchDialog');

		//初始化部门经理选择组件
		var managerGrid = managerCombogrid.combogrid('grid');
		var managerPager = managerGrid.datagrid('getPager');
		managerPager.pagination({
			showPageList:false,
			showRefresh : false,
			displayMsg:''
		});
		// 初始化添加表单
		departmentForm.form({
			// 在表单提交前，做事情
			onSubmit : function() {
				return departmentForm.form("validate");
			},
			success : function(data) {
				// 把后台返回的json字符串转变成json对象
				data = $.parseJSON(data);
				// 判断结果
				if (data.success) {
					// 关对话框
					departmentDialog.dialog("close");
					$.messager.alert("温馨提示", data.msg, "info", function() {
						// 刷新表格
						departmentDataGrid.datagrid("reload");
					});
				}
			}
		});
		
		//创建命令对象封装不同函数
		var cmdObj = {
				create : function() {
					//修改对话框标题
					departmentDialog.dialog("setTitle", "部门添加面板")
					// 清空对话框
					departmentForm.form("clear");
					// 打开对话框
					departmentDialog.dialog("open");
				},
				edit : function() {
					//修改对话框标题
					departmentDialog.dialog("setTitle", "部门修改面板")
					// 获取选中行数据
					var rowData = departmentDataGrid.datagrid("getSelected");
					// 判断是否选中行
					if (!rowData) {
						$.messager.alert("温馨提示", "请选中一行数据！！", "info");
						return;
					}
					//清空原来的数据
					departmentForm.form("clear");
					// 特殊数据的额外处理
					// 部门经理
					if (rowData.manager) {
						rowData["manager.id"] = rowData.manager.id;
					}
					// 上级部门
					if (rowData.parent) {
						rowData["parent.id"] = rowData.parent.id;
					}
					// 加载数据：easyui form的load方法，遵循一个“同名匹配”的原则
					departmentForm.form("load", rowData);
					// 打开对话框
					departmentDialog.dialog("open");
				},
				del : function() {
					// 1.获取选中行信息
					var rowData = departmentDataGrid.datagrid("getSelected");
					// 2.判断
					if (!rowData) {
						$.messager.alert("温馨提示", "请选中一行数据！！");
						return;
					}
					$.messager.confirm("温馨提示","是否确认删除【" + rowData.name + "】部门??",	function(yes) {
						if (yes) {
							// 获取数据的唯一标示
							var id = rowData.id;
							// 发送AJAX请求，修改ID对应数据状态
							$.get("/department/delete?id="+ id,function(data) {
								if (data.success) {
									$.messager.alert("温馨提示",data.msg,	"info",function() {
											departmentDataGrid.datagrid("reload");
									});
								}
							}, "json");
						}
					});
				},
				refresh : function() {
					// 刷新表格
					departmentDataGrid.datagrid("reload");
				},
				save : function() {
					// 提交表单：自动调用上面的departmentForm.form方法
					//departmentForm.submit();
				},
				cancel : function() {
					// 关对话框
					departmentDialog.dialog("close");
				},
				simpleSearch : function(){
					var params = $('#simpleDeptSearchForm').serializeJson();
					if(params){
						departmentDataGrid.datagrid('load',params);
					}
				},
				complexDeptSearch :function(){
					var params = $('#complexDeptSearchForm').serializeJson();
					if(params){
						departmentDataGrid.datagrid('load',params);
						//关闭对话框
						complexDeptSearchDialog.dialog("close");
					}
				},
				cancelComplexDeptSearch:function(){
					complexDeptSearchDialog.dialog("close");
				},
				openComplexDeptSearchDlg:function(){
					// 打开对话框
					complexDeptSearchDialog.dialog("open");
				}
		};
		
		//统一监听按钮，绑定处理函数
		$('a[data-cmd]').on('click',function(){
			/* var cmd = $(this).attr('data-cmd');
			console.debug(cmd);
			if('create'==cmd){
				cmdObj.create();
			}else if('edit'==cmd){
				cmdObj.edit();
			} */
			
			var cmd = $(this).data('cmd');
			if(cmd){
				cmdObj[cmd]();
			}
			
		});
		
		
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
				<th data-options="field:'sn',width:10">编码</th>
				<th data-options="field:'manager',width:10" formatter="objectFormatter">经理</th>
				<th data-options="field:'parent',width:10" formatter="objectFormatter">上级部门</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a id="addDepartment" data-cmd="create" href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true">添加</a> <a data-cmd="edit" id="editDepartment"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true">编辑</a> <a data-cmd="del" id="deleteDepartment"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true">删除 </a>
			<div>
				<form id="simpleDeptSearchForm">
					关键字  <input type="text" name="keyword" /> 
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" data-cmd="simpleSearch">搜索</a> 
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" data-cmd="openComplexDeptSearchDlg">高级搜索</a> 
					
				</form>
			</div>
	</div>

	<div id="departmentDialog" class="easyui-dialog" title="保存用户"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#btns">
		<form id="departmentForm" method="post" action="/department/save">
			<input type="hidden" name="id"/>
			<table>
				<tr><td>名称:</td> <td><input class="easyui-validatebox" type="text" name="name" data-options="required:true"></input></td> </tr>
				<!-- <tr><td>编码:</td><td><input class='easyui-validatebox' type='text' name='sn' data-options="required:true"></input></td></tr>
				<tr><td>路径:</td><td><input class='easyui-validatebox' type='text' name='dirPath'></input></td></tr> -->
				<tr><td>经理:</td><td>
				<!-- <input class='easyui-validatebox' type='text' name='manager.id'></input> -->
				<!-- <input class='easyui-combobox' type='text' name='manager.id'
				data-options="
					url:'/employee/json',
					method:'get',
					valueField:'id',
					textField:'realName',
					panelHeight:'auto'
					"
				/> -->
				<select id="managerCombogrid" class="easyui-combogrid" name="manager.id"    style="width:173px;"  
		        data-options="    
		            panelWidth:350,
		            pagination:true,
		            idField:'id',    
		            textField:'realName',    
		            url:'/employee/json',    
		            columns:[[    
		                {field:'username',title:'登录名',width:60},    
		                {field:'realName',title:'姓名',width:60},    
		                {field:'tel',title:'电话',width:100} 
		            ]]    
		        "></select>  
				</td></tr>
				<tr><td>父级:</td><td>
				<!-- <input class='easyui-validatebox' type='text' name='parent.id'></input> -->
				<input class="easyui-combotree" name="parent.id" data-options="
				url:'/department/getTreeData',method:'get',required:true, panelHeight:'auto'" >
				
				</td></tr>
			</table>
		</form>
	</div>
	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a href="javascript:void(0)" class="easyui-linkbutton c3" data-cmd="save" 
			onclick="javascript:$('#departmentForm').submit();">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton" data-cmd="cancel" 
			onclick="$('#departmentDialog').dialog('close')">取消</a>
	</div>
	
	
	<div id="complexDeptSearchDialog" class="easyui-dialog" title="部门高级查询"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#complexDeptSearchDialogBtns">
		<form id="complexDeptSearchForm">
			<table>
				<tr><td>名称:</td> <td><input class="easyui-validatebox" type="text" name="name"></input></td> </tr>
				<tr><td>编码:</td><td><input class='easyui-validatebox' type='text' name='sn'></input></td></tr>
				<tr><td>经理:</td><td>
				<select id="managerCombogrid" class="easyui-combogrid" name="managerId"    style="width:147px;"  
		        data-options="    
		            panelWidth:300,
		            pagination:true,
		            idField:'id',    
		            textField:'realName',    
		            url:'/employee/json',    
		            columns:[[    
		                {field:'username',title:'登录名',width:80},    
		                {field:'realName',title:'姓名',width:80},    
		                {field:'tel',title:'电话',width:140} 
		            ]]    
		        "></select>  
				</td></tr>
				<tr><td>父级:</td><td>
				<input class="easyui-combotree" name="parentId" data-options="
				url:'/department/getTreeData',method:'get',required:true, panelHeight:'auto'" >
				</td></tr>
			</table>
		</form>
	</div>
	<div id="complexDeptSearchDialogBtns">
		<!--不要在href里面写js代码 -->
		<a href="javascript:void(0)" class="easyui-linkbutton c3" data-cmd="complexDeptSearch">查询</a> <a
			href="javascript:void(0)" class="easyui-linkbutton" data-cmd="cancelComplexDeptSearch">取消</a>
	</div>
</body>
</html>