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
	//加载下拉客户列表
	$('#followCustomer').combobox({    
	    url:'/customerTraceHistory/getAllCustomer', 
	    height:'20px',
	    panelHeight:90,
	    valueField:'id',    
	    textField:'name'   
			}); 
	
	$('#followType').combobox({    
	    url:'/customerTraceHistory/getAllTraceItem?id=4', 
	    height:'20px',
	    panelHeight:90,
	    valueField:'id',     
	    textField:'name'   
			}); 
	$('input[data-sty="cc"]').combogrid({    
	    panelWidth:250,    
	    pagination:"true",
	    value:'006',    
	    idField:'id',    
	    textField:'realName',    
	    url:'/employee/json',    
	    columns:[[    
	        {field:'id',title:'id',width:60},    
	        {field:'realName',title:'realName',width:100},    
	        {field:'tel',title:'tel',width:120}   
	    ]]    
	}); 
		//公用的对象
		var customerTraceHistoryDialog = $("#customerTraceHistoryDialog");
		var customerTraceHistoryForm = $("#customerTraceHistoryForm");
		var customerTraceHistoryDataGrid = $("#customerTraceHistoryDataGrid");
		var searchDialog=$("#searchDialog");
		var highSearchForm=$("#highSearchForm");
	 
		
		
		var grid=$('input[data-sty="cc"]').combogrid("grid");
		var pager=grid.datagrid("getPager");
		pager.pagination({
				showPageList : false,
				showRefresh : false,
				displayMsg : ""
			});	
		// 初始化添加表单
		customerTraceHistoryForm.form({
		
			// 在表单提交前，做事情
			onSubmit : function() {
				return customerTraceHistoryForm.form("validate");
			},
			success : function(data) {
				// 把后台返回的json字符串转变成json对象
				alert(data);
				data = $.parseJSON(data);
				// 判断结果
				if (data.success) {
					// 关对话框
					customerTraceHistoryDialog.dialog("close");
					$.messager.alert("温馨提示", data.msg, "info", function() {
						// 刷新表格
						customerTraceHistoryDataGrid.datagrid("reload");
					});
				}
			}
		});
		
		//创建命令对象封装不同函数
		var cmdUtils = {
				create : function() {
					//修改对话框标题
					customerTraceHistoryDialog.dialog("setTitle", "部门添加面板")
					// 清空对话框
					customerTraceHistoryForm.form("clear");
					// 打开对话框
					customerTraceHistoryDialog.dialog("open");
				},
				edit : function() {
					
					
					//修改对话框标题
					customerTraceHistoryDialog.dialog("setTitle", "部门修改面板")
					// 获取选中行数据
					var rowData = customerTraceHistoryDataGrid.datagrid("getSelected");
					// 判断是否选中行
					if (!rowData) {
						$.messager.alert("温馨提示", "请选中一行数据！！", "info");
						return;
					}
					//清空原来的数据
					customerTraceHistoryForm.form("clear");
					// 特殊数据的额外处理
					// 部门经理
					if (rowData.traceUser) {
						rowData["traceUser.id"] = rowData.traceUser.id;
					}
					if (rowData.traceType) {
						rowData["traceType.id"] = rowData.traceType.id;
					}
					// 上级部门
					if (rowData.customer) {
						rowData["customer.id"] = rowData.customer.id;
					}
					// 加载数据：easyui form的load方法，遵循一个“同名匹配”的原则
					customerTraceHistoryForm.form("load", rowData);
					// 打开对话框
					customerTraceHistoryDialog.dialog("open");
				},
				del : function() {
					// 1.获取选中行信息
					var rowData = customerTraceHistoryDataGrid.datagrid("getSelected");
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
							$.get("/customerTraceHistory/delete?id="+ id,function(data) {
								if (data.success) {
									$.messager.alert("温馨提示",data.msg,	"info",function() {
											customerTraceHistoryDataGrid.datagrid("reload");
									});
								}
							}, "json");
						}
					});
				},
				refresh : function() {
					// 刷新表格
					customerTraceHistoryDataGrid.datagrid("reload");
				},
				save : function() {
					customerTraceHistoryForm.submit();
				},
				cancel : function() {
					// 关对话框
					customerTraceHistoryDialog.dialog("close");
				},
				search : function() {//简单搜索：查询条件必须少
					customerTraceHistoryDataGrid.datagrid("load",$("#searchForm")
							.serializeJSON());
				},
				//点击弹出高级查询框
				highSearch: function() {
					searchDialog.dialog("setTitle", "高级查询");
					highSearchForm.form("clear");  
					searchDialog.dialog("open");
				},
				
				highSearchForm:function() {
					customerTraceHistoryDataGrid.datagrid("load",$("#highSearchForm")
							.serializeJSON());
					searchDialog.dialog("close");
				},
				cancelHighSearchForm:function() {
					// 关对话框
					searchDialog.dialog("close");
				},
				clearHighSearchForm:function() {
					
					highSearchForm.form("clear");
				},flush:function(){
					customerTraceHistoryDataGrid.datagrid("reload");
				}
				
				
		};
		
		$('a[data-cmd]').on('click',function(){
			var cmd = $(this).data('cmd');
			if(cmd){
				cmdUtils[cmd]();
			}
		});
});
function traceResultFormatter(value){
	if(value==1){
		return "好";
	}else if(value==0){
		return "中";
	}else if(value==-1){
		return "差";
	}else{
		return "该项值错误";
	}
	
}
	
