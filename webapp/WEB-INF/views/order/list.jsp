<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<html>
<head>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript" src="/static/easyui/datagrid-detailview.js"></script>
<script type="text/javascript">
	$(function() {
		var customerCombo = $('input[data-cus="customer"]').combogrid({
			panelWidth : 250,
			valueField:'id',
			textField : 'name',
			url : '/customer/json',
			columns : [ [ {
				field : 'id',
				title : '编号',
				width : 120
			}, {
				field : 'name',
				title : '客户',
				width : 120
			} ] ]
		});

		var sellerConbo = $('input[data-sel="seller"]').combogrid({
			panelWidth : 240,
			valueField:'id',
			textField : 'realName',
			url : '/employee/json',
			onSelect: function(rec){    
				console.debug(rec.id);                
		    },
			columns : [ [ {
				field : 'id',
				title : '编号',
				width : 120
			},{
				field : 'realName',
				title : '员工',
				width : 120
			} ] ]
		});
		var contractDialog = $("#contractDialog");
		var contractForm = $("#contractForm");
		var contractDataGrid = $("#contractDataGrid");
		var addcontractitemDialog = $("#addcontractitemDialog");
		var addcontractitemForm = $("#addcontractitemForm");
		var addcontractitemDataGrid = $("#addcontractitemDataGrid");
		var cmdObj = {
			create : function() {
				contractDialog.dialog("setTitle", "新建订单");
				addcontractitemDataGrid.datagrid('loadData',{total:0,rows:[]});
				contractForm.form("clear");
				contractDialog.dialog("center", true);
				contractDialog.dialog("open");
			},
			edit : function() {
				addcontractitemDialog.dialog("setTitle", "编辑合同")
				var rows = contractDataGrid.datagrid("getSelected");
				//获取对应的明细
				if (!rows) {
					$.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				contractForm.form("clear");
				if (rows.manager) {
					rowData["manager.id"] = rows.manager.id;
				}
				if (rows.parent) {
					rows["parent.id"] = rows.parent.id;
				}
				if (rows.customer) {
					rows["customer.name"] = rows.customer.name;
				}
				if (rows.customer) {
					rows["customer.id"] = rows.customer.id;
				}
				if (rows.seller) {
					rows["seller.realName"] = rows.seller.realName;
				}
				if (rows.seller) {
					rows["seller.id"] = rows.seller.id;
				}
				contractForm.form("load", rows);
				customerCombo.combogrid('setValue', rows.customer.id);
				sellerConbo.combogrid('setValue', rows.seller.id);
				contractDialog.dialog("open");
				
				var keyWord = $("#key").val();
				keyWord = $.trim(keyWord);
				if (keyWord!=null && keyWord!="") {
					addcontractitemDataGrid.datagrid('load', {
						"keyWord" : keyWord
					});
				}
			},
			del : function() {
				//拿到行数据
				var rowData = contractDataGrid.datagrid("getSelected");
				if (rowData) {
					var url = "/order/delete?id=" + rowData.id;
					jQuery.get(url,function(data) {
						console.debug(data);
						if (data instanceof Object) {
							if (data.success) {
								jQuery.messager.alert('消息提示','删除成功!','info',function() {
									//调用重新加载数据的方法
									contractDataGrid.datagrid("reload");
								});//消息							
							}
						} else {
							jQuery.messager.alert('错误提示','后台出现异常', 'error');
							}
						}, 'json');
				} else {
					jQuery.messager.alert('警告信息', '请选中行，在删除!', 'warning');
				}
			},
			refresh : function() {
				// 刷新表格
				contractDataGrid.datagrid("reload");
			},
			save : function() {
				$('#contractForm').submit();
			},
			cancel : function() {
				contractDialog.dialog("close");
			},
			simpleSearch : function() {
				var keyWord = $("#keyWord").val();
				keyWord = $.trim(keyWord);
				if (keyWord) {
					contractDataGrid.datagrid('load', {
						"keyWord" : keyWord
					});
				}
			},
			print : function() {
				location.href = "/print.jsp";
			}
		};
		$('a[data-cmd]').on('click', function() {
			var cmd = $(this).data('cmd');
			if (cmd) {
				cmdObj[cmd]();
			}
		});
		// 初始化添加表单
		contractForm.form({
			// 在表单提交前，做事情
			onSubmit : function() {
				return contractForm.form("validate");
			},
			success : function(data) {
				//alert(data);
				//data 是一个json字符串,我们需要通过jQuery.parseJSON转换为JSON对象.
				datas = jQuery.parseJSON(data);
				if (datas.success) {
					//弹出窗体dialog必须关闭
					contractDialog.dialog("close");
					//调用重新加载数据的方法
					contractDataGrid.datagrid("reload");
				} else {
					jQuery.messager.alert('Error', data.msg, 'error');
				}
			}
		});
		addcontractitemForm.form({
			// 在表单提交前，做事情
			onSubmit : function() {
				return addcontractitemForm.form("validate");
			},
			success : function(data) {
				alert(data);
				//data 是一个json字符串,我们需要通过jQuery.parseJSON转换为JSON对象.
				datas = jQuery.parseJSON(data);
				if (datas.success) {
					//弹出窗体dialog必须关闭
					addcontractitemDialog.dialog("close");
					//调用重新加载数据的方法
					addcontractitemDataGrid.datagrid("reload");
				} else {
					jQuery.messager.alert('Error', data.msg, 'error');
				}
			}
		});
		
	});
	//处理支付
	function formatisPayment(value, row, index) {
		return value == true ? "已支付" : "未支付";
	}
	
</script>

</head>

<body>
	<!-- 添加、修改、删除按钮 -->
	<div id="contractBtn">
		<a data-cmd="create" class="easyui-linkbutton" iconCls="icon-add"
			plain="true">添加</a> <a data-cmd="edit" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true">编辑</a> <a data-cmd="del"
			class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除 </a>
		 <span> 订单单号: <input id="keyWord" /> <a
			data-cmd="simpleSearch" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索 </a>
		</span>
	</div>
	<!-- 合同表单 -->
	<table id="contractDataGrid" class="easyui-datagrid" style="width: 700px; height: 250px"
		fit="true" toolbar="#contractBtn" pagination="true" title="合同信息"
		singleSelect="true" rownumbers="true" fitColumns="true"
		data-options="singleSelect:true,url:'/order/json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:80" align="center">ID</th>
				<th data-options="field:'sn',width:100" align="center">订单单号</th>
				<th data-options="field:'signTime',width:100"
					align="center">交易时间</th>
				<th data-options="field:'sum',width:100">交易定金</th>
				<th data-options="field:'customer',width:100"
					align="center" formatter="objectFormatter">订单客户</th>
				<th data-options="field:'seller',width:100" align="center"
					formatter="objectFormatter">营销人员</th>
			</tr>
		</thead>
	</table>
	<!-- 添加新订单 -->
	<div id="contractDialog" class="easyui-dialog" title="添加订单"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 320px; height: 250px; padding: 20px" buttons="#btns">
		<form id="contractForm" method="post" action="/order/save">
			<input id="key" type="hidden" name="id" />
			<table>
				
				<tr>
					<td><div
							style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">订单基本信息</div></td>
				</tr>
				<tr>
					<td>订单单号:</td>
					<td><input class="easyui-validatebox" type="text" name="sn"
					required="true"/>
				</tr>
				<tr>
					<td>订单客户:</td>
					<td><input class="easyui-combobox" type="text"
						data-cus="customer" required="true" name="customer.id"></input></td>
				</tr>
				<tr>
					<td>营销人员:</td>
					<td><input class="easyui-combobox" type="text"
						data-sel="seller" required="true" name="seller.id"></input></td>
				</tr>
				<tr>
					<td>定金金额:</td>
					<td><input class="easyui-validatebox" type="text" name="sum"></input></td>
				</tr>
		</form>
	</div>
	<!-- 订单的保存按钮-->
	<div id="btns">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-cmd="save">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-cmd="cancel">取消</a>
	</div>
</body>
</html>