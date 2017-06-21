<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Highcharts Example</title>

		<%@include file="/WEB-INF/views/common.jsp"%>
		<script src="/static/js/highcharts/highcharts.js"></script>
		<script src="/static/js/highcharts/highcharts-3d.js"></script>
		<script src="/static/js/highcharts/modules/exporting.js"></script>
		<style type="text/css">
${demo.css}
		</style>
		<script type="text/javascript">
$(function () {
	
		$.get("/customer/moneyData",function(myData){
			  console.debug(myData);
			  
    $('#container').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: {
            text: 'Browser market shares at a specific website, 2014'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                    enabled: true,
                    format: '{point.name}'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [["gao",1],["xin",2],["bu",3]]
        }]
    });
		console.debug(myData);
		})	
});

		</script>
	</head>
	<body>



<div id="container" style="height: 400px"></div>
	</body>
</html>
