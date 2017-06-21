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
		var potentialCustomerDialog = $("#potentialCustomerDialog");
		var potentialCustomerForm = $("#potentialCustomerForm");
		var potentialCustomerDataGrid = $("#potentialCustomerDataGrid");

		//添加用户
		$("#addPotentialCustomer").on("click", function() {
			var row = {};
			var now = formatDateBoxFull(new Date());
			console.debug(now);
			row.inputTime = now;
			potentialCustomerForm.form("clear");
			potentialCustomerForm.form("load", row);
			potentialCustomerDialog.dialog("open");
		});

		//编辑用户
		$("#editPotentialCustomer").on("click", function() {
			var row = potentialCustomerDataGrid.datagrid("getSelected");
			console.debug(row);
			if (row) {
				//加载本地数据
				potentialCustomerForm.form("load", row);
				potentialCustomerDialog.dialog("open");
			} else {
				jQuery.messager.alert('警告信息', '请选中行，在修改!', 'warning');//警告
			}
		});

		//删除用户
		$("#deletePotentialCustomer")
				.on(
						"click",
						function() {
							var row = potentialCustomerDataGrid.datagrid("getSelected");
							console.debug(row);
							if (row) {
								//发出一个ajax请求去后台删除
								var url = "/potentialCustomer/delete?id=" + row.id;
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
																				potentialCustomerDataGrid
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
		//onclick="javascript:$('#potentialCustomerForm').submit();">保存</a>
		potentialCustomerForm.form({
			//数据提交成功后执行 (不管操作是否成功或失败).
			success : function(data) {
				//data 是一个json字符串,我们需要通过jQuery.parseJSON转换为JSON对象.
				data = jQuery.parseJSON(data);
				if (data.success) {
					//弹出窗体dialog必须关闭
					potentialCustomerDialog.dialog("close");
					//调用重新加载数据的方法
					potentialCustomerDataGrid.datagrid("reload");
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
	<table id="potentialCustomerDataGrid" class="easyui-datagrid" title="Basic DataGrid"
		fit="true" style="width: 700px; height: 250px" toolbar="#toolbar"
		rownumbers="true" pagination="true" pageList="[10,20,50]"
		fitColumns="true"
		data-options="singleSelect:true,url:'/potentialCustomer/json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:10">编号</th>
				<th data-options="field:'customerSource',width:10">客户来源</th>
				<th data-options="field:'name',width:10">名称</th>
				<th data-options="field:'successRate',width:10">开发可能性</th>
				<th data-options="field:'remark',width:10">客户描述</th>
				<th data-options="field:'linkMan',width:10">联系人</th>
				<th data-options="field:'linkManTel',width:10">联系电话</th>
				<th data-options="field:'inputUser',width:10">创建人</th>
				<th data-options="field:'inputTime',width:10">创建 时间</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a id="addPotentialCustomer" href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true">添加</a> <a id="editPotentialCustomer"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true">编辑</a> <a id="deletePotentialCustomer"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true">删除 </a>
	</div>

	<div id="potentialCustomerDialog" class="easyui-dialog" title="保存用户"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 450px; height: auto; padding: 35px" buttons="#btns">
		<!-- 		加上potentialCustomer.前缀 -->
		<form id="potentialCustomerForm" method="post" action="/potentialCustomer/save">
			<input type="hidden" name="id">
			<table>
				<tr>
					<td>客户来源:</td>
					<td><input class="easyui-validatebox" type="text" name="customerSource"
						data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>名称:</td>
					<td>
						<input class='easyui-validatebox' type='text'name='name'></input>
						

					</td>
				</tr>
				<tr>
					<td><p>开发可能性 :</p></td>
					<td>
					<input class="easyui-slider" value="50" data-options="showTip:true" style="width: 100%;" name="successRate"/>%
						</td>
				</tr>
				<tr>
					<td>客户描述:</td>
					<td><input class='easyui-validatebox' type='text'
						name='remark'></input></td>
				</tr>
				<tr>
					<td>联系人:</td>
					<td><input class='easyui-validatebox' type='text' name='linkMan'></input></td>
				</tr>
				<tr>
					<td>联系电话:</td>
					<td><input class='easyui-validatebox' type='text' name='linkManTel'></input></td>
				</tr>
				<tr>
					<td>创建人:</td>
					<td><input class='easyui-validatebox' type='text' name='linkManTel' name="inputUser"></input></td>
				</tr>
				<tr>
					<td>创建时间:</td>
					<!-- readonly="readonly" 只读属性 -->
					<td><input  id="dd"  type= "text" class= "easyui-datebox" readonly="readonly" currentText="Today" name="inputTime"> </input></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#potentialCustomerForm').submit();">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="$('#potentialCustomerDialog').dialog('close')">取消</a>
	</div>
</body>
</html>