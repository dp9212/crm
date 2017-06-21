<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<script type="text/javascript">
	function printHTML(page) {
		var bodyHTML = window.document.body.innerHTML;
		window.document.body.innerHTML = $(page).html();
		window.print();
		window.document.body.innerHTML = bodyHTML;
	}
</script>
<meta charset="utf-8">
<script src="/static/easyui/jquery.min.js"></script>
<title></title>
<style type="text/css">;
	.header{
		padding-left: 20px;
	}
	.footer{
		border: 1px solid #666666;
		border-collapse: collapse;
	}
	.tr,.th{
		border: 1px solid #666666;
	}
}
</style>
</head>
<body>
	<script language="javascript">
		function printHTML(page) {
			var bodyHTML = window.document.body.innerHTML;
			window.document.body.innerHTML = $(page).html();
			window.print();
			window.document.body.innerHTML = bodyHTML;
		}
	</script>
	<a href="javascript:printHTML('#div1')" target="_self">打印</a>
	<div id='div1'>
		<p><h1><center>购销合同</center></h1></p>
		<div>
			<table class="header" width="100%" height="100px" >
				<tr>
					<td width="600px"></td>
					<td>合同编号：</td>
				</tr>
				<tr>
					<td width="600px">卖方：成都蓝源技术有限公司</td>
					<td>签订地点：成都市</td>
				</tr>
				<tr>
					<td width="600px">买方：</td>
					<td>签订时间：</td>
				</tr>
			</table>
		</div>
		<p>第一条	合同明细等情况</p>
		<div id="div2">
			<table class="footer" width="100%" height="100px">
				<tr>
					<th>id</th>
					<th>支付时间</th>
					<th>支付金额</th>
					<th>是否支付</th>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="5">合计人民币(大写)：</td>
				</tr>
			</table>
		</div>
		<p>第二条	陈品的质量标准与要求：按照样本标准执行</p>
		<p>第三条	计算方法：点件数核对</p>
		<p>第四条	包装方式和包装处理：每套工作服装塑料袋包装，包装费用由卖方承担</p>
		<p>第五条	交货方式：</p>
		<p>1.交货时间：合同签订后，卖方收到预付款后<u>30</u>日内交货完毕</p>
		<p>2.运输方式及运费：卖方负责汽车运输、运费含在单价中</p>
	</div>
</body>
</html>