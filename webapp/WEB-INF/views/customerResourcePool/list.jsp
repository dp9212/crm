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
	$('#followType').combobox({    
	    url:'/customerTraceHistory/getAllTraceItem?id=4', 
	    height:'20px',
	    panelHeight:90,
	    valueField:'id',     
	    textField:'name'   
			}); 
		//公用的对象
		var customerResourcePoolDialog = $("#customerResourcePoolDialog");
		var customerResourcePoolForm = $("#customerResourcePoolForm");
		var customerResourcePoolDataGrid = $("#customerResourcePoolDataGrid");
		var searchDialog=$("#searchDialog");
		var highSearchForm=$("#highSearchForm");
		var transferDialog=$("#transferDialog");
		var transferForm=$("#transferForm");
		var customerTraceHistoryDialog=$("#customerTraceHistoryDialog");
		var customerTraceHistoryForm=$("#customerTraceHistoryForm");
		
	//---------------添加访问数据字段数据---------------------	
		$('#source').combobox({    
		    url:'/customerResourcePool/parentData?id=2', 
		    height:'20px',
		    panelHeight:90,
		    valueField:'id',    
		    textField:'name'   
				}); 
		$('#job').combobox({    
		    url:'/customerResourcePool/parentData?id=1', 
		    height:'20px',
		    panelHeight:90,
		    valueField:'id',    
		    textField:'name'   
				}); 
		
		$('#salaryLevel').combobox({    
		    url:'/customerResourcePool/parentData?id=3', 
		    height:'20px',
		    panelHeight:90,
		    valueField:'id',    
		    textField:'name'   
				}); 
		
		
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
				alert(customerTraceHistoryForm.form("validate"));
				return customerTraceHistoryForm.form("validate");
			},
			success : function(data) {
				// 把后台返回的json字符串转变成json对象
				alert(data);
				data = $.parseJSON(data);
				// 判断结果
				if (data.success) {
					// 关对话框
					customerResourcePoolDialog.dialog("close");
					$.messager.alert("温馨提示", data.msg, "info", function() {
						// 刷新表格
						customerResourcePoolDataGrid.datagrid("reload");
					});
				}
			}
		});
		customerResourcePoolForm.form({
		
			// 在表单提交前，做事情
			onSubmit : function() {
				alert(customerResourcePoolForm.form("validate"));
				return customerResourcePoolForm.form("validate");
			},
			success : function(data) {
				// 把后台返回的json字符串转变成json对象
				alert(data);
				data = $.parseJSON(data);
				// 判断结果
				if (data.success) {
					// 关对话框
					customerResourcePoolDialog.dialog("close");
					$.messager.alert("温馨提示", data.msg, "info", function() {
						// 刷新表格
						customerResourcePoolDataGrid.datagrid("reload");
					});
				}
			}
		});
		transferForm.form({
		
			// 在表单提交前，做事情
			onSubmit : function() {
				alert(transferForm.form("validate"));
				return transferForm.form("validate");
			},
			success : function(data) {
				// 把后台返回的json字符串转变成json对象
				alert(data);
				data = $.parseJSON(data);
				// 判断结果
				if (data.success) {
					// 关对话框
					transferDialog.dialog("close");
					$.messager.alert("温馨提示", data.msg, "info", function() {
						// 刷新表格
						customerResourcePoolDataGrid.datagrid("reload");
					});
				}
			}
		});
		
		//创建命令对象封装不同函数
		var cmdUtils = {
				create : function() {
					//修改对话框标题
					customerResourcePoolDialog.dialog("setTitle", "部门添加面板")
					// 清空对话框
					customerResourcePoolForm.form("clear");
					// 打开对话框
					customerResourcePoolDialog.dialog("open");
				},
				edit : function() {
					//修改对话框标题
					customerResourcePoolDialog.dialog("setTitle", "部门修改面板")
					// 获取选中行数据
					var rowData = customerResourcePoolDataGrid.datagrid("getSelected");
					// 判断是否选中行
					if (!rowData) {
						$.messager.alert("温馨提示", "请选中一行数据！！", "info");
						return;
					}
					//清空原来的数据
					customerResourcePoolForm.form("clear");
					// 特殊数据的额外处理
					// 部门经理
					if (rowData.seller) {
						rowData["seller.id"] = rowData.seller.id;
					}
					// 上级部门
					if (rowData.inputUser) {
						rowData["inputUser.id"] = rowData.inputUser.id;
					}
					// 加载数据：easyui form的load方法，遵循一个“同名匹配”的原则
					customerResourcePoolForm.form("load", rowData);
					// 打开对话框
					customerResourcePoolDialog.dialog("open");
				},
				del : function() {
					// 1.获取选中行信息
					var rowData = customerResourcePoolDataGrid.datagrid("getSelected");
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
							$.get("/customerResourcePool/delete?id="+ id,function(data) {
								if (data.success) {
									$.messager.alert("温馨提示",data.msg,	"info",function() {
											customerResourcePoolDataGrid.datagrid("reload");
									});
								}
							}, "json");
						}
					});
				},
				refresh : function() {
					// 刷新表格
					customerResourcePoolDataGrid.datagrid("reload");
				},
				save : function() {
					customerResourcePoolForm.submit();
				},
				cancel : function() {
					// 关对话框
					customerResourcePoolDialog.dialog("close");
				},
				search : function() {//简单搜索：查询条件必须少
					customerResourcePoolDataGrid.datagrid("load",$("#searchForm")
							.serializeJSON());
				},
				//点击弹出高级查询框
				highSearch: function() {
					searchDialog.dialog("setTitle", "高级查询");
					highSearchForm.form("clear");  
					searchDialog.dialog("open");
				},
				
				highSearchForm:function() {
					customerResourcePoolDataGrid.datagrid("load",$("#highSearchForm")
							.serializeJSON());
					searchDialog.dialog("close");
				},
				cancelHighSearchForm:function() {
					// 关对话框
					searchDialog.dialog("close");
				},
				clearHighSearchForm:function() {
					
					highSearchForm.form("clear");
				},
				pass:function() {
					transferDialog.form("clear");
					var rowData = customerResourcePoolDataGrid.datagrid("getSelected");
					console.debug(rowData);
					if (rowData.seller) {
						rowData["oldSeller.realName"] = rowData.seller.realName;
					}
					transferDialog.form("load", rowData);
					transferDialog.dialog("open");
				},
				transferSave:function() {
					transferForm.submit();
					/* transferDialog.dialog("close");
					if (data.success) {
							customerDataGrid.datagrid("reload");
					}else{
						alert("出问题了");
					} */
				},
				transferCancel:function() {
					transferDialog.dialog("close");
				},
				customerTraceHistorysave : function() {
					customerTraceHistoryForm.submit();
					
				},
				customerTraceHistorycancel : function() {
					// 关对话框
					customerTraceHistoryDialog.dialog("close");
				},
				
				follow:function() {
					customerTraceHistoryDialog.dialog("setTitle", "追踪客户")
					var rowData = customerDataGrid.datagrid("getSelected");
					console.debug(rowData);
					if (!rowData) {
						$.messager.alert("温馨提示", "请选中一行数据！！", "info");
						return;
					}
					//清空原来的数据
					customerTraceHistoryForm.form("clear");
					
					// 加载数据：easyui form的load方法，遵循一个“同名匹配”的原则
					customerTraceHistoryForm.form("load", rowData);
					// 打开对话框
					customerTraceHistoryDialog.dialog("open");
				},
				putsource:function() {
					var rowData = customerDataGrid.datagrid("getSelected");
					var id = rowData.id;
					if (!rowData) {
						$.messager.alert("温馨提示", "请选中一行数据！！");
						return;
					}
					$.get("/customerTraceHistory/changeState?id="+ id,function(data) {
						
						if (data.success) {
							$.messager.alert("温馨提示",data.msg,	"info",function() {
									customerResourcePoolDataGrid.datagrid("reload");
							});
						}
					}, "json");					
				},flush:function(){
					customerResourcePoolDataGrid.datagrid("reload");
				}
				
				
		};
		
		$('a[data-cmd]').on('click',function(){
			var cmd = $(this).data('cmd');
			if(cmd){
				cmdUtils[cmd]();
			}
		});
});
function sexFormatter(value){
	return value==1 ?"男":"女";
}
function stateFormatter(value){
	if(value==1){
		return "已放入资源池";
	}else if(value==0){
		return "正在追踪";
	}else{
		return "流放";
	}
}

	
</script>
</head>
<body>
	<table id="customerResourcePoolDataGrid" class="easyui-datagrid" title="Basic DataGrid"
		fit="true" style="width: 700px; height: 250px" toolbar="#toolbar"
		rownumbers="true" pagination="true" pageList="[10,20,50]"
		fitColumns="true"
		data-options="singleSelect:true,url:'/customerResourcePool/json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:10" sortable="true">客户编号</th>
				<th data-options="field:'name',width:10" sortable="true">客户名称</th>
				<th data-options="field:'gender',width:10" formatter="sexFormatter" >性别</th>
				<th data-options="field:'age',width:10">年龄</th>
				<th data-options="field:'tel',width:10">电话</th>
				<th data-options="field:'email',width:10">email</th>
				<th data-options="field:'qq',width:10">qq</th>
				<th data-options="field:'wechat',width:10">wechat</th>
				<th data-options="field:'address',width:10">地址</th>
				<th data-options="field:'seller',width:10" sortable="true" formatter="objectFormatter">营销人</th>
				<th data-options="field:'inputUser',width:10" sortable="true" formatter="objectFormatter">登入者</th>
				<th data-options="field:'job',width:10" formatter="objectFormatter">工作</th>
				<th data-options="field:'source',width:10" formatter="objectFormatter">客户来源</th>
				<th data-options="field:'salaryLevel',width:10" sortable="true" formatter="objectFormatter">薪水位</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a id="addCustomer" data-cmd="create" href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true">添加</a> 
		<a data-cmd="edit" id="editCustomer"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true">编辑</a>
		<a data-cmd="del" id="deleteCustomer"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true">删除 </a>
		<a data-cmd="flush"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-reload" plain="true">刷新 </a>
		<a data-cmd="follow" 
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cut" plain="true">跟进</a>
		<a data-cmd="pass" 
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-undo" plain="true">移交</a>
		<a data-cmd="putsource" 
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-redo" plain="true">放入资源池</a>
		<a data-cmd="coming" 
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-print" plain="true">客户来源</a>
			
			<div>
			<form id="searchForm" method="post">
				关键字：<input name="keyWord" size="10" /> <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search"
					plain="true" data-cmd="search">搜索</a>
			</form>
			<a data-cmd="highSearch"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true">高级搜索 </a>
		</div>
	</div>

	<div id="customerResourcePoolDialog" class="easyui-dialog" title="保存用户"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#btns">
		<form id="customerResourcePoolForm" method="post" action="/customerResourcePool/save">
			<input type="hidden" name="id"/>
			<table>
				<tr>
				<td>客户姓名:</td> 
				<td><input class="easyui-validatebox" type="text" name="name" data-options="required:true"></input></td>
				 </tr>
				<tr>
				<td>性别:</td> 
				<td>
				<input class="easyui-validatebox" type="radio" name="gender" value="1">男</input>
				<input class="easyui-validatebox" type="radio" name="gender" value="0">女</input>
				</td>
				 </tr>
				<tr>
				<td>tel:</td> 
				<td><input class="easyui-validatebox" type="text" name="tel" data-options="required:true"></input></td>
				 </tr>
				
				<tr>
				<td>客户来源:</td> 
				<td>
				 <input id="source" name="source.id" value="-1">  
				</td>
				
				 </tr>
				<tr>
				<td>职业:</td> 
				<td><input id="job" name="job.id" value="-1"> </input></td>
				 </tr>
				 </tr>
				<tr>
				<td>薪资:</td> 
				<td><input id="salaryLevel" name="salaryLevel.id" value="-1"> </input></td>
				 </tr>
				
				<tr><td>营销人员:</td><td>
				<input data-sty="cc" type='text' name='seller.id'
				/>
				</td></tr>
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
		<form id="highSearchForm" method="post" action="/customerResourcePool/save">
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
	
	<div id="transferDialog" class="easyui-dialog" title="移交客户"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#transferBtns">
		<form id="transferForm" method="post" action="/customerResourcePool/transfer">
			<input type="hidden" name="id"/>
			<table>
				<tr>
				<td>客户姓名:</td> 
				<td><input  class="easyui-validatebox" type="text" name="name" data-options="required:true"></input></td>
				 </tr>
				<tr>
				<td>原营销人员:</td> 
				<td>
				<input  type="text" name="oldSeller.realName"></input>
				</td>
				 </tr>
				<tr>
				<td>新营销人员:</td> 
				<td><input data-sty="cc" type="text" name="newSeller.id" data-options="required:true"></input></td>
				 </tr>
				<tr>
				<td>移交原因:</td> 
				<td>
				 <input name="transReason">  
				</td>
				
				
			</table>
		</form>
	</div>
	<div id="transferBtns">
		<a href="javascript:void(0)" class="easyui-linkbutton c3" data-cmd="transferSave">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" data-cmd="transferCancel">取消</a>
	</div>
	
	
	<!-- 跟踪对话框 -->
	<div id="customerTraceHistoryDialog" class="easyui-dialog" title="保存用户"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px" buttons="#customerTraceHistorybtns">
		<form id="customerTraceHistoryForm" method="post" action="/customerTraceHistory/saveHistory">
			<input type="hidden" name="id"/>
			<table>
				<tr>
				<td>跟进客户:</td> 
				<td><input id="followCustomer" type="text" name="name" data-options="required:true"></input></td>
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
				</td></tr> 
			</table>
		</form>
	</div>
	<div id="customerTraceHistorybtns">
		<!--不要在href里面写js代码 -->
		<a href="javascript:void(0)" class="easyui-linkbutton c3" data-cmd="customerTraceHistorysave">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" data-cmd="customerTraceHistorycancel">取消</a>
	</div>
</body>
</html>