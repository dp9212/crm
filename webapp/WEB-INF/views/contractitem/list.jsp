<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工信息</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">
	function contractformatter(value) {
		return value.sn;
	}
	$(function() {
		//公用的对象
		var contractitemDialog = $("#contractitemDialog");
		var contractitemForm = $("#contractitemForm");
		var contractitemDataGrid = $("#contractitemDataGrid");
		var contractitemSearchDlg = $("#complexSearchDialog");
		var contractitemSearchForm = $("#contractitemSearchForm");
		//按钮方法
		var cmdObj = {
			add : function(){
				contractitemForm.form("clear");
				contractitemDialog.dialog("open");
			},
			edit : function(){
				var row = contractitemDataGrid.datagrid("getSelected");
				console.debug(row);
				if (row) {
					//加载本地数据
					contractitemForm.form("load", row);
					contractitemDialog.dialog("open");
				} else {
					jQuery.messager.alert('警告信息', '请选中行，在修改!', 'warning');//警告
				}
			},
			del : function(){
				var row = contractitemDataGrid.datagrid("getSelected");
				console.debug(row);
				if (row) {
					//发出一个ajax请求去后台删除
					var url = "/contractitem/delete?id=" + row.id;
					jQuery.get(url, function(data) {
						console.debug(data);
						if (data instanceof Object) {
							if (data.success) {//删除成功
								jQuery.messager.alert('消息提示', '删除成功!',
										'info', function() {
											//调用重新加载数据的方法
											contractitemDataGrid
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
			saveBtn : function(){
				$('#contractitemForm').submit();
			},
			closeBtn : function(){
				$('#contractitemDialog').dialog('close');
			},simpleSearch:function(){
				var keyWord = $("#keyWord").val();
				console.debug(keyWord);
				keyWord = $.trim(keyWord);
				if(keyWord){
					//利用datagrid本身的请求机制,传递该参数到后台
					//load 加载数据到表格
					console.debug("1");
					contractitemDataGrid.datagrid('load', {    
					    "keyWord": keyWord 
					});
				}
			},
			showComplexSearchDlg : function(){
				//弹出一个高级查询对话框
				contractitemSearchForm.form("clear");
				contractitemSearchDlg.dialog("open");
			},
			complexSearch : function(){
				//通过datagrid的load方法重新请求后台获取数据
				departmentDataGrid.datagrid('load', contractitemSearchForm.serializeJson());
				contractitemSearchDlg.dialog("close");
			},
			complexSearchCancel : function(){
				contractitemSearchDlg.dialog("close");
			}
		}
		
		//按钮 [ ] 从属性中选择
		$('[data-cmd]').click(function(){
			var cmd = $(this).data('cmd');
			cmdObj[cmd]();
		});
		
		
		//easyui 把一个普通的表单的提交方式,修改为ajax提交.
		//<a href="javascript:void(0)" class="easyui-linkbutton" 
		//onclick="javascript:$('#contractitemForm').submit();">保存</a>
		contractitemForm.form({
			//数据提交成功后执行 (不管操作是否成功或失败).
			success : function(data) {
				//data 是一个json字符串,我们需要通过jQuery.parseJSON转换为JSON对象.
				data = jQuery.parseJSON(data);
				if (data.success) {
					//弹出窗体dialog必须关闭
					contractitemDialog.dialog("close");
					//调用重新加载数据的方法
					contractitemDataGrid.datagrid("reload");
				} else {
					jQuery.messager.alert('Error', data.msg, 'error');
				}
			}
		});
		//真正的提交操作:$('#ff').submit();,修改为ajax提交.
	});
	function qq(value,name){ 
		alert(value+":"+name) 
	}
	//处理支付
	function formatisPayment(value, row, index) {
		return value == true ? "已支付" : "未支付";
	}
</script>
</head>
<body>
	<!-- 表格数据 -->
	<table id="contractitemDataGrid" class="easyui-datagrid"
		title="合同明细" fit="true" style="width: 700px; height: 250px"
		toolbar="#toolbar" rownumbers="true" pagination="true"
		pageList="[10,20,50]" fitColumns="true"
		data-options="singleSelect:true,url:'/contractitem/json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:10">编号</th>
				<th data-options="field:'contract',width:10,formatter:contractformatter">所属合同</th>
				<th data-options="field:'payTime',width:10,formatter:formatDateBoxFull" >支付时间</th>
				<th data-options="field:'money',width:10">支付金额</th>
				<th data-options="field:'isPayment',width:10,formatter:formatisPayment">是否支付</th>
				<th data-options="field:'scal',width:10">所占比例</th>
			</tr>
		</thead>
	</table>
	
	<!-- 工具按钮 -->
	<div id="toolbar">
		<a data-cmd="add" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a> 
		<a data-cmd="edit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a> 
		<a data-cmd="del" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除 </a>
		<a data-cmd="showComplexSearchDlg"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-search" plain="true">高级查询</a>
		<span>
			合同: <input id="keyWord" /> <a data-cmd="simpleSearch"
		href="javascript:void(0)" class="easyui-linkbutton"
		iconCls="icon-search" plain="true">搜索 </a>
		</span>
</div> 
	</div>
	
	<!-- 添加，编辑对话框 -->
	<div id="contractitemDialog" class="easyui-dialog" title="保存用户"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#btns">
		<!-- 		加上contractitem.前缀 -->
		<form id="contractitemForm" method="post" action="/contractitem/save">
			<input type="hidden" name="id">
			<table>
				<tr>
					<td>所属合同</td>
					<td><input class='easyui-combobox' type='text' name="contract.id"
						data-options="valueField:'id',textField:'sn',url:'/contract/getListData'"></input></td>
				</tr>
				<tr>
					<td>支付金额</td>
					<td><input class='easyui-validatebox' type='text'
						name='money'></input></td>
				</tr>
				<tr>
					<td>是否支付</td>
					<td><input class='easyui-validatebox' type='text'
						name='isPayment'></input></td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 对话框按钮 -->
	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a data-cmd="saveBtn" href="javascript:void(0)" class="easyui-linkbutton">保存</a>
		<a data-cmd="closeBtn" href="javascript:void(0)" class="easyui-linkbutton">取消</a>
	</div>
	
	<!-- 高级查询对话框 -->
	<div id="complexSearchDialog" class="easyui-dialog" title="高级查询"
		data-options="iconCls:'icon-search',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#searchBtns">
		<!-- 加上employee.前缀 -->
		<form id="contractitemSearchForm">
			<table>
				<tr>
					<td>before</td>
					<td><input class="easyui-datetimebox" name="payTime"></input></td>
				</tr>
				<tr>
					<td>after</td>
					<td><input class="easyui-datetimebox" name="payTime"></input></td>
				</tr>
				<tr>
					<td>up</td>
					<td><input class="easyui-validatebox" name="money"></input></td>
				</tr>
				<tr>
					<td>down</td>
					<td><input class="easyui-validatebox" name="money"></input></td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 高级查询对话框的按钮组 -->
	<div id="searchBtns">
		<a data-cmd="complexSearch" href="javascript:void(0)" class="easyui-linkbutton">高级查询</a> 
		<a data-cmd="complexSearchCancel" href="javascript:void(0)" class="easyui-linkbutton">取消</a>
	</div>
</body>
</html>