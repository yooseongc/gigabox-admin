<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>GigaBox 관리자 페이지</title>

<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Morris Charts CSS -->
<link href="/resources/vendor/morrisjs/morris.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<!-- jQuery -->
<script src="/resources/vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="/resources/dist/js/sb-admin-2.js"></script>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<!--Load the AJAX API-->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
//숫자 패딩 붙이기
function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (var i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}
  // Load the Visualization API and the corechart package.
  google.charts.load('current', {'packages':['corechart']});

  // Set a callback to run when the Google Visualization API is loaded.
  google.charts.setOnLoadCallback(drawAgeChart);
  google.charts.setOnLoadCallback(drawGenderChart);
  google.charts.setOnLoadCallback(drawRegisterChart);
  // Callback that creates and populates a data table,
  // instantiates the pie chart, passes in the data and
  // draws it.
function drawAgeChart() {
  var ageData;
  // 데이터 가져오기
  $.ajax({
		url: "/admin/stat/userAge",
		type: "GET",
		async: false,
		error: function() {
			console.log("시스템 오류입니다.");
		},
		success: function(data) {
			//var ageData = new Array();
			ageData = data;
		}
	});
  	
    // Create the data table.
    var data = new google.visualization.DataTable();
    
    data.addColumn('number', '나이');
    for (var i = 0; i < ageData.length; i++) {
    	for (var j = 0; j < ageData[i].count; j++) {
    		data.addRow([ageData[i].age]);
    	}
    }
    console.log(data);
   
    var options = {
        title: 'GIGABOX 회원 나이 분포',
        legend: { position: 'top', maxLines: 1 },
        histogram: { 
        	bucketSize: 5, 
        	minValue: 0,
      		maxValue: 60
      	},  
        interpolateNulls: false  
    };

    var chart = new google.visualization.Histogram(document.getElementById('ageChart'));
    chart.draw(data, options);

  }
  
function drawGenderChart() {
	var genderData;
	// 데이터 가져오기
	$.ajax({
		url: "/admin/stat/userGender",
		type: "GET",
		async: false,
		error: function() {
			console.log("시스템 오류입니다.");
		},
		success: function(data) {
			//var ageData = new Array();
			genderData = data;
		}
	});
	
	var data = google.visualization.arrayToDataTable([
      ['성별', '명'],
      ['남성', genderData[0].count],
      ['여성', genderData[1].count]
    ]);

    var options = {
      title: 'GIGABOX 회원 성별 분포',
      pieHole: 0.4,
    };

    var chart = new google.visualization.PieChart(document.getElementById('genderChart'));
    chart.draw(data, options);
}

function drawRegisterChart() {
	var registerData;
	var year = $("#year").val();
	var month = $("#month").val();
	
	var url;
	if (year == '') {
		year = 2017;
	} 
	url = "/admin/stat/userRegister?year=" + year;
	if (month != '') {
		url += "&month=" + leadingZeros(month, 2);
	}
	
	// 데이터 가져오기
	$.ajax({
		url: url,
		type: "GET",
		async: false,
		error: function() {
			console.log("시스템 오류입니다.");
		},
		success: function(data) {
			registerData = data;
			
		}
	});
	
	console.log(registerData);
	var data = new google.visualization.DataTable();
    data.addColumn('string', '월');
    data.addColumn('number', '가입자 수');
    for (var i = 0; i < registerData.length; i++) {
    	data.addRow([registerData[i].time, registerData[i].count]);
    }
	

    var options = {
      chart: {
          title: 'GIGABOX 월 별 가입자 수',
        },
        legend: { position: 'top', maxLines: 1 },
        hAxis: {
          title: '월',
        },
        vAxis: {
          title: '가입자 수'
        }
    };

    var chart = new google.visualization.ColumnChart(document.getElementById('registerChart'));
    chart.draw(data, options); 
}

</script>
</head>

<body>

	<div id="admin_userStat_wrapper">

		<c:import url="/templates/header.jsp" />
		<c:import url="/templates/aside.jsp" />



		<div id="page-wrapper">
			<section id="admin_userStat_section">
				<div class="row">
					<div class="col-lg-12">
						<h3 class="page-header">회원 통계 페이지</h3>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->


				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">
	                        <div class="panel-heading">
	                            <i class="fa fa-bar-chart-o fa-fw"></i> 전체 회원 통계
	                        </div>
	                        <!-- /.panel-heading -->
							<div class="panel-body">
								<div class="col-lg-6">
									<div id="ageChart"></div>
								</div>
								<!-- /.col-lg-6 -->
								<div class="col-lg-6">
									<div id="genderChart"></div>
								</div>
								<!-- /.col-lg-6 -->
							</div>
							<!-- /.panel-body -->
						</div>
                    	<!-- /.panel -->
					</div>
					
					
					
				</div>
				<!-- /.row -->
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">
	                        <div class="panel-heading">
	                            <i class="fa fa-bar-chart-o fa-fw"></i> 가입자수 통계
	                        </div>
	                        <!-- /.panel-heading -->
	                        <div class="panel-body">
	                        	<div class="col-lg-12">
									<div class="form-group">
										<label class="col-sm-2 control-label" for="year">연도</label>
										<div class="col-sm-10">
											<div class="input-group col-sm-12">
												<input type="number" class="form-control" name="year" id="year" 
													placeholder="YYYY" min="1970" max="2100">
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="month">월</label>
										<div class="col-sm-10">
											<div class="input-group col-sm-12" >
												<input type="number" class="form-control" name="month" id="month" 
													placeholder="MM" min="1" max="12">
											</div>
										</div>
									</div>
	                        	</div>
	                        	<hr>
	                        	<div class="col-lg-12">
		                            <div id="registerChart"></div>
	                        	</div>
	                        </div>
	                        <!-- /.panel-body -->
	                    </div>
                    	<!-- /.panel -->
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->

			</section>
			<!-- /#admin_main_section -->
		</div>
	</div>
	<!-- /#admin_main_wrapper -->

	<script type="text/javascript">
		$(document).ready(function() {
			$("#year").val(2017);
			$("#year,#month").on("change", function(e) {
				e.preventDefault();
				drawRegisterChart();
				 
			});
		});
	</script>

	<c:import url="/templates/footer.jsp" />



</body>

</html>
