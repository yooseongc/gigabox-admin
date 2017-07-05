<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/movieroomTypeTag.tld" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>GigaBox 영화관 관리 페이지</title>

<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

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

<!-- jquery-seat-chart -->
<link rel="stylesheet" type="text/css" href="/resources/jquery-seat-chart/jquery.seat-charts.css">
<script src="/resources/jquery-seat-chart/jquery.seat-charts.js"></script> 


<style>
tr:hover td {
    background-color: #6495ED !important;
}

td {
    max-width: 150px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.pagination {
	display: block;
	text-align: center;
}

.pagination > li > a {
	float: none;
}


.modal-dialog,
.modal-content {
    /* 80% of window height */
    max-height: 90%;
}

.modal-body {
    /* 100% = dialog height, 120px = header + footer */
    max-height: calc(100% - 120px);
    overflow-y: scroll;
}

/* jquery-seat-chart */

.cinema-wrapper {
	
}

/* 스크린 부분 */
.front-indicator {
	background-color: #f6f6f6;	
	color: #adadad;
	text-align: center;
	border-radius: 5%;
	margin-bottom: 30px;
}

/* 오른쪽 설명 박스 */
.booking-details {
	text-align: left;
	font-size: 1.0em;
}
.booking-details h2 {
	margin: 20px 0 20px 0;
	font-size: 1.2em;
}

div.seatCharts-cell {
	color: #182C4E;
	height: 20px;
	width: 20px;
	line-height: 20px;
	margin: 1px 1px;
	
}
div.seatCharts-seat {
	color: #FFFFFF;
	cursor: pointer;	
}
div.seatCharts-row {
	height: 20px;
}
div.seatCharts-seat.available {
	background-color: #B9DEA0;

}


div.seatCharts-seat.available.standard {
	background-color: #3a78c3;
}
div.seatCharts-seat.available.prime {
	background-color: navy;
}
div.seatCharts-seat.available.dis {
	background-color: teal;
}
div.seatCharts-seat.available.way {
	background-color: silver;
}


div.seatCharts-seat.focused {
	background-color: #76B474;
}
div.seatCharts-seat.selected {
	background-color: #E6CAC4;
}
div.seatCharts-seat.unavailable {
	background-color: #472B34;
}
/* 좌석 배치표 여백 */
div.seatCharts-container {
	width: 690px;
	height: 520px;
}
div.seatCharts-legend {
	padding-left: 0px;
	position: relative;
	bottom: 16px;
}
ul.seatCharts-legendList {
	padding-left: 0px;
}
span.seatCharts-legendDescription {
	margin-left: 5px;
	line-height: 30px;
	margin-right: 20px;
	float: left;
}
.checkout-button {
	display: block;
	margin: 10px 0;
	font-size: 14px;
}
#selected-seats {
	max-height: 90px;
	overflow-y: scroll;
	overflow-x: none;
	width: 170px;
}

</style>

