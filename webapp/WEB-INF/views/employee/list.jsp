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
		var employeeSearchDlg = $("#complexSearchDialog");
		var employeeSearchForm = $("#employeeSearchForm");
		//按钮方法
		var cmdObj = {
			add : function(){
				employeeForm.form("clear");
				employeeDialog.dialog("open");
				//让状态默认为正常:只有用checked属性必须使用prop方法
				$("#state").prop("checked", true);
			},
			edit : function(){
				employeeForm.form("clear");//解决高级查询时部门回显错误
				var row = employeeDataGrid.datagrid("getSelected");
				if (row) {
					//加载本地数据
					if(row.department != null){
						row["department.id"]=row.department.id;
						employeeForm.form("load", row);
						employeeDialog.dialog("open");
					}
					if(row.department == null){
						employeeForm.form("load", row);
						employeeDialog.dialog("open");
					}
					
				} else {
					jQuery.messager.alert('警告信息', '请选中行，在修改!', 'warning');//警告
				}
			},
			del : function(){
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
			},
			leave : function(){//员工离职
				var row = employeeDataGrid.datagrid("getSelected");
				console.debug(row);
				if(row.state==-1){
					$.messager.alert('消息提示','员工已离职，请勿重复操作','warning');
					return ;
				}
				if (row) {
					$.messager.confirm("温馨提示","是否员工【" + row.username + "】离职",	function(yes) {
						if (yes) {
							//发出一个ajax请求去后台离职
							var url = "/employee/leave?id=" + row.id;
							jQuery.get(url, function(data) {
												if (data instanceof Object) {
													if (data.success) {//删除成功
														jQuery.messager.alert(
																		'消息提示',
																		'离职成功!',
																		'info',
																		function() {
																			//调用重新加载数据的方法
																			employeeDataGrid.datagrid("reload");
																		});//消息							
													}
												} else {
													jQuery.messager.alert(
															'错误提示',
															'后台出现异常',
															'error');
												}
											}, 'json');
						}
					});
					
				} else {
					jQuery.messager.alert('警告信息', '请选中行，再离职!', 'warning');//警告
				}
			},
			saveBtn : function(){
				$('#employeeForm').submit();
			},
			cancelBtn : function(){
				$('#employeeDialog').dialog('close');
			},
			showComplexSearchDlg : function(){
				//弹出高级查询对话框，清空数据
				employeeSearchForm.form("clear");
				employeeSearchDlg.dialog("open");
			},
			complexSearch : function(){
				//调用公共js的serializeJson(),获取高级查询框中的所有数据 序列化 提交
				employeeDataGrid.datagrid('load',employeeSearchForm.serializeJson());
				employeeSearchDlg.dialog("close");
			},
			complexSearchCancel : function(){
				employeeSearchDlg.dialog("close");
			}
		}
		//按钮 [ ] 从属性中选择
		$('[data-cmd]').click(function(){
			var cmd = $(this).data('cmd');
			cmdObj[cmd]();
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
	function simpleSearch(value,name){
		var value = $.trim(value);
		if(value){
			$("#employeeDataGrid").datagrid('load', {
			    "keyWord": value,
			    "dbSearcher" : name,
			}); 
		}
		//$("#simpleSearchBox").searchbox("reset");//重置搜索框的值
	}
</script>
</head>
<body>
	<!-- 表格数据 -->
	<table id="employeeDataGrid" class="easyui-datagrid"
		title="员工信息" fit="true" style="width: 700px; height: 250px"
		toolbar="#toolbar" rownumbers="true" pagination="true"
		pageList="[10,20,50]" fitColumns="true"
		data-options="singleSelect:true,url:'/employee/json',method:'get'">
		<thead>
			<tr>
				<!-- sortable="true" 开启排序 -->
				<th sortable="true" data-options="field:'id',width:10">编号</th>
				<th data-options="field:'username',width:10">登录名</th>
				<th data-options="field:'realName',width:10">姓名</th>
				<th data-options="field:'password',width:10">密码</th>
				<th data-options="field:'tel',width:10">电话</th>
				<th data-options="field:'email',width:10">邮箱</th>
				<th sortable="true" data-options="field:'inputTime',width:10,formatter:formatDateBoxFull">录入时间</th>
				<th sortable="true" data-options="field:'state',width:10" formatter="stateFormatter" >状态</th>
				<th data-options="field:'department',width:10,formatter:objectFormatter">所属部门</th>
			</tr>
		</thead>
	</table>
	
	<!-- 工具按钮 -->
	<div id="toolbar">
		<c:if test="${p:hasPermission('添加员工')}">
			<a data-cmd="add" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
		</c:if> 
		<a data-cmd="edit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a> 
		<a data-cmd="del" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除 </a>
		<a data-cmd="leave" href="javascript:void(0)" id="leave" class="easyui-linkbutton" iconCls="icon-edit" plain="true">离职</a>
		
		<!-- 搜索 -->
		<input id="simpleSearchBox" class="easyui-searchbox" style="width:200px" 
		data-options="searcher:simpleSearch,prompt:'请输入内容...',menu:'#mm'" ></input>
		<div id="mm" style="width:120px"> 
			<div data-options="name:'all',iconCls:'icon-ok'">全部</div> 
			<div data-options="name:'o.username',iconCls:'icon-ok'">登录名</div> 
			<div data-options="name:'o.realName',iconCls:'icon-ok'">姓名</div> 
			<div data-options="name:'o.tel',iconCls:'icon-ok'">电话</div> 
		</div>
		
		<!-- 高级搜索 -->
		<a data-cmd="showComplexSearchDlg" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true">高级查询 </a>
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
					<td>登录名:</td>
					<td><input class='easyui-validatebox' type='text'
						name='username'></input></td>
				</tr>
				<tr>
					<td>姓名:</td>
					<td><input class='easyui-validatebox' type='text'
						name='realName'></input></td>
				</tr>
				<tr>
					<td>密码:</td>
					<td><input class='easyui-validatebox' type='text'
						name='password'></input></td>
				</tr>
				<tr>
					<td>电话:</td>
					<td><input class='easyui-validatebox' type='text' name='tel'></input></td>
				</tr>
				<tr>
					<td>邮箱:</td>
					<td><input class='easyui-validatebox' type='text' name='email'></input></td>
				</tr>
				<tr>
					<td>状态:</td>
					<td>
						<!-- <input class='easyui-validatebox' type='text' name='state'></input> -->
						<input id="state" type="radio" name="state" value="0">正常 <input type="radio" name="state" value="-1">离职
					</td>
				</tr>
				<!-- <tr>
					<td>部门名称:</td>
					<td>
						<input class="easyui-combobox" name="department.id" 
						data-options="valueField:'id',textField:'name',url:'/department/getListData'" />
					</td>
				</tr> -->
				<tr>
					<td>部门名称:</td>
					<td>
						<select  class="easyui-combogrid" name="department.id" style="width:147px;"   
					        data-options="    
					            panelWidth:270,    
					            idField:'id',    
					            textField:'name',    
					            url:'/department/getListData',    
					            columns:[[    
					                {field:'id',title:'部门编号',width:65},    
					                {field:'name',title:'部门名称',width:100},    
					                {field:'manager',title:'部门经理',width:100,formatter:objectFormatter},    
					            ]]">
				        </select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 对话框按钮 -->
	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a data-cmd="saveBtn" href="javascript:void(0)" class="easyui-linkbutton">保存</a>
		<a data-cmd="cancelBtn" href="javascript:void(0)" class="easyui-linkbutton">取消</a>
	</div>
	
	<!-- 高级查询对话框 -->
	<div id="complexSearchDialog" class="easyui-dialog" title="高级查询"
		data-options="iconCls:'icon-search',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#searchbtns">
		<!-- 		加上employee.前缀 -->
		<form id="employeeSearchForm">
			<table>
				<tr>
					<td>登录名:</td>
					<td><input class='easyui-validatebox' type='text'
						name='username'></input></td>
				</tr>
				<tr>
					<td>姓名:</td>
					<td><input class='easyui-validatebox' type='text'
						name='realName'></input></td>
				</tr>
				<tr>
					<td>电话:</td>
					<td><input class='easyui-validatebox' type='text' name='tel'></input></td>
				</tr>
				<tr>
					<td>邮箱:</td>
					<td><input class='easyui-validatebox' type='text' name='email'></input></td>
				</tr>
				<tr>
					<td>状态:</td>
					<td>
						<input type="radio" name="state" value="0">正常 <input type="radio" name="state" value="-1">离职
					</td>
				</tr>
				<tr>
					<td>部门名称:</td>
					<td>
						<select  class="easyui-combogrid" name="departmentId" style="width:147px;"   
					        data-options="    
					            panelWidth:270,    
					            idField:'id',    
					            textField:'name',    
					            url:'/department/getListData',    
					            columns:[[    
					                {field:'id',title:'部门编号',width:65},    
					                {field:'name',title:'部门名称',width:100},    
					                {field:'manager',title:'部门经理',width:100,formatter:objectFormatter},    
					            ]]">
				        </select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 高级查询对话框按钮 -->
	<div id="searchbtns">
		<a data-cmd="complexSearch" href="javascript:void(0)" class="easyui-linkbutton">搜索</a>
		<a data-cmd="complexSearchCancel" href="javascript:void(0)" class="easyui-linkbutton">取消</a>
	</div>
</body>
</html>