<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>保修单管理</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">
	$(function() {
		//公用的对象
		var guaranteeDialog = $("#guaranteeDialog");
		var guaranteeDatagrid = $("#guaranteeDatagrid");
		var guaranteeForm = $("#guaranteeForm");

		//显示保修单明细
		guaranteeDatagrid.datagrid({
					
					detailFormatter : function(index, row) {
						return '<div class="ddv"></div>';
					},
					onExpandRow : function(index, row) {
						var ddv = $(this).datagrid('getRowDetail', index).find(
								'div.ddv');
						ddv.panel({
									height : 300,
									border : false,
									cache : true,
									//href:"/guaranteeItems/list",
									content : '<iframe frameborder="0" src="'
											+ "/guaranteeItem/list?id="
											+ row.id
											+ '" style="width: 100%; height: 99.3%;"></iframe>',
									onLoad : function() {
										$('#dg').datagrid('fixDetailRowHeight',
												index);
									}
								});
						$('#dg').datagrid('fixDetailRowHeight', index);
					}
				});

		/*初始化添加表单
		      初始化表单后如果需要提交:guaranteeForm.submit()
		 */
		
	guaranteeForm.form({
			// 在表单提交前，做一些需要的预处理
			onSubmit : function() {
				return guaranteeForm.form("validate");
			},
			success : function(data) {
				// 把后台返回的json字符串转变成json对象
				data = $.parseJSON(data);
				// 判断结果
				if (data.success) {
					// 关对话框
					guaranteeDialog.dialog("close");
					$.messager.alert("温馨提示", data.msg, "info", function() {
						// 刷新表格
						guaranteeDatagrid.datagrid("reload");
					});
				}
			}
		});

		//创建命令对象封装不同函数
		var cmdUtils = {
			create : function() {
				//修改对话框标题
				guaranteeDialog.dialog("setTitle", "保修单添加")
				// 清空对话框
				guaranteeForm.form("clear");
				// 打开对话框
				guaranteeDialog.dialog("open");
			},
			edit : function() {
				//修改对话框标题
				guaranteeDialog.dialog("setTitle", "保修单修改")
				// 获取选中行数据
				var rowData = guaranteeDatagrid.datagrid("getSelected");
				console.debug(rowData);
				// 判断是否有行数据被选中
				if (!rowData) {
					$.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				//清空原来的数据
				guaranteeForm.form("clear");
				// 特殊数据的额外处理
				// 保修单所属合同
				if (rowData.contract) {
					rowData["contract.id"] = rowData.contract.id;
				}
				// 加载数据：easyui form的load方法，遵循一个“同名匹配”的原则
				guaranteeForm.form("load", rowData);
				// 打开对话框
				guaranteeDialog.dialog("open");
			},
			del : function() {
				// 1.获取选中行信息
				
				var rowData = guaranteeDatagrid.datagrid("getSelected");
				// 2.判断
				if (!rowData) {
					$.messager.alert("温馨提示", "请选中一行数据！！");
					return;
				}
				$.messager.confirm("温馨提示", "是否确认删除编号为：【" + rowData.sn
						+ "】的保修单??", function(yes) {
					if (yes) {
						// 获取数据的唯一标示
						var id = rowData.id;
						// 发送AJAX请求，修改ID对应数据状态
						$.get("/guarantee/delete?id=" + id, function(data) {
							if (data.success) {
								$.messager.alert("温馨提示", "成功删除编号为：【"
										+ rowData.sn + "】的保修单!", "info",
										function() {
											guaranteeDatagrid.datagrid("reload");
										});
							}
						}, "json");
					}
				});
			},
			refresh : function() {
				// 刷新表格
				guaranteeDatagrid.datagrid("reload");
			},
			save : function() {
				guaranteeForm.form('submit', {
					url : "/guarantee/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//result后台返回的数据，不能json格式
						try {
							alert(result);
							var result = JSON.parse(result);
							if (result.success) {
								$('#guaranteeDatagrid').datagrid('reload');
								$('#guaranteeDialog').dialog('close');
							} else {
								//后台保存失败
								$.messager.show({
									title : '错误提示',
									msg : "<font color='red'>" + result.message
											+ "</font>"
								});
							}
						} catch (e) {
							$.messager.show({
								title : '错误提示',
								msg : "<font color='red'>数据转换异常或者服务器异常</font>"
							});
						}
					}
				});

			},

			cancel : function() {
				// 关对话框
				guaranteeDialog.dialog("close");
			},
			searchForm : function() {
				console.debug('guaranteeSearchForm:function');
				guaranteeDatagrid.datagrid("reload", $("#guaranteeSearchForm")
						.serializeJson());
			},
			clearForm : function() {
				$("#guaranteeSearchForm").form('clear');

			}

		};

		//统一监听按钮，绑定处理函数
		$('a[data-cmd]').on('click', function() {
			//获得监听按钮的属性值
			//var cmd = $(this).attr('data-cmd');
			var cmd = $(this).data('cmd');
			console.debug("data-cmd=" + cmd);
			if (cmd) {
				cmdUtils[cmd]();//调用自定义的方法处理对应的事件命令
			}

		});

	});
	function sellerFormat1(value) {
		return value ? value.username : "";
	}
	function contractFormat(value) {
		return value ? value.sn : "";
	}
