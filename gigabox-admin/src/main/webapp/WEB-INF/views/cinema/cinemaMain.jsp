<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/movieGenreTag.tld" %>
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

<!-- jQuery-File-Upload-Plugin with Bootstrap -->
<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
<link rel="stylesheet" href="/resources/jQuery-File-Upload-master/css/jquery.fileupload.css">

<!-- google map api -->
<script type="text/javascript" 
	src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBeynzuOxYNEktxWHuq-satcvafbYmG47o">
</script>

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
    height: 90%;
}

.modal-body {
    /* 100% = dialog height, 120px = header + footer */
    max-height: calc(100% - 120px);
    overflow-y: scroll;
}

/* The Modal (background) */
#imageModal.modal, #videoModal.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 9999; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
}

#imageModal.modal-body #videoModal.modal-body {
	max-height: inherit;
    overflow: auto;
}

/* Modal Content (Image) */
#imageModal .modal-content, #videoModal.modal-content {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
    align-items: center;
}

/* Caption of Modal Image (Image Text) - Same Width as the Image */
#imageModalCaption {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
    text-align: center;
    color: #ccc;
    padding: 10px 0;
    height: 150px;
}

/* Add Animation - Zoom in the Modal */
#imageModal.modal-content, #videoModal.modal-content, #imageModalCaption { 
    -webkit-animation-name: zoom;
    -webkit-animation-duration: 0.6s;
    animation-name: zoom;
    animation-duration: 0.6s;
}

@-webkit-keyframes zoom {
    from {-webkit-transform:scale(0)} 
    to {-webkit-transform:scale(1)}
}

@keyframes zoom {
    from {transform:scale(0)} 
    to {transform:scale(1)}
}

</style>


<!-- GoogoleMap Asynchronously Loading the API ********************************************* -->
<script type="text/javascript">
    function initialize(cinemaName, cinemaAddr) {
     
        var mapOptions = {
                            zoom: 18, // 지도를 띄웠을 때의 줌 크기
                            mapTypeId: google.maps.MapTypeId.ROADMAP
                        };
         
         
        var map = new google.maps.Map(document.getElementById("branchGoogleMap"), // div의 id과 값이 같아야 함. "map-canvas"
                                    mapOptions);
         
        
        // Geocoding *****************************************************
        var address = cinemaAddr; // DB에서 주소 가져와서 검색하거나 왼쪽과 같이 주소를 바로 코딩.
        var marker = null;
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode( { 'address': address}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                marker = new google.maps.Marker({
                                map: map,
                                title: 'GIGABOX' + cinemaName, // 마커에 마우스 포인트를 갖다댔을 때 뜨는 타이틀
                                position: results[0].geometry.location
                            });
 
                var content = "GIGABOX<br>" + cinemaName; // 말풍선 안에 들어갈 내용
             
                // 마커를 클릭했을 때의 이벤트. 말풍선 뿅~
                var infowindow = new google.maps.InfoWindow({ content: content});
                google.maps.event.addListener(marker, "click", function() {infowindow.open(map,marker);});
            } else {
                console.log("Geocode was not successful for the following reason: " + status);
            }
        });
        // Geocoding // *****************************************************
         
    }
    //google.maps.event.addDomListener(window, 'load', initialize);
</script>

</head>
<body>

	<div id="admin_main_wrapper">

		<c:import url="/templates/header.jsp" />
		<c:import url="/templates/aside.jsp" />

		<div id="page-wrapper">
        <section id="admin_cinema_main_section">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">영화관 관리 페이지</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <div class="row">

                <div class="col-lg-12">
                <article id="admin_movie_control_article">

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-sitemap fa-fw"></i> 지점 검색
                        </div>
                        <!-- /.panel-heading -->
                        <form role="form" id="branchSearchForm">
                        <div class="panel-body">
                            <div class="list-group">
                                <div class="list-group-item">
                                    <span class="pull-left text-muted" style="width: 80px; text-align: center;">지점 선택&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <div class="form-group input-group" style="width: 500px;">
                                    	<span class="input-group-addon">지역 : </span>
                                        <select class="form-control"
                                        	name="branchLocation" id="branchLocation">
	                                        <option value="전체">전체</option>
	                                        
	                                    </select>  
	                                    <span class="input-group-addon">지점 : </span>
                                        <select class="form-control"
                                        	name="branchLocationName" id="branchLocationName">
	                                        <option value="전체">전체</option>
	                                        
	                                    </select>
                                    </div>
                                </div>
                            </div>
                            <!-- /.list-group -->
                        </div>
                        <!-- /.panel-body -->
                        
                        </form>
                    </div>
                    <!-- /.panel -->
                </article>
                </div>
                <!-- /.col-lg-12 -->

