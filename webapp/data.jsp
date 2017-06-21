<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	$(function() {
		$("#datagrid").datagrid("reload");
	})
</script>
</head>
<%@include file="/WEB-INF/views/common.jsp"%>
<body>
<table id="datagrid" class="easyui-datagrid" url="/contractitem/json?keyWord=${param.id}" method="get"
	fitColumns="true" fit="true" style="width: 700px; height: 250px">
	<th>交易金额</th>
	<thead>
		<tr>
			<th data-options="field:'id',width:10" align="center">编号</th>
			<th data-options="field:'payTime',width:10,formatter:formatDateBoxFull" >支付时间</th>
			<th data-options="field:'money',width:10">支付金额</th>
			<th data-options="field:'isPayment',width:10,formatter:formatisPayment">是否支付</th>
			<th data-options="field:'scal',width:10">所占比例</th>
		</tr>
	</thead>
</table>
	<%-- <table class="dv-table" border="0" style="width: 100%">
		<tr>
			<th>交易金额</th>
			<th>交易时间</th>
			<th>是否支付</th>
			<th>所占比例${param.money}</th>
		</tr>
			<tr>
				<td>${rows.money}</td>
				<td>${rows.signTime}</td>
				<td>${rows.intro}</td>
				<td>${rows.scal}</td>
			</tr>
	</table> --%>
</body>
</html>