</head>
<body>

	<div id="admin_main_wrapper">

		<c:import url="/templates/header.jsp" />
		<c:import url="/templates/aside.jsp" />

		<div id="page-wrapper">
        <section id="admin_movieroom_section">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">상영관 관리 - ${branchInfo.branchName}</h3>
                    <input type="hidden" id="branchNumber" name="branchNumber" value="${branchInfo.branchNumber}">
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <div class="row">

                <div class="col-lg-12">
                <article id="admin_movieroom_table_article">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="height: 50px;">
                            <i class="fa fa-building-o fa-fw"></i> 상영관 목록
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-success btn-sm" id="movieroomInsertModalButton">상영관 추가</button>
                                </div>
                            </div>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-bordered table-hover" id="movieroomListTable">
                                <thead>
                                    <tr>
                                        <th class="center">상영관</th>
                                        <th class="center">상영관 타입</th>
                                        <th class="center">상영관 수정</th>
                                        <th class="center">좌석정보</th>
                                        <th class="center">상영일정</th>
                                    </tr>
                                </thead>
                                <tbody id="branchListTableBody">
                                	<c:forEach var="movieroomItem" items="${movieroomList}">
                                    <tr data-id="${movieroomItem.movieroomNumber}">
                                    	<td>${movieroomItem.movieroomName}</td>
                                        <td>
                                        	<tag:movieroomType movieroom2D="${movieroomItem.movieroom2D}" 
                                        		movieroom3D="${movieroomItem.movieroom3D}" 
                                        		movieroom4D="${movieroomItem.movieroom4D}"/>
                                        </td>
                                        <td style="text-align: center;">
                                        	<button class="btn btn-sm btn-default" 
                                        		data-num="${movieroomItem.movieroomNumber}"
	                                        	onclick="updateMovieroom(this, event);">수정</button>
	                                    </td>
                                        <td style="text-align: center;">
                                        	<button class="btn btn-sm btn-default" 
                                        		data-num="${movieroomItem.movieroomNumber}"
	                                        	onclick="viewSeat(this, event);">좌석정보</button>
	                                    </td>
	                                    <td style="text-align: center;">
	                                    	<button class="btn btn-sm btn-default" 
                                        		data-num="${movieroomItem.movieroomNumber}"
	                                        	onclick="viewSchedule(this, event);">상영일정</button>
	                                    </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                        <div class="panel-footer">
                        	
                        </div>
                    </div>
                    <!-- /.panel -->
                </article>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

        </section>
        <!-- /#admin_main_section -->
        </div>
    </div>
    <!-- /#admin_main_wrapper -->

    <!-- 지점 추가 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="movieroomInsertModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">상영관 추가</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="movieroomInsertForm">
                			<input type="hidden" id="movieroomNumberI" name="movieroomNumber">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieroomNameI">상영관 이름</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieroomNameI" 
                							name="movieroomName" type="text">
                					</div>
                				</div>
                			</div>
                			<hr>
                			<div class="form-group">
                				<label class="col-sm-2 control-label">상영관 타입</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                                        <label class="checkbox-inline">
                                            <input id="movieroom2DI" type="checkbox" name="movieroom2D" value="Y"> 2D
                                        </label>
                                        <label class="checkbox-inline">
                                            <input id="movieroom3DI" type="checkbox" name="movieroom3D" value="Y"> 3D
                                        </label>
                                        <label class="checkbox-inline">
                                            <input id="movieroom4DI" type="checkbox" name="movieroom4D" value="Y"> 4D
                                        </label>
               						</div>
                				</div>
                			</div>
                			<input type="hidden" id="branchNumberI" name="branchNumber">
                			<input type="hidden" id="movieroomSeatdataI" name="movieroomSeatdata" value="none">
                			<hr>
                			
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="movieroomInsertModalSaveButton" type="button" class="btn btn-success" data-dismiss="modal">저장</button>
                     <button id="movieroomInsertModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
	
	<script>
	
	// replace char 
	function replaceAt(string, index, replace) {
  		return string.substring(0, index) + replace + string.substring(index + 1);
	}
	
	// redraw function
	function changePrice() {
		$('.seatCharts-row').remove();
		$('.seatCharts-legendItem').remove();
		$('#seat-map,#seat-map *').unbind().removeData();
		sc = $("#seat-map").seatCharts({
			map: map, 
			seats: seats,
			naming: naming,
			legend: legend,
			click: click
		});
		return map;
	}
	
	function mapLoad(loadmap, loadseats) {
		map = loadmap;
		seats = loadseats;
		
		$('.seatCharts-row').remove();
		$('.seatCharts-legendItem').remove();
		$('#seat-map,#seat-map *').unbind().removeData();
		var rowCount = $("#rowCount").val();
		var colCount = $("#colCount").val();
		sc = $("#seat-map").seatCharts({
			map: map, 
			seats: seats,
			naming: naming,
			legend: legend,
			click: click
		});
		$("#seat-map").css("width", 22*(parseInt(colCount)+1));
	}
	
	function redraw(oldChar, locString) { 
		var newChar;
		var row;
		var col;
		var newCol;
		
		if (oldChar == "w") {
			newChar = "s";
		} else if (oldChar == "s") {
			newChar = "p";
		} else if (oldChar == "p") {
			newChar = "d";
		} else if (oldChar == "d") {
			newChar = "w";
		}
		row = locString.split("_")[0];
		col = locString.split("_")[1];
		newCol = replaceAt(map[row-1], col-1, newChar);
		map[row-1] = newCol;
		firstSeatLabel = 1;
		$('.seatCharts-row').remove();
		$('.seatCharts-legendItem').remove();
		$('#seat-map,#seat-map *').unbind().removeData();
		sc = $("#seat-map").seatCharts({
			map: map, 
			seats: seats,
			naming: naming,
			legend: legend,
			click: click
		});
		return map;
	}
			
	$(document).ready(function() {
				
		var sc;
		var firstSeatLabel = 1;
		var rowfirstSeatLabelASCII = 65; // 대문자 A
		var colfirstSeatLabelASCII = 1; 
		
		var szPrice = $("#standardZonePrice").val();
		var pzPrice = $("#primeZonePrice").val();
		var dzPrice = $("#disabledZonePrice").val();
		
		var rowCount = $("#rowCount").val();
		var colCount = $("#colCount").val();
		
		map = ['w'];
		
		seats = {
			s: {
				price   : szPrice,
				classes : 'standard', //your custom CSS class
				category: 'Standard Zone'
			},
			p: {
				price   : pzPrice,
				classes : 'prime', //your custom CSS class
				category: 'Prime Zone'
			},					
			d: {
				price   : dzPrice,
				classes : 'dis', //your custom CSS class
				category: '장애인석'
			},
			w: {
				price   : 0,
				classes : 'way',
				category: '통로'
			}
		};
		
		naming = {
			top : false,
			getLabel : function (character, row, column) {
				if (row == 1 && column == 1) {
					firstSeatLabel = 1;
				}
				return firstSeatLabel++;
			},
		};
		legend = {
			node : $('#legend'),
		    items : [
				[ 's', 'available',   'Standard Zone' ],
				[ 'p', 'available',   'Prime Zone'],
				[ 'd', 'available', '장애인석'],
				[ 'w', 'available', '통로' ]
		    ]					
		};
		click = function () {
			redraw(this.char(), this.node().attr("id"));
			return;
		};
		
		$("#seatSizeButton").on("click", function(e) {
			e.preventDefault();
			console.log("change rows and cols!!!");
			rowCount = $("#rowCount").val();
			colCount = $("#colCount").val();
			console.log("row: " + rowCount);
			console.log("col: " + colCount);
			var newMap = new Array();
			var col = "";
			for (var i = 0; i < colCount; i++) {
				col += "w";
			}
			for (var j = 0; j < rowCount; j++) {
				newMap.push(col);
			}
			map = newMap;
			// seatCharts-container 사이즈 조절
			
			$('.seatCharts-row').remove();
			$('.seatCharts-legendItem').remove();
			$('#seat-map,#seat-map *').unbind().removeData();
			
			sc = $("#seat-map").seatCharts({
				map: map, 
				seats: seats,
				naming: naming,
				legend: legend,
				click: click
			});
			$("#seat-map").css("width", 22*(parseInt(colCount)+1));
		});
		
		$("#standardZonePrice,#primeZonePrice,#disabledZonePrice").on("change", function(e) {
			e.preventDefault();
			console.log("change price!!!");
			szPrice = $("#standardZonePrice").val();
			pzPrice = $("#primeZonePrice").val();
			dzPrice = $("#disabledZonePrice").val();

			
			seats = {
					s: {
						price   : szPrice,
						classes : 'standard', //your custom CSS class
						category: 'Standard Zone  '
					},
					p: {
						price   : pzPrice,
						classes : 'prime', //your custom CSS class
						category: 'Prime Zone  '
					},					
					d: {
						price   : dzPrice,
						classes : 'dis', //your custom CSS class
						category: '장애인석  '
					},
					w: {
						price   : 0,
						classes : 'way',
						category: '통로'
					}
				};
			changePrice();
		});
				
		
	});

		
	</script>
	
	<!-- 상영관 수정 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="movieroomUpdateModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">상영관 수정</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="movieroomUpdateForm">
                			<input type="hidden" id="movieroomNumberU" name="movieroomNumber">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieroomNameU">상영관 이름</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieroomNameU" 
                							name="movieroomName" type="text">
                					</div>
                				</div>
                			</div>
                			<hr>
                			<div class="form-group">
                				<label class="col-sm-2 control-label">상영관 타입</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                                        <label class="checkbox-inline">
                                            <input id="movieroom2DU" type="checkbox" name="movieroom2D" value="Y"> 2D
                                        </label>
                                        <label class="checkbox-inline">
                                            <input id="movieroom3DU" type="checkbox" name="movieroom3D" value="Y"> 3D
                                        </label>
                                        <label class="checkbox-inline">
                                            <input id="movieroom4DU" type="checkbox" name="movieroom4D" value="Y"> 4D
                                        </label>
               						</div>
                				</div>
                			</div>
                			<input type="hidden" id="branchNumberU" name="branchNumber">
                			<hr>
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="movieroomUpdateModalSaveButton" type="button" class="btn btn-success" data-dismiss="modal">저장</button>
                     <button id="movieroomUpdateModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
	

	<!-- 좌석 정보 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="seatDataModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="modalLabel"><span id="movieroomName" style="font-weight: bold; font-size: 1.2em"></span></h4>
                </div>
                <div class="modal-body">
                	<div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="col-md-12">
                        		<input type="hidden" id="seatDataModalMovieroomNumber">
	                            <div class="form-group">
	                				<label class="col-sm-2 control-label">좌석 설정</label>
	                				<div class="col-sm-10 cinema-wrapper">
										<div class="form-group">
			                				<label class="col-sm-2 control-label" for="colCount">열 수</label>
			                				<div class="col-sm-9">
			                					<div class="input-group col-sm-12">
			                						<input class="form-control" type="number" 
			                							id="colCount" name="colCount" value="1" min="1" max="30"> 
			                					</div>
			                				</div>
			                			</div>
										<div class="form-group">
			                				<label class="col-sm-2 control-label" for="rowCount">행 수</label>
			                				<div class="col-sm-9">
			                					<div class="input-group col-sm-12">
			                						<input class="form-control" type="number" 
			                							id="rowCount" name="rowCount" value="1" min="1" max="20"> 
			                					</div>
			                				</div>
			                				<div class="col-sm-1">
			                					<button class="btn btn-sm btn-default" 
			                						type="button" id="seatSizeButton">선택</button>
			                				</div>
			                			</div>
			                			<br><br><br><hr>
	                					<div class="input-group col-sm-12">
	                                    	<div id="seat-map">
												<div class="front-indicator">스&nbsp;&nbsp;&nbsp;크&nbsp;&nbsp;&nbsp;린</div>
											</div>
											<div class="booking-details">
												<div id="legend"></div>
												<br><br>
												<hr>
												<h2>가격 설정 (원)</h2>
												<div class="form-group">
					                				<label class="col-sm-3 control-label" for="standardZonePrice">Standard Zone</label>
					                				<div class="col-sm-9">
					                					<div class="input-group col-sm-10">
					                						<input class="form-control" type="number" 
					                							id="standardZonePrice" name="standardZonePrice" value="10000"> 
					                					</div>
					                				</div>
					                			</div>
												<div class="form-group">
					                				<label class="col-sm-3 control-label" for="primeZonePrice">Prime Zone</label>
					                				<div class="col-sm-9">
					                					<div class="input-group col-sm-10">
					                						<input class="form-control" type="number" 
					                							id="primeZonePrice" name="primeZonePrice" value="12000"> 
					                					</div>
					                				</div>
					                			</div>
												<div class="form-group">
					                				<label class="col-sm-3 control-label" for="disabledZonePrice">장애인석</label>
					                				<div class="col-sm-9">
					                					<div class="input-group col-sm-10">
					                						<input class="form-control" type="number" 
					                							id="disabledZonePrice" name="disabledZonePrice" value="5000"> 
					                					</div>
					                				</div>
					                			</div>
											</div>
										</div>
	               					</div>
	                			</div>
	                        </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->      	
                </div>
                <div class="modal-footer">
                	 <button id="seatDataUpdateButton" type="button" class="btn btn-sm btn-success">좌석 정보 변경</button>
                     <button id="seatDataModalCloseButton" type="button" class="btn btn-sm btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

	<c:import url="/templates/footer.jsp" />
	

	<script>
	
	// 상영관 정보 수정 모달 띄우기
	function updateMovieroom(that, event) {
		event.preventDefault();
		// movieroomNumber
		var dataNum = $(that).attr("data-num");
		$("#movieroomNumber")
		$.ajax({
			url: "/admin/cinema/movieroomDetail/" + dataNum,
			type: "PUT",
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "PUT"
			},
			error: function() {
				alert("시스템 오류입니다.");
			},
			success: function(data) {
				
				console.log(data);
				// 정보 넣기
				$("#movieroomNumberU").val(data.movieroomNumber);
				$("#movieroomNameU").val(data.movieroomName);
				if (data.movieroom2D == "Y") {
					$("#movieroom2DU").prop("checked", true);
				} 
				if (data.movieroom3D == "Y") {
					$("#movieroom3DU").prop("checked", true);
				} 
				if (data.movieroom4D == "Y") {
					$("#movieroom4DU").prop("checked", true);
				}
				
				// 상영관 수정 모달 띄우기
	            $('#movieroomUpdateModal').modal({
			        show: true, 
			        backdrop: 'static',
			        keyboard: true
			    });
			}
		});
		
		
	}
	
	// 상영관 좌석정보 모달 띄우기
	function viewSeat(that, event) {
		event.preventDefault();
		// movieroomNumber
		var dataNum = $(that).attr("data-num");
		$("#seatDataModalMovieroomNumber").val(dataNum);
		$("#movieroomName").text($(that).parents("tr[data-id="+dataNum+"]").find("td:eq(0)").text());
		$.ajax({
				url: "http://choiys3574.cafe24.com/upload/gigabox/movieroom/" + dataNum + "/seatdata",
				type: "GET",
				error: function() {
					alert("기존 좌석 정보가 존재하지 않습니다.\n새로 작성해 주세요.");
					
				},
				success: function(data) {
					console.log(data);
					var row = data.map.length;
					var col = data.map[0].length;
					$("#rowCount").val(row);
					$("#colCount").val(col);
					map = data.map;
					seats = data.seats;
					mapLoad(map, seats);
				}
		});
		$('#seatDataModal').modal({
	        show: true, 
	        backdrop: 'static',
	        keyboard: true
	    });
	}
	
	// 상영관 상영일정 모달
	function viewSchedule(that, event) {
		event.preventDefault();
		var dataNum = $(that).attr("data-num");
		var movieroomName = $(that).parents("tr[data-id="+dataNum+"]").find("td:eq(0)").text();
		location.href = "/admin/cinema/branch/${branchInfo.branchNumber}/schedule?searchType=m&searchKeyword="+movieroomName;
		
	}
	
	// 숫자 패딩 붙이기
	function leadingZeros(n, digits) {
	  var zero = '';
	  n = n.toString();

	  if (n.length < digits) {
	    for (var i = 0; i < digits - n.length; i++)
	      zero += '0';
	  }
	  return zero + n;
	}
	
	
	
	$(document).ready(function() {
		
		// 상영관 추가 모달
		$("#movieroomInsertModalButton").click(function(e) {
			e.preventDefault();
			$('#movieroomInsertModal').modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
			
		});
			
		// 상영관 추가 모달 닫기 버튼
		$("#movieroomInsertModalCloseButton").click(function() {
			$("#movieroomInsertModal").modal("hide");
			$("#movieroomInsertForm")[0].reset();
		}); 
		
		// 상영관 추가 서밋
		$("#movieroomInsertModalSaveButton").click(function(e) {
			/* 
				http://choiys3574.cafe24.com/upload/gigabox/movieroom/{movieroomNumber}/seatdata
			*/
			$("#branchNumberI").val($("#branchNumber").val());
			$("#movieroomSeatdataI").val("http://choiys3574.cafe24.com/upload/gigabox/movieroom/");
			$.ajax({
				url: "/admin/cinema/movieroomInsert",
				type: "POST",
				data: $("#movieroomInsertForm").serialize(),
				error: function() {
					alert("시스템 오류입니다.");
				},
				success: function(res) {
					alert("상영관 추가에 성공하였습니다.");
					self.location.reload(true);
				}
			}); 
		});
		
		// 좌석 정보 보기 > 저장
		$("#seatDataUpdateButton").click(function(e) {
			e.preventDefault();
			var jsonObj = JSON.stringify({map: map, seats: seats});
			$.ajax({
				url: "http://choiys3574.cafe24.com/upload/gigabox/movieroom/seatdata",
				type: "POST",
				data: {
					fileName: $("#seatDataModalMovieroomNumber").val(),
		        	fileDir: "upload/gigabox/movieroom/",
		        	purpose: "seatdata",
		        	fileType: "txt",
		        	jsonStr: jsonObj
				},
				error: function() {
					alert("시스템 오류입니다.");
				},
				success: function(data) {
					console.log(data);
					if (data.message == "SUCCESSE") {
						alert("등록에 성공하였습니다.");
					} else {
						alert(data.message);
					}
				}
			});
		});
		
		// 좌석 정보 보기 > 닫기버튼
		$("#seatDataModalCloseButton").click(function() {
			$('#seatDataModal').modal("hide");
		});
		
			
		// 상영관 정보 수정
		$("#movieroomUpdateModalSaveButton").click(function() {
			$("#branchNumberU").val($("#branchNumber").val());
			$.ajax({
				url: "/admin/cinema/movieroomUpdate",
				type: "POST",
				data: $("#movieroomUpdateForm").serialize(),
				error: function() {
					alert("시스템 오류입니다.");
				},
				success: function(res) {
					alert("수정되었습니다.");
					self.location.reload(true);
				}
			});
		});
			
		// 영화 정보 수정 모달 닫기 버튼
		$("#movieroomUpdateModalCloseButton").click(function() {
			$('#movieroomUpdateModal').modal("hide");
		});
	});
			
	</script>

</body>
</html>
