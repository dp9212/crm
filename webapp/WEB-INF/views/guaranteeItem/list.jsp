<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>保修单明细管理</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">
	$(function() {
		//公用的对象
		var guaranteeItemDialog = $("#guaranteeItemDialog");
		var guaranteeItemForm = $("#guaranteeItemForm");
		var guaranteeItemDataGrid = $("#guaranteeItemDataGrid");
		
		//获取所有的需要控制的命令按钮
		var cmdBtns = $('a[data-cmd]');
		//命令集合
		var cmdObject = {
				add : function(){
					guaranteeItemForm.form("clear");
					guaranteeItemDialog.dialog("open").dialog("center");
				},
				edit : function(){
					//修改对话框标题
					guaranteeItemDialog.dialog("setTitle", "保修单明细修改");
					var row = guaranteeItemDataGrid.datagrid("getSelected");
					console.debug(row);
					if (row) {
						//清空原来的数据
						guaranteeItemForm.form("clear");
						// 特殊数据的额外处理
						// 所属保修单
						console.debug(row);
					 	if (row.guarantee) {
							row["guarantee.id"] = row.guarantee.id;
						}
						//加载本地数据
						guaranteeItemForm.form("load", row);
						guaranteeItemDialog.dialog("open").dialog("center");
					} else {
						jQuery.messager.alert('警告信息', '请选中要修改的行!', 'warning');//警告
					}
				},
				
				del:function(){
					var row = guaranteeItemDataGrid.datagrid("getSelected");
					console.debug(row);
					if (row) {
						//发出一个ajax请求去后台删除
						var url = "/guaranteeItem/delete?id=" + row.id;
						jQuery.get(url,function(data) {
											console.debug(data);
											if (data instanceof Object) {
												if (data.success) {//删除成功
													jQuery.messager.alert(
																	'消息提示',
																	'删除成功!',
																	'info',
																	function() {
																		//调用重新加载数据的方法
																		guaranteeItemDataGrid.datagrid("reload");
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
						jQuery.messager.alert('警告信息', '请选中行，在删除!', 'warning');//警告
					}
				},
				save : function(){
					$('#guaranteeItemForm').submit();
				},
				cancel :function(){
					$('#guaranteeItemDialog').dialog('close');
				}
		};
		//绑定事件
		cmdBtns.on('click',function(){
			var cmdTarget = $(this);
			var dataCmd = cmdTarget.attr('data-cmd');
			cmdObject[dataCmd]();
		});
		
		
		//把数据编辑表单转换为AJAX提交方式
		guaranteeItemForm.form({
			//数据提交成功后执行 (不管操作是否成功或失败).
			success : function(data) {
				//data 是一个json字符串,我们需要通过jQuery.parseJSON转换为JSON对象.
				data = jQuery.parseJSON(data);
				if (data.success) {
					//弹出窗体dialog必须关闭
					guaranteeItemDialog.dialog("close");
					//调用重新加载数据的方法
					guaranteeItemDataGrid.datagrid("reload");
				} else {
					jQuery.messager.alert('Error', data.msg, 'error');
				}
			}
		});
		//真正的提交操作:$('#ff').submit();,修改为ajax提交.
		
	});
	
	function solveFormat(val, row) { 
		if (val==0) { 
			return "<font color='green'>已解决</font>"; 
		} else {
			return "<font color='red'>未解决</font>";
		} 
	}
	
	function guaranteeFormat(value) {
		return value ? value.sn : "";
	}
	
</script>
</head>
<body >

	<!-- easyui的表格 -->
	<!-- 表格工具栏 -->
	<div id="toolbar">
		<a data-cmd="add" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-add" >
			添加
		</a> 
		<a data-cmd="edit" href="javascript:void(0)" class="easyui-linkbutton c8" iconCls="icon-edit" >
			编辑
		</a> 
		<a data-cmd="del" href="javascript:void(0)"
		    class="easyui-linkbutton c5" iconCls="icon-remove"> 删除 </a>
		<!-- <a data-cmd="del" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true">
			删除 
		</a>  -->
	</div>
	<!--end 表格工具栏 -->
	<table id="guaranteeItemDataGrid" class="easyui-datagrid" style="width: 700px; height: auto"
		fit="true"  
		toolbar="#toolbar"
		pageList="[10,20,50]"
		fitColumns="true"
		data-options="singleSelect:true,url:'/guaranteeItem/json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:10">编号</th>
				<th data-options="field:'guaranteeTime',width:10">保修时间</th>
				<th data-options="field:'guaranteeContent',width:10">保修内容</th>
				<th data-options="field:'isSolve',width:10" formatter="solveFormat">是否解决</th>
				<th data-options="field:'guarantee',width:10" formatter="guaranteeFormat">所属保修单</th>
				
			</tr>
		</thead>
	</table>
	<!-- end easyui的表格 -->
	
	

	<!-- 增加和编辑记录的表单对话框 -->
	<div id="guaranteeItemDialog" class="easyui-dialog" title="保存保修单明细"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 300px; height: auto; padding: 20px;z-index:1000" buttons="#btns">
		<!-- 记录的编辑表单 -->
		<form id="guaranteeItemForm" method="post" action="/guaranteeItem/save">
			<input type="hidden" name="id">
			<input type="hidden" name="guarantee.id">
			<table>
				<tr><td>保修时间:</td><td><input required="true" class='easyui-datebox' type='text' name='guaranteeTime'></input></td></tr>
				<tr><td>是否解决:</td>
					<td>
						已解决<input type="radio" name='isSolve' value=0></input>
						未解决<input type="radio" name='isSolve' value=1></input>
					</td>
				</tr>
				<tr><td>保修内容:</td><td><input required="true" class="easyui-textbox" labelPosition="top" multiline="true" 
							 name="guaranteeContent" style="width:100%;height:120px"></td></tr>
			</table>
		</form>
	</div>
	<!-- 对话框的按钮组 -->
	<div id="btns">
		<!--不要在href里面写js代码 -->
		<a data-cmd="save" href="javascript:void(0)" class="easyui-linkbutton">保存</a> 
		<a data-cmd="cancel" href="javascript:void(0)" class="easyui-linkbutton">取消</a>
	</div>
	<!-- end 对话框的按钮组 -->
	<!-- end 增加和编辑记录的表单对话框 -->
	
	
</body>
</html>