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

<title>GigaBox 상영일정 관리 페이지</title>

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

<!-- DatePicker -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>

<!-- Datetimepicker -->
<link rel="stylesheet" href="/resources/datetimepicker/css/bootstrap-datetimepicker.min.css" />
<script type="text/javascript" src="/resources/datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="/resources/datetimepicker/js/locales/bootstrap-datetimepicker.ko.js"></script>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->


<style>
#scheduleListTable tr:hover td {
    background-color: #6495ED !important;
}

#scheduleListTable td {
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

</style>
<script>
    $(document).ready(function() {
    	
    	if ('${param.searchType}' != '') {
			$("#searchType").val('${param.searchType}');
		}
		if ('${param.searchKeyword}' != '') {
			$("#searchKeyword").val('${param.searchKeyword}');
		}
		if ('${param.scheduleStartStr}' != '') {
			$("#scheduleStart").val('${param.scheduleStartStr}');
		}
		if ('${param.scheduleEndStr}' != '') {
			$("#scheduleEnd").val('${param.scheduleEndStr}');
		}
		if ('${param.movieStatus}' != '') {
			$("#movieStatus").val('${param.movieStatus}');
		}
			
		$('#scheduleSearchButton').on("click",	function(event) {
			event.preventDefault();
			var queryString = "/admin/cinema/branch/${branchInfo.branchNumber}/schedule"
				+ '${pageMaker.makeQuery(1)}'
				+ "&searchType="
				+ $("#searchType").val()
				+ "&searchKeyword=" + $('#searchKeyword').val()
				+ "&scheduleStartStr=" + $('#scheduleStart').val()
				+ "&scheduleEndStr=" + $("#scheduleEnd").val()
				+ "&movieStatus=" + $("#movieStatus").val();
			
			self.location = queryString;
		});
    	
		// datepicker 설정
        var options = {
            format: 'yyyy-mm-dd',
            todayHighlight: true,
            orientation: 'top',
            autoclose: true,
            onSelect: function (dateText, inst) {
                console.log(dateText);
                console.log(inst);
            }
        };
        $('#scheduleStartSearch').datepicker(options);
        $('#scheduleEndSearch').datepicker(options);
        
        // movieList
        $.ajax({
        	url: "/admin/movie/movieList",
			type: "GET",
			error: function() {
				console.log("영화 리스트 가져옴  -- 오류");
			},
			success: function(res) {
				for(var i = 0; i < res.movieList.length; i++) {
					if (res.movieList[i].movieStatus != "상영중") {
						continue;
					}
					$("#movieSelectionI").append("<option value='"+res.movieList[i].movieNumber+"'>"+res.movieList[i].movieTitle+"</option>");
				}
			}
        });
        
        // movieroomList
        $.ajax({
        	url: "/admin/cinema/${branchInfo.branchNumber}/movieroomList",
			type: "GET",
			error: function() {
				console.log("상영관 리스트 가져옴 -- 오류");
			},
			success: function(res) {
				for(var i = 0; i < res.movieroomList.length; i++) {
					
					$("#movieroomSelectionI").append("<option value='"+res.movieroomList[i].movieroomNumber+"'>"+res.movieroomList[i].movieroomName+"</option>");
				}
			}
        });
    });
