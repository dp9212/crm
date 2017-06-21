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
	    url:'/customerTransfer/getAllCustomer', 
	    height:'20px',
	    panelHeight:90,
	    valueField:'id',    
	    textField:'name'
	     ,
	    	onSelect: function(rec){    
	          
	           	$('#followOld').combobox({    
				    url:'/customerTransfer/queryOld?id='+rec.id, 
				    height:'20px',
				    panelHeight:90,
				    valueField:'id',     
				    textField:'realName'   
					}); 
	           	
				} 
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
		var customerTransferDialog = $("#customerTransferDialog");
		var customerTransferForm = $("#customerTransferForm");
		var customerTransferDataGrid = $("#customerTransferDataGrid");
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
		customerTransferForm.form({
		
			// 在表单提交前，做事情
			onSubmit : function() {
				alert(customerTransferForm.form("validate"));
				return customerTransferForm.form("validate");
			},
			success : function(data) {
				// 把后台返回的json字符串转变成json对象
				alert(data);
				data = $.parseJSON(data);
				// 判断结果
				if (data.success) {
					// 关对话框
					customerTransferDialog.dialog("close");
					$.messager.alert("温馨提示", data.msg, "info", function() {
						// 刷新表格
						customerTransferDataGrid.datagrid("reload");
					});
				}
			}
		});
		
		//创建命令对象封装不同函数
		var cmdUtils = {
				create : function() {
					//修改对话框标题
					customerTransferDialog.dialog("setTitle", "添加客户移交")
					// 清空对话框
					customerTransferForm.form("clear");
					// 打开对话框
					customerTransferDialog.dialog("open");
			
					
					
					 
					
				},
				edit : function() {
					
					customerTransferDialog.form("clear");
					var rowData = customerTransferDataGrid.datagrid("getSelected");
					console.debug(rowData);
					if (rowData.newSeller) {
						rowData["newSeller.id"] = rowData.newSeller.id;
					}
					if (rowData.oldSeller) {
						rowData["oldSeller.realName"] = rowData.oldSeller.realName;
						 /*  rowData["oldSeller.id"] = rowData.oldSeller.id;   */
						/* alert(rowData["oldSeller.id"]); */
					}
					if (rowData.customer) {
						rowData["customer.name"] = rowData.customer.name;
						rowData["customer.id"] = rowData.customer.id;
						
					}
					customerTransferDialog.form("load", rowData);
					 var did=$("input[name='customer.id']").val();
					
					$('#followOld').combobox({    
					    url:'/customerTransfer/queryOld?id='+did, 
					    height:'20px',
					    panelHeight:90,
					    valueField:'id',     
					    textField:'realName'   
						}); 
					customerTransferDialog.dialog("open");
				},
				del : function() {
					// 1.获取选中行信息
					var rowData = customerTransferDataGrid.datagrid("getSelected");
					// 2.判断
					if (!rowData) {
						$.messager.alert("温馨提示", "请选中一行数据！！");
						return;
					}
					$.messager.confirm("温馨提示","是否确认删除【" + rowData.realName + "】的移交记录??",	function(yes) {
						if (yes) {
							// 获取数据的唯一标示
							var id = rowData.id;
							// 发送AJAX请求，修改ID对应数据状态
							$.get("/customerTransfer/delete?id="+ id,function(data) {
								if (data.success) {
									$.messager.alert("温馨提示",data.msg,	"info",function() {
											customerTransferDataGrid.datagrid("reload");
									});
								}
							}, "json");
						}
					});
				},
				refresh : function() {
					// 刷新表格
					customerTransferDataGrid.datagrid("reload");
				},
				save : function() {
					customerTransferForm.submit();
				},
				cancel : function() {
					// 关对话框
					customerTransferDialog.dialog("close");
				},
				search : function() {//简单搜索：查询条件必须少
					customerTransferDataGrid.datagrid("load",$("#searchForm")
							.serializeJSON());
				},
				//点击弹出高级查询框
				highSearch: function() {
					searchDialog.dialog("setTitle", "高级查询");
					highSearchForm.form("clear");  
					searchDialog.dialog("open");
				},
				
				highSearchForm:function() {
					customerTransferDataGrid.datagrid("load",$("#highSearchForm")
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
					customerTransferDataGrid.datagrid("reload");
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
	<table id="customerTransferDataGrid" class="easyui-datagrid" title="Basic DataGrid"
		fit="true" style="width: 700px; height: 250px" toolbar="#toolbar"
		rownumbers="true" pagination="true" pageList="[10,20,50]"
		fitColumns="true"
		data-options="singleSelect:true,url:'/customerTransfer/json',method:'get'">
		<thead>
			<tr>
			
				<th data-options="field:'id',width:10" sortable="true">id</th>
				<th data-options="field:'customer',width:10" sortable="true" formatter="objectFormatter">客户名称</th>
				<th data-options="field:'transUser',width:10" sortable="true" formatter="objectFormatter">移交人</th>
				<th data-options="field:'newSeller',width:10" 	sortable="true" formatter="objectFormatter">新的营销人员</th>
				<th data-options="field:'oldSeller',width:10" sortable="true" formatter="objectFormatter">老的营销人</th>
				<th data-options="field:'transTime',width:10" >移交时间</th>
				<th data-options="field:'transReason',width:10">移交原因</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a id="addCustomerTransfer" data-cmd="create" href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true">添加</a> 
		<a data-cmd="edit" id="editCustomerTransfer"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true">编辑</a>
		<a data-cmd="del" id="deleteCustomerTransfer"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true">删除 </a>
		<a data-cmd="flush"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-reload" plain="true">刷新 </a>
	</div>

	<div id="customerTransferDialog" class="easyui-dialog" title="保存用户"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#btns">
		<form id="customerTransferForm" method="post" action="/customerTransfer/save">
			<input id="hhid" type="hidden" name="id"/>
			<input type="hidden" name="customer.name"/>
			
			
			<table>
				<tr>
				<td>客户姓名:</td> 
				<td><input id="followCustomer"  type="text" name="customer.id" data-options="required:true" ></input></td>
				 </tr>
				<tr>
				<td>原营销人员:</td> 
				<td>
				<input id="followOld" type="text" name="oldSeller.id"></input>
				</td>
				 </tr>
				<tr>
				<td>新营销人员:</td> 
				<td><input data-sty="cc" type="text" name="newSeller.id" data-options="required:true"></input></td>
				 </tr>
				 <tr>
				<td>移交时间:</td> 
				<td> <input name="transTime" class="easyui-datetimebox" label="Select DateTime:" labelPosition="top" style="width:140%;"></td>
				 </tr>
				<tr>
				<td>移交原因:</td> 
				<td>
				 <input name="transReason">  
				</td>
				
				
			</table>
			
		</form>
	</div>

	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a href="javascript:void(0)" class="easyui-linkbutton c3" data-cmd="save">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" data-cmd="cancel">取消</a>
	</div>
	
		
	
</body>
</html>