<script>
	$(document).ready(function() {
		
		var branchNames;
		// branchname 미리 주기
		$.ajax({
			url: "/admin/cinema/branchnameList",
			type: "PUT",
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "PUT"
			},
			error: function() {
				console.log("지점 이름 불러오기 실패");
			},
			success: function(data) {
				branchNames = data;
				branchLocArr = new Array();
				branchLocUniq = new Array();
				for (var i = 0; i < data.length; i++) {
					// 풀네임
					var eachFullName = data[i].branchName;
					
					// 지역명
					var branchLocations = eachFullName.split(" ")[0];
					branchLocArr.push(branchLocations);
					
					// 지점명
					var branchLocationNames = eachFullName.split(" ")[1];
					
					// 지점 -> 풀네임
					if ($("#branchLocation").val() == branchLocations || $("#branchLocation").val() == "전체") {
						$("#branchLocationName").append("<option value='" + eachFullName + "'>" + eachFullName + "</option>");
					}
					
				}	
				
				// 지역명 중복 제거
				$.each(branchLocArr, function(i, el){
				    if($.inArray(el, branchLocUniq) === -1) {
				    	branchLocUniq.push(el);
				    }
				});
				
				for (var i = 0; i < branchLocUniq.length; i++) {
					$("#branchLocation").append("<option value='" + branchLocUniq[i] + "'>" + branchLocUniq[i] + "</option>");
				}
				
				console.log("지점 이름 불러오기 성공");
				
				// 페이지 로딩시 자동선택
				if ('${param.branchLocation}' != '') {
					$("#branchLocation option").each(function() {
						console.log($(this).val());
						if ($(this).val() == "${param.branchLocation}") {
							$(this).prop("selected", true);
						}
					});
					//$("#branchLocation").val('${param.branchLocation}');
				}
				if ('${param.branchLocationName}' != '') {
					$("#branchLocationName option").each(function() {
						if ($(this).val() == "${param.branchLocationName}") {
							$(this).prop("selected", true);
						}
					});
					//$("#branchLocatioinName").val('${param.branchLocationName}');
				}
			}
		});
		
		
		
		$("#branchLocation").on("change", function(event) {
			event.preventDefault();
			var queryString = "/admin/cinema/cinemaMain"
				+ '${pageMaker.makeQuery(1)}'
				+ "&branchLocation=" + $("#branchLocation").val()
			self.location = queryString;
		});
		
		$("#branchLocationName").on("change", function(event) {
			event.preventDefault();
			var queryString = "/admin/cinema/cinemaMain"
				+ '${pageMaker.makeQuery(1)}'
				+ "&branchLocation=" + $("#branchLocation").val()
				+ "&branchLocationName=" + $("#branchLocationName").val()
			self.location = queryString;
		});
		
		$('#branchSearchButton').on("click", function(event) {
			event.preventDefault();
			var queryString = "/admin/cinema/cinemaMain"
				+ '${pageMaker.makeQuery(1)}'
				+ "&branchLocation=" + $("#branchLocation").val()
				+ "&branchLocationName=" + $('#branchLocationName').val();
			
			self.location = queryString;
		});
		
	});
