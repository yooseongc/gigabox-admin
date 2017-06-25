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
<!-- Calendar -->
<script type="text/javascript" src='/resources/calendar/js/sweetalert.min.js?ver=1'></script>
<link rel="stylesheet" type="text/css" href='/resources/css/sweetalert.css?ver=1.2'>
<script type="text/javascript" src="/resources/calendar/js/stringBuffer.js"></script>
<script type="text/javascript" src="/resources/calendar/js/calendar.js"></script>
<script type="text/javascript" src="/resources/calendar/js/calendarSchdule.js"></script>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<style type="text/css">
thead {
	text-align: center;
}

thead td {
	width: 100px;
}

#tbody td {
	height: 150px;
}

#yearMonth {
	font: bold;
	font-size: 18px;
}
</style>
</head>

<body>

	<div id="admin_main_wrapper">

		<c:import url="/templates/header.jsp" />
		<c:import url="/templates/aside.jsp" />



		<div id="page-wrapper">
			<section id="admin_main_section">
				<div class="row">
					<div class="col-lg-12">
						<h3 class="page-header">관리자 메인 페이지</h3>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->


				<div class="row">
					<div class="col-lg-12">
						<table class="table table-bordered">
							<thead id='thead'>
								<tr>
									<td colspan="7">
										<button type='button' class='btn btn-sm btn-warning'
											id='moveFastPre' onclick="moveFastMonthPre()">&laquo;</button>
										&nbsp;
										<button type='button' class='btn btn-sm btn-warning' id='movePre'
											onclick="moveMonthPre()">&lsaquo;</button> &nbsp;&nbsp; <span
										id='yearMonth'></span> &nbsp;&nbsp;
										<button type='button' class='btn btn-sm btn-warning' id='moveNext'
											onclick="moveMonthNext()">&rsaquo;</button> &nbsp;
										<button type='button' class='btn btn-sm btn-warning'
											id='moveFastNext' onclick="moveFastMonthNext()">&raquo;</button>
										<div style="text-align: right;">
											<span>${title}</span> <input class='btn btn-sm btn-info'
												type="button" value="주" onclick='tabWeek()' /> <input
												class='btn btn-sm btn-info' type="button" value="월"
												onclick='tabMonth()' /><!--  <input class='btn btn-sm btn-info'
												type="button" value="목록" onclick='location.href="/coding"' /> -->
										</div>
									</td>
								</tr>
								<tr>
									<td>일<span class='week'></span></td>
									<td>월<span class='week'></span></td>
									<td>화<span class='week'></span></td>
									<td>수<span class='week'></span></td>
									<td>목<span class='week'></span></td>
									<td>금<span class='week'></span></td>
									<td>토<span class='week'></span></td>
								</tr>
							</thead>
							<tbody id='tbody'></tbody>
						</table>

					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->

			</section>
			<!-- /#admin_main_section -->
		</div>
	</div>
	<!-- /#admin_main_wrapper -->



	<!-- 일정 생성 modal -->
	<div class="modal fade" id="schduleForm" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">일정등록</h4>
				</div>
				<div class="modal-body">
					<form class='form-margin40' role='form' action="#" method='post'
						id='frmSchdule'>
						<div class='form-group'>
							<label>제목</label> <input type='text' class='form-control'
								id='summary' name='summary'
								placeholder="예: 오후 7시에 멕시코 음식점에서 저녁식사">
							<input type="hidden" id="chk" value="0" />
							<input type="hidden" id="calendarId" name="calendarId" value="${calendarId}">
						</div>
						<div class='form-group'>
							<label>시작시간</label> <input class='form-control' type="time"
								id='startTime' name='startTime'>
						</div>
						<div class='form-group'>
							<label>시작날짜</label> <input class='form-control startDate'
								type="date" id='startDate' name='startDate' readonly="readonly">
						</div>
						<div class='form-group'>
							<label>종료시간</label> <input class='form-control' type="time"
								id='endTime' name='endTime'>
						</div>
						<div class='form-group'>
							<label>종료날짜</label> <input class='form-control startDate'
								type="date" id='endDate' name='endDate'>
						</div>
						<div class='form-group'>
							<label>내용</label>
							<textarea rows="7" class='form-control' id="description"
								name='description'></textarea>
						</div>
						<div class='modal-footer'>
							<input type="button" class='btn btn-sm btn-warning' value="확인"
								onclick="calendarSchduleAdd()" /> <input type="reset"
								class='btn btn-sm btn-warning' value="초기화" /> <input
								type='button' class='btn btn-sm btn-warning'
								data-dismiss='modal' value="취소" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 일정 수정 modal -->
	<div class="modal fade" id="schduleFormModify" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">일정수정</h4>
				</div>
				<div class="modal-body">
					<form class='form-margin40' role='form' action="#" method='post'
						id='frmSchduleModify'>
						<div class='form-group'>
							<label>제목</label> <input type='text' class='form-control'
								id='modifySummary' name='summary'>
						</div>
						<div class='form-group'>
							<label>내용</label>
							<textarea rows="7" class='form-control' id="modifyDescription"
								name='description'></textarea>
						</div>
						<input type="hidden" id="modifyEventId" name="eventId" /> <input
							type="hidden" name="calendarId" value="${calendarId}" />
						<div class='modal-footer'>
							<input type="button" class='btn btn-sm btn-warning' value="확인"
								onclick="modifyEvent()" /> <input type="reset"
								class='btn btn-sm btn-warning' value="초기화" /> <input
								type='button' class='btn btn-sm btn-warning'
								data-dismiss='modal' value="취소" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>




	<c:import url="/templates/footer.jsp" />



</body>

</html>
