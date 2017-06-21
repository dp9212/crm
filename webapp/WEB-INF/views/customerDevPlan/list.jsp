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
		var customerDevPlanDialog = $("#customerDevPlanDialog");
		var customerDevPlanForm = $("#customerDevPlanForm");
		var customerDevPlanDataGrid = $("#customerDevPlanDataGrid");
// 		customerDevPlanDialog
		//添加用户
		$("#addCustomerDevPlan").on("click", function() {
			customerDevPlanForm.form("clear");
			customerDevPlanDialog.dialog("open");
			
		});

		//编辑用户
		$("#editcustomerDevPlan").on("click", function() {
			var row = customerDevPlanDataGrid.datagrid("getSelected");
			console.debug(row);
			if (row) {
				//加载本地数据
				customerDevPlanForm.form("load", row);
				customerDevPlanDialog.dialog("open");
			} else {
				jQuery.messager.alert('警告信息', '请选中行，在修改!', 'warning');//警告
			}
		});

		//删除用户
		
	$("#deletecustomerDevPlan").on(
				"click",
				function() {
					var row = customerDevPlanDataGrid.datagrid("getSelected");
					console.debug(row);
					if (row) {
						//发出一个ajax请求去后台删除
						var url = "/customerDevPlan/delete?id=" + row.id;
						jQuery.get(url, function(data) {
							console.debug(data);
							if (data instanceof Object) {
								if (data.success) {//删除成功
									jQuery.messager.alert('消息提示', '删除成功!',
											'info', function() {
												//调用重新加载数据的方法
												customerDevPlanDataGrid
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

		//easyui 把一个普通的表单的提交方式,修改为ajax提交.
		//<a href="javascript:void(0)" class="easyui-linkbutton" 
		//onclick="javascript:$('#customerDevPlanForm').submit();">保存</a>
		customerDevPlanForm.form({
			//数据提交成功后执行 (不管操作是否成功或失败).
			success : function(data) {
				//data 是一个json字符串,我们需要通过jQuery.parseJSON转换为JSON对象.
				data = jQuery.parseJSON(data);
				if (data.success) {
					//弹出窗体dialog必须关闭
					customerDevPlanDialog.dialog("close");
					//调用重新加载数据的方法
					customerDevPlanDataGrid.datagrid("reload");
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
	<table id="customerDevPlanDataGrid" class="easyui-datagrid" title="Basic DataGrid"
		fit="true" style="width: 700px; height: 250px" toolbar="#toolbar"
		rownumbers="true" pagination="true" pageList="[10,20,50]"
		fitColumns="true"
		data-options="singleSelect:true,url:'/customerDevPlan/json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:10">编号</th>
				<th data-options="field:'planTime',width:10" >
				计划时间</th>
				<th data-options="field:'planSubject',width:10">计划主题</th>
				<th data-options="field:'planType',width:10">计划实施方式</th>
				<th data-options="field:'potentialCustomer',width:10">潜在客户</th>
				<th data-options="field:'inputUser',width:10">创建人</th>
				<th data-options="field:'inputTime',width:10">创建时间</th>
		</thead>
	</table>
	<div id="toolbar">
		<a id="addCustomerDevPlan" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
		<a id="editcustomerDevPlan" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a> 
		<a id="deletecustomerDevPlan" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除 </a>
	</div>

	<div id="customerDevPlanDialog" class="easyui-dialog" title="保存用户"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#btns">
		<!-- 		加上customerDevPlan.前缀 -->
		<form id="customerDevPlanForm" method="post" action="/customerDevPlan/save">
			<input type="hidden" name="id">
			<table>
				<tr>
					<td>计划时间:</td>
					<td>
					<input type="text" class="easyui-datebox" name="planTime"></input>
					</td>
				</tr>
				<tr>
				<td>计划主题:</td>
				<td>
				<input class='easyui-validatebox' type='text' name='planSubject' required="required"></input>
				</td></tr>
				<tr><td>计划内容:</td><td><input class='easyui-validatebox' type='text' name='planDetails' required="required"></input>
				
				</td></tr>
				<tr><td>潜在客户:</td><td><input class='easyui-validatebox' type='text' name='potentialCustomer' required="required"></input>
				
				</td></tr>
				<tr><td>创建人:</td><td><input class='easyui-validatebox' type='text' name='inputUser' required="required"></input>
				
				</td></tr>
				<tr><td>创建时间:</td><td><input class='easyui-validatebox' type='text' name='inputTime' required="required"></input>
				
				</td></tr>
			</table>
		</form>
	</div>
	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#customerDevPlanForm').submit();">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="$('#customerDevPlanDialog').dialog('close')">取消</a>
	</div>
</body>
</html>