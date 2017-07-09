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

Array.prototype.unique = function() {
    var a = {};
    for (var i = 0; i < this.length; i++) {
        if (typeof a[this[i]] == 'undefined') {
            a[this[i]] = 1;
        }
    }
    this.length = 0;
    for (var i in a) {
        this[this.length] = i;
    }
    return this;
};

  // Load the Visualization API and the corechart package.
  google.charts.load('current', {'packages':['corechart']});

  // Set a callback to run when the Google Visualization API is loaded.
  google.charts.setOnLoadCallback(drawMovieResvChart);
  google.charts.setOnLoadCallback(drawMovieSalesChart);
  // Callback that creates and populates a data table,
  // instantiates the pie chart, passes in the data and
  // draws it.
function drawMovieResvChart() {
	var resvData;
	var year = $("#year").val();
	var month = $("#month").val();
	
	var url;
	if (year == '') {
		year = 2017;
	} 
	url = "/admin/stat/movieResv?year=" + year;
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
			resvData = data;
			
		}
	});
	var movie = new Array();
	var time = new Array();
	var movieCount;
	var timeCount;
	for (var i = 0; i < resvData.length; i++) {
		movie.push(resvData[i].movie);
		time.push(resvData[i].time);
	}
	movie.unique();
	time.unique();
	movieCount = movie.length;
	timeCount = time.length;
	
	
	var data = new google.visualization.DataTable();
    data.addColumn('string', '월');
    for (var i = 0; i < movieCount; i++) {
    	data.addColumn('number', movie[i]);
    }
    for (var i = 0; i < timeCount; i++) {
    	var each = [time[i]];
    	for (var j = 0; j < movieCount; j++) {
    		each.push(resvData[2*i + j].count);
    	}
    	data.addRow(each);
    }
    console.log(data);
	

    var options = {
      chart: {
          title: 'GIGABOX 월 별 예약 수',
        },
        legend: { position: 'top', maxLines: 2 },
        hAxis: {
          title: '예매 수',
        },
        vAxis: {
          title: '월'
        }
    };

    var chart = new google.visualization.BarChart(document.getElementById('movieResvChart'));
    chart.draw(data, options); 

  }
  
function drawMovieSalesChart() {
	var resvData;
	var year = $("#year").val();
	var month = $("#month").val();
	
	var url;
	if (year == '') {
		year = 2017;
	} 
	url = "/admin/stat/moviePay?year=" + year;
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
			resvData = data;
		}
	});
	var movie = new Array();
	var time = new Array();
	var movieCount;
	var timeCount;
	for (var i = 0; i < resvData.length; i++) {
		movie.push(resvData[i].movie);
		time.push(resvData[i].time);
	}
	movie.unique();
	time.unique();
	movieCount = movie.length;
	timeCount = time.length;
	
	
	var data = new google.visualization.DataTable();
    data.addColumn('string', '월');
    for (var i = 0; i < movieCount; i++) {
    	data.addColumn('number', movie[i]);
    }
    for (var i = 0; i < timeCount; i++) {
    	var each = [time[i]];
    	for (var j = 0; j < movieCount; j++) {
    		each.push(resvData[2*i + j].total);
    	}
    	data.addRow(each);
    }
	

    var options = {
      chart: {
          title: 'GIGABOX 월 별 결제 금액',
        },
        legend: { position: 'top', maxLines: 2 },
        hAxis: {
          title: '월',
        },
        vAxis: {
          title: '결제 금액(원)'
        }
    };

    var chart = new google.visualization.ColumnChart(document.getElementById('movieSalesChart'));
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
						<h3 class="page-header">영화별 통계 페이지</h3>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->
				
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<i class="fa fa-bar-chart-o fa-fw"></i> 연도/월 선택
							</div>
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
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">
	                        <div class="panel-heading">
	                            <i class="fa fa-bar-chart-o fa-fw"></i> 예매 통계
	                        </div>
	                        <!-- /.panel-heading -->
							<div class="panel-body">
	                        	<div class="col-lg-12">
		                            <div id="movieResvChart"></div>
	                        	</div>
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
	                            <i class="fa fa-bar-chart-o fa-fw"></i> 매출 통계
	                        </div>
	                        <!-- /.panel-heading -->
	                        <div class="panel-body">
	                        	<div class="col-lg-12">
		                            <div id="movieSalesChart"></div>
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
			var date = new Date();
		    var year  = date.getFullYear();
		    var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
			$("#year").val(year);
		    $("#month").val(leadingZeros(month,2));
			$("#year,#month").on("change", function(e) {
				e.preventDefault();
				drawMovieResvChart();
				drawMovieSalesChart();
			});
		});
	</script>

	<c:import url="/templates/footer.jsp" />



</body>

</html>