</script>
</head>

<body>

	<table id="guaranteeDatagrid" fit="true" title="订单合同" class="easyui-datagrid"
		style="width: 700px; height: 250px" 
		toolbar="#toolbar" pagination="true" rownumbers="true"
		fitColumns="true" singleSelect="true"
		data-options="singleSelect:true,url:'/guarantee/json',method:'get'">
		<thead>
			<tr>
				<th sortable="true" data-options="field:'id',width:10">编号</th>
				<th data-options="field:'sn',width:10">保修单号</th>
				<th sortable="true" data-options="field:'guaranteeTime',width:10">质保到期时间</th>
				<th data-options="field:'customer',width:10"
					formatter="objectFormatter">保修客户</th>
				<th data-options="field:'contract',width:10"
					formatter="contractFormat">所属合同编号</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a data-cmd="create" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-add"> 添加 </a> 
		<a data-cmd="edit" href="javascript:void(0)"
			class="easyui-linkbutton c8" iconCls="icon-edit"> 编辑 </a> 
		<a data-cmd="del" href="javascript:void(0)"
		    class="easyui-linkbutton c5" iconCls="icon-remove"> 删除 </a>
		    
		<a data-cmd="refresh"href="javascript:void(0)" class="easyui-linkbutton c1"
			data-options="iconCls:'icon-reload'" style="width: 80px"> 刷新 </a>
	<div>
			<form id="guaranteeSearchForm" method="post"
				enctype="application/x-www-form-urlencoded">
				关键字 : <input class='easyui-textbox' name="q" style="width: 150px"
					prompt="单号.客户......"> 质保到期时间:<input class="easyui-datebox"
					name="beginDate" size="15px" /> --><input class="easyui-datebox"
					name="endDate" size="15px" /> <a data-cmd="searchForm"
					href="javascript:void(0)" class="easyui-linkbutton c4"
					iconCls="icon-search"> 搜索 </a> <a data-cmd="clearForm"
					href="javascript:void(0)" class="easyui-linkbutton c5"
					iconCls="icon-clear"> 清空 </a>
			</form>
		</div>

	</div>
	
	<!-- =======点击工具栏按钮生成的对话框====================r================================== -->
	<div id="guaranteeDialog" class="easyui-dialog" title="保存保修单"
		data-options="iconCls:'icon-save',closed:true"
		style="width: 400px; height: auto; padding: 20px"
		buttons="#dialogBtns">
		<form id="guaranteeForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<div
				style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">保修单基本信息</div>
			<input type="hidden" name="id" /> <input type="hidden" name="sn" />
			<table>
				<tr>
				<tr>
					<td>到期时间:</td>
					<td><input class='easyui-datebox' type='text'
						name='guaranteeTime'></input></td>
				</tr>

				<tr>
					<td>保修单所属合同:</td>
					<td><select id="customerCombo" class="easyui-combogrid"
						name="contract.id" style="width: 143px;"
						data-options="    
				             panelWidth:300,    
						    idField:'id',    
						    textField:'id',    
						    url:'/contract/json',    
							fitColumns: true,
							pagination:true , 
							required:true,
						    columns:[[    
						        {field:'id',title:'合同编号',width:60},    
						        {field:'sn',title:'合同单号',width:100},    
								                  
				            ]] 
				        "></select>
					</td>
				</tr>

			</table>
		</form>

	</div>
	<!-- 对话框按钮 -->
	<div id="dialogBtns">
		<!--不要在href里面写js代码 -->
		<a data-cmd="save" href="javascript:void(0)"
			class="easyui-linkbutton c6">保存</a> <a data-cmd="cancel"
			href="javascript:void(0)" class="easyui-linkbutton">取消</a>
	</div>

</body>
</html>