</script>			

                <div class="col-lg-12">
                <article id="admin_ciname_table_article">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="height: 50px;">
                            <i class="fa fa-building-o fa-fw"></i> 지점 목록
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-success btn-sm" id="branchInsertModalButton">지점 추가</button>
                                </div>
                            </div>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-bordered table-hover" id="branchListTable">
                                <thead>
                                    <tr>
                                        <th class="center">지점 번호</th>
                                        <th class="center">지점명</th>
                                        <th class="center">지점 주소</th>
                                        <th class="center">지점 관리</th>
                                        <th class="center">상영관 관리</th>
                                        <th class="center">상영일정 관리</th>
                                    </tr>
                                </thead>
                                <tbody id="branchListTableBody">
                                	<c:forEach var="branchItem" items="${branchList}">
                                    <tr data-id="${branchItem.branchNumber}">
                                        <td>${branchItem.branchNumber}</td>
                                        <td>${branchItem.branchName}</td>
                                        <td>${branchItem.branchAddress}</td>
                                        <td style="text-align: center;">
                                        	<button class="btn btn-sm btn-default" 
                                        		data-num="${branchItem.branchNumber}"
	                                        	onclick="viewBranchDetail(this, event);">지점 관리</button>
	                                    </td>
	                                    <td style="text-align: center;">
	                                    	<button class="btn btn-sm btn-default" 
                                        		data-num="${branchItem.branchNumber}"
	                                        	onclick="viewBranchMovieroom(this, event);">상영관 관리</button>
	                                    </td>
                                        <td style="text-align: center;">
                                        	<button class="btn btn-sm btn-default" 
                                        		data-num="${branchItem.branchNumber}"
	                                        	onclick="viewBranchSchedule(this, event);">상영일정 관리</button>
	                                    </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                        <div class="panel-footer">
                        	<div class="text-center">
						<ul class="pagination">

							<c:if test="${pageMaker.prev}">
								<li><a href="/admin/cinema/cinemaMain${pageMaker.makeQuery(pageMaker.startPage-1)}">&laquo;</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}" var="idx">
								<li 
									<c:out value="${pageMaker.criteria.page == idx?'class=\"active\"':''}"/>>
									<a href="/admin/cinema/cinemaMain${pageMaker.makeQuery(idx)}">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a href="/admin/cinema/cinemaMain${pageMaker.makeQuery(pageMaker.endPage+1)}">&raquo;</a></li>
							</c:if>

						</ul>
					</div>
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
    <div class="modal fade" id="branchInsertModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">지점 추가</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="branchInsertForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="branchLocationI">지역</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="branchLocationI" name="branchLocation">
                							<option value="서울">서울</option>
                							<option value="경기">경기</option>
                							<option value="인천">인천</option>
                							<option value="충청">충청</option>
                							<option value="대전">대전</option>
                							<option value="세종">세종</option>
                							<option value="전라">전라</option>
                							<option value="광주">광주</option>
                							<option value="경상">경상</option>
                							<option value="대구">대구</option>
                							<option value="울산">울산</option>
                							<option value="부산">부산</option>
                							<option value="강원">강원</option>
                							<option value="제주">제주</option>
                						</select>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="branchLocationNameI">지점</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<input class="form-control" type="text" 
	                						id="branchLocationNameI" name="branchLocationName">
	                					<input type="hidden" id="branchNameI" name="branchName">
               						</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="branchAddressI">주소</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="branchAddressI" 
                							name="branchAddress" type="text">
                					</div>
                				</div>
                			</div>
                			<input type="hidden" id="branchPictureI" name="branchPicture">
                			
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="branchInsertModalSaveButton" type="button" class="btn btn-success" data-dismiss="modal">저장</button>
                     <button id="branchInsertModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
	
	
	<!-- 지점 수정 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="branchUpdateModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">지점 수정</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="branchUpdateForm">
                			<input type="hidden" id="branchNumberU" name="branchNumber">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="branchLocationU">지역</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="branchLocationU" name="branchLocation">
                							<option value="서울">서울</option>
                							<option value="경기">경기</option>
                							<option value="인천">인천</option>
                							<option value="충청">충청</option>
                							<option value="대전">대전</option>
                							<option value="세종">세종</option>
                							<option value="전라">전라</option>
                							<option value="광주">광주</option>
                							<option value="경상">경상</option>
                							<option value="대구">대구</option>
                							<option value="울산">울산</option>
                							<option value="부산">부산</option>
                							<option value="강원">강원</option>
                							<option value="제주">제주</option>
                						</select>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="branchLocationNameU">지점</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<input class="form-control" type="text" 
	                						id="branchLocationNameU" name="branchLocationName">
	                					<input type="hidden" id="branchNameU" name="branchName">
               						</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="branchAddressU">주소</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="branchAddressU" 
                							name="branchAddress" type="text">
                					</div>
                				</div>
                			</div>
                			<input type="hidden" id="branchPictureU" name="branchPicture">
                		</form>
                		
                		<div class="form-group">
                			<label class="col-sm-2 control-label" for="pictureUploadU">지점사진 업로드</label>
                			<div class="col-sm-12">
							    <input id="pictureUploadU" type="file" name="pictureUpload" data-url="http://choiys3574.cafe24.com/upload/gigabox/branch/picture">
							    <table class="table table-hover table-bordered">
							        <thead>
								        <tr>
								            <th>파일 이름</th>
								            <th>타입</th>
								            <th>보기</th>
								            <th>삭제</th>
								        </tr>
							        </thead>
							        <tbody id="uploadedPictureFile">
							        </tbody>
							    </table>
							</div>
						</div>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="branchUpdateModalSaveButton" type="button" class="btn btn-success" data-dismiss="modal">저장</button>
                     <button id="branchUpdateModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
	

	<!-- 상세보기용 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="branchDetailModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="modalLabel"><span id="detailBranchName" style="font-weight: bold; font-size: 1.2em"></span></h4>
                </div>
                <div class="modal-body">
                	<div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="col-md-12">
                        		<div class="hide" data-id="branchNumber"></div>
                               	<div class="jumbotron" id="branchPictureView"
                               		style="height: 200px; background-image: url(http://image2.megabox.co.kr/mop/cinema/2017/C0/503678-694F-4E73-B6D5-A798E2B142E4.jpg); background-size: 100% auto;">
								</div>
	                            <div class="list-group">
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">지점 주소</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: clip;" data-id="branchAddress"></div>
	                                	<!-- 구글 맵 -->
	                                	<div class="well col-md-12" id="branchGoogleMap" 
	                                		style="width:100%; height: 400px !important;">
	                                	
	                                	</div>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">지점 사진</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="branchPicture"></div>
	                                	<table id="pictureListTable" class="table table-bordered table-hover">
	                                		<thead>
	                                			<tr>
										            <th>파일 이름</th>
										            <th>보기</th>
										        </tr>
	                                		</thead>
	                                		<tbody id="pictureListTableBody">
	                                			
	                                		</tbody>
	                                	</table>
	                                </div>
	                            </div>
	                            <!-- /.list-group -->
	                        </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->      	
                </div>
                <div class="modal-footer">
                	 <button id="branchUpdateButton" type="button" class="btn btn-sm btn-success">지점 정보 변경</button>
                     <button id="branchDetailModalCloseButton" type="button" class="btn btn-sm btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

	<c:import url="/templates/footer.jsp" />
	
	
	<!-- The Image View Modal -->
	<div id="imageModal" class="modal">
		  <!-- Modal Content (The Image) -->
		  <img class="modal-content" id="imageModalItem" style="width: 100%; height: auto;">
		  <!-- Modal Caption (Image Text) -->
		  <div id="imageModalCaption"></div>
	</div>
	

	<script>
	
	// 지점 상영관 관리 페이지로 이동
	function viewBranchMovieroom(that, event) {
		event.preventDefault();
		var branchNum = $(that).attr("data-num");
		location.href = "/admin/cinema/"+branchNum+"/movieroom";
	}
	
	// 지점 상영일정 관리 페이지로 이동
	function viewBranchSchedule(that, event) {
		event.preventDefault();
		var branchNum = $(that).attr("data-num");
		location.href = "/admin/cinema/branch/"+branchNum+"/schedule";
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
	
	// 지점 상세보기
	function viewBranchDetail(that, e) {
		e.preventDefault();
		console.log(that);
		var dataNum = $(that).attr("data-num");
		console.log(dataNum);
		$.ajax({
			url: "/admin/cinema/branchDetail/" + dataNum,
			type: "PUT",
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "PUT"
			},
			error: function() {
				alert("시스템 오류입니다.");
			},
			success: function(data) {
				
				$("#detailBranchName").text(data.branchName);
				$("p[data-id=branchName]").text(data.branchName);
				$("div[data-id=branchNumber]").text(data.branchNumber);
				$("div[data-id=branchAddress]").text(data.branchAddress);
				$("div[data-id=branchPicture]").text(data.branchPicture);
				
				var branchName = data.branchName;
				var branchLocation = data.branchName.split(" ")[0];
				var branchLocationName = data.branchName.split(" ")[1];
				
				$("#branchLocationU").val(branchLocation);
				$("#branchLocationNameU").val(branchLocationName);
				$("#branchPictureU").val(data.branchPicture);
				// 구글 맵
				initialize(data.branchName, data.branchAddress);
				
				// 미리 수정 창에 데이터 넣어놓기!
				$("#branchNumberU").val(data.branchNumber);
				$("#branchNameU").val(data.branchName);
				$("#branchAddressU").val(data.branchAddress);
				$("#moviePictureU").val(data.branchPicture);
				
				var pictureTBody = $("#pictureListTableBody");
				pictureTBody.html("");
				// 지점 사진 목록 불러오기
				$.ajax({
					url: "http://choiys3574.cafe24.com/upload/gigabox/branch/" + data.branchNumber + "/pictureName",
					type: "GET",
					headers: {
						"Content-Type": "application/json"
					},
					error: function(request,status,error) {
						console.log("지점 사진이름 가져오기 오류");
						if (request.status == 500) {
							console.log("지점 사진 이름이 존재하지 않음.");
							pictureTBody.html("<tr><td colspan='2' style='text-align: center;'>목록이 없습니다.</td></tr>");
						} else {
							console.log("기타 오류");
							pictureTBody.html("<tr><td colspan='2' style='text-align: center;'>네트워크 장애입니다.</td></tr>");
						}
					},
					success: function(data) {
						console.log(data);
						var file = data.pictureName;
						var fileSrc = "http://choiys3574.cafe24.com" + data.rootPath + data.pictureName;
						pictureTBody.append("<tr>");
						pictureTBody.append("<td>"+file+"</td>");
						pictureTBody.append("<td><button class='btn btn-sm btn-warning' onclick='openImageModal(this)' data-src='"+fileSrc+"' data-name='"+file+"'>보기</button></td>");
						pictureTBody.append("</tr>");
						
						$("#branchPictureView").css("background-image", "url(" + fileSrc + ")");
					} 
				});
				
				// 지점 상세보기 모달
	            $('#branchDetailModal').modal({
			        show: true, 
			        backdrop: 'static',
			        keyboard: true
			    });
			}
		});
	}
	
	$(document).ready(function() {
		
		// 지점 추가 모달
		$("#branchInsertModalButton").click(function(e) {
			e.preventDefault();
			$('#branchInsertModal').modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
			
		});
			
			
		// 지점 추가 서밋
		$("#branchInsertModalSaveButton").click(function() {
			
			// branchName 처리
			var branchLocation = $("#branchLocationI").val();
			var branchLocationName = $("#branchLocationNameI").val();
			var branchNameInput = $("#branchNameI");
			branchNameInput.val(branchLocation + " " + branchLocationName);
			
			$("#branchPictureI").val("http://choiys3574.cafe24.com/upload/gigabox/branch/");
			
			$.ajax({
				url: "/admin/cinema/branchInsert",
				type: "POST",
				data: $("#branchInsertForm").serialize(),
				
				error: function() {
					alert("시스템 오류입니다.");
				},
				success: function(res) {
					alert("지점 추가에 성공하였습니다.");
					self.location.reload(true);
				}
			});
		});
			
		// 닫기 버튼
		$("#branchInsertModalCloseButton").click(function() {
			$("#branchInsertModal").modal("hide");
			$("#branchInsertForm")[0].reset();
			$("#branchInsertModal input[type=file]").each(function() {
				$(this).val("");
			});
			$("#uploadedPictureFile tr:has(td)").remove();
			
		}); 
			
		// 상세모달 닫기
		$("#branchDetailModalCloseButton").click(function() {
			$('#movieDetailModal').modal("hide");
			var pictureTBody = $("#posterListTableBody");
			pictureTBody.html("");
		});
			
		// 지점 정보 수정 모달 
		$("#branchUpdateButton").click(function() {
			$("#branchDetailModalCloseButton").trigger("click");
			$('#branchUpdateModal').modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
		});
			
		// 지점 정보 수정
		$("#branchUpdateModalSaveButton").click(function() {
			
			// branchName 처리
			var branchLocation = $("#branchLocationU").val();
			var branchLocationName = $("#branchLocationNameU").val();
			var branchNameUpdate = $("#branchNameU");
			
			branchNameUpdate.val(branchLocation + " " + branchLocationName);			
			$.ajax({
				url: "/admin/cinema/branchUpdate",
				type: "POST",
				data: $("#branchUpdateForm").serialize(),
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
		$("#branchUpdateModalCloseButton").click(function() {
			$('#branchUpdateModal').modal("hide");
		});
	});
			
	</script>


	<!-- 파일 업로드 -->
	<script src="/resources/jQuery-File-Upload-master/js/vendor/jquery.ui.widget.js"></script>
	<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
	<script src="//blueimp.github.io/JavaScript-Load-Image/js/load-image.all.min.js"></script>
	<!-- The Canvas to Blob plugin is included for image resizing functionality -->
	<script src="//blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
	<!-- Bootstrap JS is not required, but included for the responsive demo navigation -->
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
	<script src="/resources/jQuery-File-Upload-master/js/jquery.iframe-transport.js"></script>
	<!-- The basic File Upload plugin -->
	<script src="/resources/jQuery-File-Upload-master/js/jquery.fileupload.js"></script>
	<!-- The File Upload processing plugin -->
	<script src="/resources/jQuery-File-Upload-master/js/jquery.fileupload-process.js"></script>
	<!-- The File Upload image preview & resize plugin -->
	<script src="/resources/jQuery-File-Upload-master/js/jquery.fileupload-image.js"></script>
	<!-- The File Upload audio preview plugin -->
	<script src="/resources/jQuery-File-Upload-master/js/jquery.fileupload-audio.js"></script>
	<!-- The File Upload video preview plugin -->
	<script src="/resources/jQuery-File-Upload-master/js/jquery.fileupload-video.js"></script>
	<!-- The File Upload validation plugin -->
	<script src="/resources/jQuery-File-Upload-master/js/jquery.fileupload-validate.js"></script>
	
	<script type="text/javascript">
		
	function openImageModal(that) {
		// Get the modal
    	var modal = $("#imageModal");

        var modalImg = document.getElementById('imageModalItem');
        var captionText = document.getElementById("imageModalCaption");
        
        modalImg.src = $(that).attr("data-src");
        captionText.innerHTML = $(that).attr("data-name");
        modal.modal({
	        show: true
	    });
	}
	
	function deleteUploadedFile(that) {
		var dataSrc = $(that).attr("data-src");
		$.ajax({
			url: dataSrc,
			type: "GET",
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "GET"
			},
			error: function() {
				alert("시스템 오류입니다.");
			},
			success: function(data) {
				console.log(data);
				if (data.message == "SUCCESS") {
					alert("삭제에 성공하였습니다.");
					$(that).parent().parent().empty();
					$(that).parent().parent().remove();
				} else {
					alert(data.errorMessage);
				}
			}
		});
	}
	$(function() {
		
		// 지점사진 업로드
		$("#pictureUploadU").on("change", function() {
			var fileTypeStr = $("#pictureUploadU").val().split(".")[1];
			console.log($("#pictureUploadU").val());
			$('#pictureUploadU').fileupload({
		        dataType: 'json', 
		        replaceFileInput: false,
		        formData: {
		        	fileName: $("#branchNumberU").val(),
		        	fileDir: "upload/gigabox/branch/" + $("#branchNumberU").val(),
		        	purpose: "picture",
		        	fileType: fileTypeStr
		        },
		        done: function (e, data) {
		            $("#uploadedPictureFile tr:has(td)").remove();
		            alert("업로드 처리 되었습니다.");
		            var result = data.result;
		            var dataSrc = "http://choiys3574.cafe24.com/upload/gigabox/branch/" + $("#branchNumberU").val() + "/" + result.fileName + "." + result.fileType
	                var dataName = result.fileName + "." + result.fileType;
		            var deleteSrc = "http://choiys3574.cafe24.com/upload/gigabox/branch/" + $("#branchNumberU").val() + "/" + result.fileName + "." + result.fileType + "/delete";
		            $("#uploadedPictureFile").append(
	                        $('<tr/>')
	                        .append($('<td/>').text(result.fileName + "." + result.fileType))
	                        .append($('<td/>').text(result.fileType))
	                        .append($('<td/>').html("<button class='btn btn-sm btn-warning' onclick='openImageModal(this)' data-src='"+dataSrc+"' data-name='"+dataName+"'>보기</button>"))
	                        .append($('<td/>').html("<button class='btn btn-sm btn-danger' onclick='deleteUploadedFile(this)' data-src='"+dataSrc+"'>삭제</button>"))
	                        );
	                
		        }
		    });
		});
		
		
	});
		
	</script>
</body>
</html>
