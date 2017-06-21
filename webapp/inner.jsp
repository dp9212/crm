<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		var addcontractitemDialog = $("#addcontractitemDialog");
		var addcontractitemForm = $("#addcontractitemForm");
		var url;
	    function newContractItem(){
	        $('#addcontractitemDialog').dialog('open').dialog('center').dialog('setTitle','添加新明细');
	        $('#addcontractitemForm').form('clear');
	        url = '/contractitem/save';
	    }
	    function editContractItem(){
	        var row = $('#contractitem').datagrid('getSelected');
	        if (row){
	            $('#addcontractitemDialog').dialog('open').dialog('center').dialog('setTitle','编辑明细');
	            $('#addcontractitemForm').form('load',row);
	            url = '/contractitem/update?id='+row.id;
	        }
	    }
	    function saveContractItem(){
	    	alert(url);
	    	$('#addcontractitemForm').submit();
	    }
	    function destoryContractItem(){
	        var row = $('#contractitem').datagrid('getSelected');
	        if (row){
	            $.messager.confirm('Confirm','Are you sure you want to destroy this item?',function(r){
	                if (r){
	                    $.post('destroy_user.php',{id:row.id},function(result){
	                        if (result.success){
	                            $('#contractitem').datagrid('reload');    // reload the user data
	                        } else {
	                            $.messager.show({    // show error message
	                                title: 'Error',
	                                msg: result.errorMsg
	                            });
	                        }
	                    },'json');
	                }
	            });
	        }
	    } 
	    //提交前验证
	    addcontractitemForm.form('submit',{
	        url: url,
	        onSubmit: function(){
	            return $(this).form('validate');
	        },
	        success: function(result){
	            var result = eval('('+result+')');
	            if (result.errorMsg){
	                $.messager.show({
	                    title: 'Error',
	                    msg: result.errorMsg
	                });
	            } else {
	                $('#addcontractitemDialog').dialog('close');        // close the dialog
	                $('#contractitem').datagrid('reload');    // reload the user data
	            }
	        }
	    });
	});
</script>

</head>
<body>
	<!-- 内层dialog -->
	<div id="addcontractitemDialog" class="easyui-dialog" style="width: 350px" closed="true"
		buttons="#addcontractitemDialog-buttons">
		<form id="addcontractitemForm" method="post" url="/contractitem/save" novalidate
			style="margin: 0; padding: 20px 50px">
			<div
				style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">添加合同详情</div>
			<div>
				<input type="hidden" name="id" /></input>
			</div>
			<div>
				<input type="hidden" name="contract.id" /></input>
			</div>
			<div style="margin-bottom: 20px" align="center">
				付款时间:<input class="easyui-datebox" style="width: 200;">
			</div>
			<div style="margin-bottom: 10px" align="center">
				付款金额:<input name="lastname" class="easyui-textbox" required="true"
					style="width: 200">
			</div>
			<div style="margin-bottom: 10px" align="center">
				所占比例:<input name="phone" class="easyui-textbox" required="true"
					style="width: 200">
			</div>
			<div style="margin-bottom: 10px" align="center">
				是否付款:<input name="email" class="easyui-textbox" required="true"
					style="width: 200">
			</div>
		</form>
		<div id="addcontractitemDialog-contractitembuttons" align="center">
			<a href="javascript:void(0)" class="easyui-linkbutton c6"
				iconCls="icon-save" onclick="saveContractItem()" style="width: 60px">保存</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-cancel" onclick="javascript:$('#addcontractitemDialog').dialog('close')"
				style="width: 60px">取消</a>
		</div>
		<dir></dir>
	</div>
</body>
</html>