</script>
</head>
<body>
	<table id="customerTraceHistoryDataGrid" class="easyui-datagrid" title="Basic DataGrid"
		fit="true" style="width: 700px; height: 250px" toolbar="#toolbar"
		rownumbers="true" pagination="true" pageList="[10,20,50]"
		fitColumns="true"
		data-options="singleSelect:true,url:'/customerTraceHistory/json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:10" sortable="true">id</th>
				<th data-options="field:'traceUser',width:10" sortable="true" formatter="objectFormatter">跟进人</th>
				<th data-options="field:'title',width:10" sortable="true">跟进主题</th>
				<th data-options="field:'customer',width:10" 	sortable="true" formatter="objectFormatter">跟进客户</th>
				<th data-options="field:'traceTime',width:10" sortable="true">跟进时间</th>
				<th data-options="field:'traceType',width:10" formatter="objectFormatter">跟进方式</th>
				<th data-options="field:'traceResult',width:10" formatter="traceResultFormatter">跟进结果</th>
				<th data-options="field:'remark',width:10">备注</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a id="addCustomerTraceHistory" data-cmd="create" href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true">添加</a> 
		<a data-cmd="edit" id="editCustomerTraceHistory"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true">编辑</a>
		<a data-cmd="del" id="deleteCustomerTraceHistory"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true">删除 </a>
		<a data-cmd="flush"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-reload" plain="true">刷新 </a>
	</div>

	<div id="customerTraceHistoryDialog" class="easyui-dialog" title="保存用户"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#btns">
		<form id="customerTraceHistoryForm" method="post" action="/customerTraceHistory/save">
			<input type="hidden" name="id"/>
			<table>
				<tr>
				<td>跟进客户:</td> 
				<td><input id="followCustomer" type="text" name="customer.id" data-options="required:true"></input></td>
				 </tr>
				<tr>
				<td>跟进主题:</td> 
				<td><input class="easyui-validatebox" type="text" name="title" data-options="required:true"></input></td>
				 </tr>
				<tr>
				<td>跟进效果:</td> 
				<td>
				<input  type="radio" name="traceResult" value="1">好</input>
				<input type="radio" name="traceResult" value="0">中</input>
				<input type="radio" name="traceResult" value="-1">差</input>
				</td>
				  </tr>
				<tr>
				<td>跟进方式:</td> 
				<td><input id="followType" type="text" name="traceType.id" data-options="required:true"></input></td>
				 </tr>
				<tr>
				<td>跟进人:</td> 
				<td>
				<input data-sty="cc" type='text' name='traceUser.id'/>  
				</td>
				
				 </tr>
				<tr>
				<td>跟进时间:</td> 
				<td> <input name="traceTime" class="easyui-datetimebox" label="Select DateTime:" labelPosition="top" style="width:140%;"></td>
				 </tr>
				 <tr>
				<td>备注:</td> 
				<td>
				<textarea name="remark" rows="3" cols="13"></textarea>  
				</td>
				
				
				<!-- <tr><td>父级:</td><td>
				<input class='easyui-validatebox' type='text' name='parent.id'></input>
				<input class="easyui-combotree" name="parent.id" data-options="
				url:'/customerTraceHistory/getTreeData',method:'get',required:true, panelHeight:'auto'" >
				</td></tr> -->
			</table>
		</form>
	</div>

	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a href="javascript:void(0)" class="easyui-linkbutton c3" data-cmd="save">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" data-cmd="cancel">取消</a>
	</div>
	
		<div id="searchDialog" class="easyui-dialog" title="保存用户"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#highBtns">
		<form id="highSearchForm" method="post" action="/customerTraceHistory/save">
			<input type="hidden" name="id"/>
			<table>
				<tr>
				<td>名称:</td> 
				<td><input class="easyui-validatebox" type="text" name="name"></input></td>
				 </tr>
				<tr>
				<td>性别:</td> 
				<td><input class="easyui-validatebox" type="text" name="gender"></input></td>
				 </tr>
				<tr>
				<td>年龄:</td> 
				<td><input class="easyui-validatebox" type="text" name="age"></input></td>
				 </tr>
				<tr><td>登入人:</td><td>
				<input data-sty="cc" type='text' name='inputuser_id'
				/>
				</td></tr>
				<tr><td>营销人员:</td><td>
				<input data-sty="cc" type='text' name='seller_id'
				/>
				</td></tr>
				
			</table>
		</form>
	</div>
	<div id="highBtns">
		<a href="javascript:void(0)" class="easyui-linkbutton c3" data-cmd="highSearchForm">搜索</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton c4" data-cmd="cancelHighSearchForm">取消</a>
		<a href="javascript:void(0)" class="easyui-linkbutton c5" data-cmd="clearHighSearchForm">重置</a>
	</div>
</body>
</html>