</script>
</head>
<body>

	<div id="admin_schedule_wrapper">

		<c:import url="/templates/header.jsp" />
		<c:import url="/templates/aside.jsp" />

		<div id="page-wrapper">
        <section id="admin_schedule_main_section">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">${branchInfo.branchName} 상영일정 관리</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <div class="row">

                <div class="col-lg-12">
                <article id="admin_schedule_control_article">

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-search fa-fw"></i> 상영 일정 검색
                        </div>
                        <!-- /.panel-heading -->
                        <form role="form" id="branchSearchForm">
                        <div class="panel-body">
                            <div class="list-group">
                                <div class="list-group-item">
                                    <span class="pull-left text-muted" style="width: 80px; text-align: center;">검색&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <div class="form-group input-group" style="width: 500px;">
                                        <select class="form-control" style="width: 120px; height: 35px;" 
                                        	name="searchType" id="searchType">
                                        <option value="t">영화 제목</option>
                                        <option value="m">상영관</option>
                                    </select>
                                    <input type="text" class="form-control" placeholder="검색 내용을 입력해 주세요." style="width: 380px; height: 35px;"
                                    	name="searchKeyword" id="searchKeyword">
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <span class="pull-left text-muted" style="width: 80px; text-align: left;">검색 기간&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <div class="form-group input-group" style="width: 500px;">
                                        <div class="input-group date" data-provide="datepicker" id="scheduleStartSearch">
                                            <input type="text" class="form-control" id="scheduleStart" name="scheduleStartStr">
                                            <div class="input-group-addon">
                                                <span class="glyphicon glyphicon-th"></span>
                                            </div>
                                        </div>
                                        <span class="input-group-addon">~</span>
                                        <div class="input-group date" data-provide="datepicker" id="scheduleEndSearch">
                                            <input type="text" class="form-control" id="scheduleEnd" name="scheduleEndStr">
                                            <div class="input-group-addon">
                                                <span class="glyphicon glyphicon-th"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                	<span class="pull-left text-muted" style="width: 80px; text-align: center;">영화상태&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <div class="form-group input-group" style="width: 500px;">
                                        <select class="form-control" name="movieStatus" id="movieStatus">
	                                        <option value="전체">전체</option>
	                                        <option value="상영전">상영전</option>
	                                        <option value="상영중">상영중</option>
	                                        <option value="상영종료">상영종료</option>
	                                    </select>
                               		</div>
                               	</div>
                            </div>
                            <!-- /.list-group -->
                        </div>
                        <!-- /.panel-body -->
                        <div class="panel-footer" style="height: 50px;">
                            <div class="input-group pull-right">
                                <button type="submit" class="btn btn-primary" id="scheduleSearchButton">검색</button>&nbsp;&nbsp;
                                <button type="reset" class="btn btn-danger" id="scheduleSearchInitButton">초기화</button>
                            </div>
                        </div>
                        </form>
                    </div>
                    <!-- /.panel -->
                </article>
                </div>
                <!-- /.col-lg-12 -->

                <div class="col-lg-12">
                <article id="admin_schedule_table_article">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="height: 50px;">
                            <i class="fa fa-th-list fa-fw"></i> 상영일정 목록
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-success btn-sm" id="scheduleInsertModalButton">상영일정 추가</button>
                                </div>
                            </div>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-bordered table-hover" id="scheduleListTable">
                                <thead>
                                    <tr>
                                        <th class="center">상영관</th>
                                        <th class="center">영화 제목</th>
                                        <th class="center">상영타입</th>
                                        <th class="center">상영여부</th>
                                        <th class="center">상영시간</th>
                                        <th class="center">시작</th>
                                        <th class="center">종료</th>
                                    </tr>
                                </thead>
                                <tbody id="scheduleListTableBody">
                                	<c:forEach var="scheduleItem" items="${scheduleList}">
                                    <tr data-id="${scheduleItem.scheduleNumber}">
                                    	<input type="hidden" data-role="movieroomNumber" 
                                    		value="${scheduleItem.movieroomNumber}">
                                    	<input type="hidden" data-role="movieroom2D" 
                                    		value="${scheduleItem.movieroom2D}">
                                    	<input type="hidden" data-role="movieroom3D" 
                                    		value="${scheduleItem.movieroom3D}">
                                    	<input type="hidden" data-role="movieroom4D" 
                                    		value="${scheduleItem.movieroom4D}">
                                   		<td>${scheduleItem.movieroomName}</td>
                                    	<td>${scheduleItem.movieTitle}</td>
                                        <td>${scheduleItem.scheduleType}</td>
                                        <td>${scheduleItem.movieStatus}</td>
                                        <td>${scheduleItem.movieScreentime} 분</td>
                                        <td><fmt:formatDate value="${scheduleItem.scheduleStart}" 
                                        	pattern="yyyy-MM-dd HH:mm"/></td>
                                        <td><fmt:formatDate value="${scheduleItem.scheduleEnd}" 
                                        	pattern="yyyy-MM-dd HH:mm"/></td>
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
								<li><a href="/admin/cinema/branch/${branchInfo.branchNumber}/schedule${pageMaker.makeQuery(pageMaker.startPage-1)}">&laquo;</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}" var="idx">
								<li 
									<c:out value="${pageMaker.criteria.page == idx?'class=\"active\"':''}"/>>
									<a href="/admin/cinema/branch/${branchInfo.branchNumber}/schedule${pageMaker.makeQuery(idx)}">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a href="/admin/cinema/branch/${branchInfo.branchNumber}/schedule${pageMaker.makeQuery(pageMaker.endPage+1)}">&raquo;</a></li>
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
    <div class="modal fade" id="scheduleInsertModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">상영 일정 추가</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="scheduleInsertForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieSelectionI">영화 선택</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="movieSelectionI" name="movieNumber">
                							<option>선택</option>
                							
                						</select>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieroomSelectionI">상영관 선택</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="movieroomSelectionI" name="movieroomNumber">
                							<option>선택</option>
                							
                						</select>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="scheduleTypeI">상영 타입 선택</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<select class="form-control" id="scheduleTypeI" name="scheduleType">
	               							<option value="필름">필름</option>
	               							<option value="필름(자막)">필름 자막</option>
	               							<option value="필름(더빙)">필름 더빙</option>
	               							<option value="2D">2D</option>
	               							<option value="2D(자막)">2D 자막</option>
	               							<option value="2D(더빙)">2D 더빙</option>
	               							<option value="3D">3D</option>
	               							<option value="3D(자막)">3D 자막</option>
	               							<option value="3D(더빙)">3D 더빙</option>
	               							<option value="3D">4D</option>
	               							<option value="4D(자막)">4D 자막</option>
	               							<option value="4D(더빙)">4D 더빙</option>
	               						</select>
               						</div>
                				</div>
                			</div>
						    <div class="form-group">
						    	<label class="col-sm-2 control-label" for="scheduleStartI">상영 시작 시간</label>
						        <div class="col-sm-10">
					                <div class="input-group date" id="scheduleStartPicker">
									    <input class="form-control" id="scheduleStartI"
									    	size="16" type="text" value="" readonly name="scheduleStartStr">
									    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
									</div>
						        </div>
						    </div>
						    <div class="form-group">
						    	<label class="col-sm-2 control-label" for="scheduleStartI">상영 종료 시간</label>
						        <div class="col-sm-10">
					                <div class="input-group date" id="scheduleEndPicker">
									    <input class="form-control" id="scheduleEndI"
									    	size="16" type="text" value="" readonly name="scheduleEndStr">
									    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
									</div>
						        </div>
						    </div>
						    <script type="text/javascript">
						        $(function () {
						            $('#scheduleStartPicker').datetimepicker({
						                format: "yyyy-mm-dd hh:ii",
						                autoclose: true,
						                todayBtn: true,
						                pickerPosition: "bottom-left",
						                locale: "ko",
						                language: "ko",
						                minuteStep: 10
						            });
						            $('#scheduleEndPicker').datetimepicker({
						                format: "yyyy-mm-dd hh:ii",
						                useCurrent: false,
						                autoclose: true,
						                todayBtn: true,
						                pickerPosition: "bottom-left",
						                locale: "ko",
						                language: "ko",
						                minuteStep: 10
						            });
						            $("#scheduleStartPicker").on("dp.change", function (e) {
						                $('#scheduleEndPicker').data("DateTimePicker").minDate(e.date);
						            });
						            $("#scheduleEndPicker").on("dp.change", function (e) {
						                $('#scheduleStartPicker').data("DateTimePicker").maxDate(e.date);
						            });
						        });
						    </script>
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="scheduleInsertModalSaveButton" type="button" class="btn btn-success" data-dismiss="modal">저장</button>
                     <button id="scheduleInsertModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
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

	
	$(document).ready(function() {
		
		// 상영 일정 추가 모달 띄우기
		$("#scheduleInsertModalButton").click(function(e) {
			e.preventDefault();
			$('#scheduleInsertModal').modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
			
		});
			
			
		// 상영 일정 추가 서밋
		$("#scheduleInsertModalSaveButton").click(function() {
			
			$.ajax({
				url: "/admin/cinema/scheduleInsert",
				type: "POST",
				data: $("#scheduleInsertForm").serialize(),
				
				error: function() {
					alert("시스템 오류입니다.");
				},
				success: function(res) {
					alert("상영 일정 추가에 성공하였습니다.");
					self.location.reload(true);
				}
			});
		});
			
		// 닫기 버튼
		$("#scheduleInsertModalCloseButton").click(function() {
			$("#scheduleInsertModal").modal("hide");
			$("#scheduleInsertForm")[0].reset();
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

</body>
</html>
