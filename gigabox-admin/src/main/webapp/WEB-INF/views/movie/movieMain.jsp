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

<title>GigaBox 영화 관리 페이지</title>

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

<!-- KOBIS API -->
<script type="text/javascript" src="/resources/kobis/KobisOpenAPIRestService.js"></script>

<!-- summernote -->
<link href="/resources/summernote/summernote.css" rel="stylesheet"/>
<script type="text/javascript" src="/resources/summernote/summernote.min.js"></script>
<script type="text/javascript" src="/resources/summernote/lang/summernote-ko-KR.js"></script>

<!-- jQuery-File-Upload-Plugin with Bootstrap -->
<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
<link rel="stylesheet" href="/resources/jQuery-File-Upload-master/css/jquery.fileupload.css">

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
</head>
<body>

	<div id="admin_main_wrapper">

		<c:import url="/templates/header.jsp" />
		<c:import url="/templates/aside.jsp" />

		<div id="page-wrapper">
        <section id="admin_movie_main_section">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">영화 관리 페이지</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <div class="row">

                <div class="col-lg-12">
                <article id="admin_movie_control_article">

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-info-circle fa-fw"></i> 영화 검색
                        </div>
                        <!-- /.panel-heading -->
                        <form role="form" id="movieSearchForm">
                        <div class="panel-body">
                            <div class="list-group">
                                <div class="list-group-item">
                                    <span class="pull-left text-muted" style="width: 80px; text-align: center;">영화검색&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <div class="form-group input-group" style="width: 500px;">
                                        <select class="form-control" style="width: 100px; height: 35px;" 
                                        	name="searchType" id="searchType">
	                                        <option value="all">전체</option>
	                                        <option value="title">영화제목</option>
	                                        <option value="director">감독</option>
	                                        <option value="cast">출연진</option>
                                    	</select>
	                                    <input type="text" class="form-control" placeholder="영화 제목을 입력해 주세요." style="width: 400px; height: 35px;"
	                                    	name="searchKeyword" id="searchKeyword">
	                                </div>
                               	</div>
                                <div class="list-group-item">
                                    <span class="pull-left text-muted" style="width: 80px; text-align: center;">영화상태&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <div class="form-group">
                                        <select class="form-control" style="width: 500px;" 
                                        	name="movieStatus" id="searchStatus">
	                                        <option value="전체">전체</option>
	                                        <option value="상영전">상영전</option>
	                                        <option value="상영중">상영중</option>
	                                        <option value="상영종료">상영종료</option>
                                    	</select>
	                                </div>
                               	</div>
                                <div class="list-group-item">
                                    <span class="pull-left text-muted" style="width: 80px; height: 100px; text-align: center;">장르&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <div class="form-group" style="display: inline-block;">
                                        <div class="checkbox">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="전체" id="all">전체
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="가족">가족
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="느와르">느와르
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="미스터리">미스터리
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="아동">아동
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="재난">재난
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="공포(호러)">공포(호러)
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="범죄">범죄
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="액션">액션
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="단편">단편
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="드라마">드라마
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="다큐멘터리">다큐멘터리
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="SF">SF
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="서부">서부
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="역사">역사
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="환타지">환타지
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="로맨스">로맨스
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="사극">사극
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="어드벤처">어드벤처
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="퀴어">퀴어
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="로드무비">로드무비
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="무협">무협
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="스릴러">스릴러
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="멜로">멜로
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="전기">전기
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="학원물">학원물
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="코미디">코미디
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="뮤지컬">뮤지컬
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="스포츠">스포츠
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="전쟁">전쟁
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="에로">에로
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="애니메이션">애니메이션
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="뮤직">뮤직
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="시대극">시대극
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="genre" value="종교">종교
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <span class="pull-left text-muted" style="width: 80px; text-align: center;">영화등급&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <div class="form-group">
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="rating" value="전체관람가">전체관람가
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="rating" value="12세 관람가">12세 관람가
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="rating" value="15세 관람가">15세 관람가
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="rating" value="청소년 관람불가">청소년 관람불가
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="rating" value="미정">미정
                                        </label>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <span class="pull-left text-muted" style="width: 80px; text-align: center;">개봉년도&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <div class="form-group input-group" style="width: 500px;">
                                        <input type="number" class="form-control" name="startYear" id="startYear">
                                        <span class="input-group-addon">~</span>
                                        <input type="number" class="form-control" name="endYear" id="endYear">
                                        <span class="input-group-addon">년</span>
                                    </div>
                                </div>
                            </div>
                            <!-- /.list-group -->
                        </div>
                        <!-- /.panel-body -->
                        <div class="panel-footer" style="height: 50px;">
                            <div class="input-group pull-right">
                                <button type="submit" class="btn btn-primary" id="movieSearchButton">검색</button>&nbsp;&nbsp;
                                <button type="reset" class="btn btn-danger" id="movieSearchInitButton">초기화</button>
                            </div>
                        </div>
                        <!-- /.panel-footer -->
                        </form>
                    </div>
                    <!-- /.panel -->
                </article>
                </div>
                <!-- /.col-lg-12 -->

	<script>
	$(document).ready(function() {
		
		var query = window.location.search.substring(1);
		var decode = decodeURIComponent(query);
		var genreArray = new Array();
		var ratingArray = new Array();
		var queryArray = decode.split("&");
		for (var i = 0; i < queryArray.length; i++) {
			if (queryArray[i].indexOf("genre=") != -1) {
				genreArray.push(queryArray[i].substring(6));
			}
		}
		for (var i = 0; i < genreArray.length; i++) {
			if ($("input[name=genre][value='"+genreArray[i]+"']:not(:checked)").prop("checked", false)) {
				$("input[name=genre][value='"+genreArray[i]+"']").prop("checked", true);
			}
		}
		for (var i = 0; i < queryArray.length; i++) {
			if (queryArray[i].indexOf("rating=") != -1) {
				ratingArray.push(queryArray[i].substring(7));
			}
		}
		for (var i = 0; i < ratingArray.length; i++) {
			if ($("input[name=rating][value='"+ratingArray[i]+"']:not(:checked)").prop("checked", false)) {
				$("input[name=rating][value='"+ratingArray[i]+"']").prop("checked", true);
			}
		}
		
		
		
		if ('${param.searchType}' != '') {
			$("#searchType").val('${param.searchType}');
		}
		if ('${param.searchKeyword}' != '') {
			$("#searchKeyword").val('${param.searchKeyword}');
		}
		if ('${param.startYear}' != '') {
			$("#startYear").val('${param.startYear}');
		}
		if ('${param.endYear}' != '') {
			$("#endYear").val('${param.endYear}');
		}
		if ('${param.movieStatus}' != '') {
			$("#searchStatus").val('${param.movieStatus}');
		}
	
		$('#all').on("click", function() {
			if ($(this).prop("checked") == true) {
                $("input[name=genre]").prop("checked", true);
            } else {
                $("input[name=genre]").prop("checked", false);
            }
		});
		$('input[name=genre]').on("change", function() {
			
			if ($("#all").prop("checked") == true) {
				if ($("input[name=genre]:not(:checked)").length != 0) {
					$("#all").prop("checked", false);
				}
			}
		});
			
		$('#movieSearchButton').on("click",	function(event) {
			event.preventDefault();
			var queryString = "/admin/movie/movieMain"
				+ '${pageMaker.makeQuery(1)}'
				+ "&searchType=" + $("#searchType").val()
				+ "&searchKeyword=" + $('#searchKeyword').val()
				+ "&startYear=" + $('#startYear').val()
				+ "&endYear=" + $("#endYear").val()
				+ "&movieStatus=" + $("#searchStatus").val();
			
			$("#movieSearchForm input[name=rating]:checked").each(function() {
				queryString += "&rating=" + $(this).val();
			});
			
			if ($("#all").attr("checked") == true) {
				
			} else {
				$("#movieSearchForm input[name=genre]:checked").each(function() {
					queryString += "&genre=" + $(this).val();
				});
			}
			self.location = queryString; 
		});

	});
</script>			

                <div class="col-lg-12">
                <article id="admin_movie_table_article">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="height: 50px;">
                            <i class="fa fa-video-camera fa-fw"></i> 영화 목록
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-success btn-sm" id="movieInsertModalButton">영화 추가</button>
                                </div>
                            </div>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-bordered table-hover" id="movieListTable">
                                <thead>
                                    <tr>
                                        <th class="center">영화코드</th>
                                        <th class="center">영화제목</th>
                                        <th class="center">영화타입</th>
                                        <th class="center">영화상태</th>
                                        <th class="center">개봉일</th>
                                        <th class="center">장르</th>
                                    </tr>
                                </thead>
                                <tbody id="movieListTableBody">
                                	<c:forEach var="movieItem" items="${movieList}">
                                    <tr data-id="${movieItem.movieNumber}">
                                        <td>${movieItem.movieCode}</td>
                                        <td>${movieItem.movieTitle}</td>
                                        <td>${movieItem.movieType}</td>
                                        <td>${movieItem.movieStatus}</td>
                                        <fmt:parseDate value="${movieItem.movieReleasedate}" var="dateFmt" 
                                        	pattern="yyyyMMdd"/>
                                        <td><fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/></td>
                                        <td><tag:genre genre="${movieItem.movieGenre}"/></td>
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
								<li><a href="/admin/movie/movieMain${pageMaker.makeQuery(pageMaker.startPage-1)}">&laquo;</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}" var="idx">
								<li 
									<c:out value="${pageMaker.criteria.page == idx?'class=\"active\"':''}"/>>
									<a href="/admin/movie/movieMain${pageMaker.makeQuery(idx)}">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a href="/admin/movie/movieMain${pageMaker.makeQuery(pageMaker.endPage+1)}">&raquo;</a></li>
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

	
	<!-- 영화 추가용 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="movieInsertSearchModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">영화 추가</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<div class="page-header">
                			<h5>영화 API 검색</h5>
                		</div>
                		<form class="form-horizontal" id="movieInsertSearchForm" onsubmit="return false;">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieNm">영화 제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-10">
                						<input class="form-control" id="movieNm" name="movieNm" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="directorNm">감독 이름</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-10">
                						<input class="form-control" id="directorNm" name="directorNm" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label">개봉 연도</label>
                				<div class="col-sm-9">
                					<div class="input-group">
                						<input type="number" class="form-control" name="openStartDt" id="openStartDt">
                                        <span class="input-group-addon">~</span>
                                        <input type="number" class="form-control" name="openEndDt" id="openEndDt">
                                        <span class="input-group-addon">년</span>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<div class="col-sm-12">
                					<div class="input-group pull-right">
                						<button class="btn btn-primary" id="movieInsertSearchButton" type="submit">
                							검색 <i class="fa fa-search spaceLeft"></i>
                						</button>
                						<button id="movieInsertSearchInitBtn" type="button" class="btn btn-warning">초기화</button>
                					</div>
                				</div>
                			</div>
                		</form>
                		
                		<div class="page-header">
                			<h5>검색 결과 <span id="movieInsertSearchListCount"></span></h5>
                		</div>
                		<div>
                			<table width="100%" id="movieInsertSearchListTable" class="table table-bordered table-hover">
                				
                			</table>
                			
                			<ul id="movieInsertSearchListPagination" class="pagination"></ul>
                			<input type="hidden" value="1" id="movieInsertSearchListPaginationCurPage">
                		</div>
                	</div>
                </div>
                <div class="modal-footer">
                     <button id="movieInsertSearchModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    
    
    <!-- 영화 추가 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="movieInsertModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">영화 추가</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="movieInsertForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieTitle">영화 제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieTitle" name="movieTitle" type="text">
                						<input type="hidden" id="movieCode" name="movieCode">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieEngname">영문 제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieEngname" name="movieEngname" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieScreentime">상영 시간(분)</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieScreentime" name="movieScreentime" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieType">상영 타입</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<input class="form-control" id="movieType" name="movieType" type="text">
               						</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="typeView">상영 타입 목록(API)</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<input class="form-control" id="typeView" name="typeView" type="text"
	                						readonly="readonly">
	                				</div>
	                			</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieRating">영화 등급</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="movieRating" name="movieRating">
                							<option value="전체관람가">전체관람가</option>
                							<option value="12세 관람가">12세 관람가</option>
                							<option value="15세 관람가">15세 관람가</option>
                							<option value="청소년 관람불가">청소년 관람불가</option>
                							<option value="미정">미정</option>
                						</select>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="ratingShow">영화 등급 (API)</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input type="text" class="form-control" readonly="readonly" 
                							id="ratingShow" name="ratingShow">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieGenre">영화 장르</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input type="text" class="form-control" id="movieGenre" name="movieGenre">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieReleasedate">개봉일</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieReleasedate" name="movieReleasedate" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieStatus">상영 상태</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<select class="form-control" id="movieStatus" name="movieStatus">
	               							<option value="상영전">상영전</option>
	               							<option value="상영중">상영중</option>
	               							<option value="상영종료">상영종료</option>
	               						</select>
               						</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieDirector">영화 감독</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieDirector" name="movieDirector" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieCast">출연진</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieCast" name="movieCast" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieStoryline">줄거리</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<textarea class="form-control summernote" id="movieStoryline" name="movieStoryline"></textarea>
                					</div>
                				</div>
                			</div>
                			
                			<input type="hidden" id="moviePoster" name="moviePoster">
                			<input type="hidden" id="movieSteelcut" name="movieSteelcut">
                			<input type="hidden" id="movieTrailer" name="movieTrailer">
                			
                		</form>
                		<div class="form-group">
                			<label class="col-sm-2 control-label" for="posterUpload">포스터 업로드</label>
                			<div class="col-sm-12">
							    <input id="posterUpload" type="file" name="posterUpload" data-url="http://choiys3574.cafe24.com/upload/gigabox/movie/poster">
							    <table class="table table-hover table-bordered">
							        <thead>
								        <tr>
								            <th>파일 이름</th>
								            <th>타입</th>
								            <th>썸네일</th>
								            <th>보기</th>
								            <th>삭제</th>
								        </tr>
							        </thead>
							        <tbody id="uploadedPosterFile">
							        </tbody>
							    </table>
							</div>
						</div>
                		<div class="form-group">
                			<label class="col-sm-2 control-label" for="steelcutUpload">스틸컷 업로드</label>
                			<div class="col-sm-12">
							    <input id="steelcutUpload" type="file" name="steelcutUpload" data-url="http://choiys3574.cafe24.com/upload/gigabox/movie/steelcut">
							    <table class="table table-hover table-bordered">
							        <thead>
								        <tr>
								            <th>파일 이름</th>
								            <th>타입</th>
								            <th>썸네일</th>
								            <th>보기</th>
								            <th>삭제</th>
								        </tr>
							        </thead>
							        <tbody id="uploadedSteelcutFile">
							        </tbody>
							    </table>
							</div>
						</div>
                		<div class="form-group">
                			<label class="col-sm-2 control-label" for="trailerUpload">트레일러 업로드</label>
                			<div class="col-sm-12">
							    <input id="trailerUpload" type="file" name="trailerUpload" data-url="http://choiys3574.cafe24.com/upload/gigabox/movie/trailer">
							    <div id="progress">
							        <div style="width: 0%; height: 20px;"></div>
							    </div>
							    <table class="table table-hover table-bordered">
							        <thead>
								        <tr>
								            <th>파일 이름</th>
								            <th>타입</th>
								            <th>보기</th>
								            <th>삭제</th>
								        </tr>
							        </thead>
							        <tbody id="uploadedTrailerFile">
							        </tbody>
							    </table>
							</div>
						</div>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="movieInsertModalSaveButton" type="button" class="btn btn-success" data-dismiss="modal">저장</button>
                     <button id="movieInsertModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
	
	
	<!-- 영화 수정 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="movieUpdateModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">영화 수정</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="movieUpdateForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieTitleU">영화 제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieTitleU" name="movieTitle" type="text">
                						<input type="hidden" id="movieCodeU" name="movieCode">
                						<input type="hidden" id="movieNumberU" name="movieNumber">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieEngname">영문 제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieEngnameU" name="movieEngname" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieScreentime">상영 시간(분)</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieScreentimeU" name="movieScreentime" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieTypeU">상영 타입</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<input class="form-control" id="movieTypeU" name="movieType" type="text">
               						</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieRatingU">영화 등급</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="movieRatingU" name="movieRating">
                							<option value="전체관람가">전체관람가</option>
                							<option value="12세 관람가">12세 관람가</option>
                							<option value="15세 관람가">15세 관람가</option>
                							<option value="청소년 관람불가">청소년 관람불가</option>
                							<option value="미정">미정</option>
                						</select>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieGenreU">영화 장르</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input type="text" class="form-control" id="movieGenreU" name="movieGenre">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieReleasedateU">개봉일</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieReleasedateU" name="movieReleasedate" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieStatusU">상영 상태</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<select class="form-control" id="movieStatusU" name="movieStatus">
	               							<option value="상영전">상영전</option>
	               							<option value="상영중">상영중</option>
	               							<option value="상영종료">상영종료</option>
	               						</select>
               						</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieDirectorU">영화 감독</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieDirectorU" name="movieDirector" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieCastU">출연진</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="movieCastU" name="movieCast" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="movieStorylineU">줄거리</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<textarea class="form-control summernote" id="movieStorylineU" name="movieStoryline"></textarea>
                					</div>
                				</div>
                			</div>
                		</form>
                		<div class="form-group">
                			<label class="col-sm-2 control-label" for="posterUploadU">포스터 업로드</label>
                			<div class="col-sm-12">
							    <input id="posterUploadU" type="file" name="posterUpload" data-url="http://choiys3574.cafe24.com/upload/gigabox/movie/poster">
							    <table class="table table-hover table-bordered">
							        <thead>
								        <tr>
								            <th>파일 이름</th>
								            <th>타입</th>
								            <th>보기</th>
								            <th>삭제</th>
								        </tr>
							        </thead>
							        <tbody id="uploadedPosterFileU">
							        </tbody>
							    </table>
							</div>
						</div>
                		<div class="form-group">
                			<label class="col-sm-2 control-label" for="steelcutUploadU">스틸컷 업로드</label>
                			<div class="col-sm-12">
							    <input id="steelcutUploadU" type="file" name="steelcutUpload" data-url="http://choiys3574.cafe24.com/upload/gigabox/movie/steelcut">
							    <table class="table table-hover table-bordered">
							        <thead>
								        <tr>
								            <th>파일 이름</th>
								            <th>타입</th>
								            <th>보기</th>
								            <th>삭제</th>
								        </tr>
							        </thead>
							        <tbody id="uploadedSteelcutFileU">
							        </tbody>
							    </table>
							</div>
						</div>
                		<div class="form-group">
                			<label class="col-sm-2 control-label" for="trailerUpload">트레일러 업로드</label>
                			<div class="col-sm-12">
							    <input id="trailerUploadU" type="file" name="trailerUpload" data-url="http://choiys3574.cafe24.com/upload/gigabox/movie/trailer">
							    <div id="progress">
							        <div style="width: 0%; height: 20px;"></div>
							    </div>
							    <table class="table table-hover table-bordered">
							        <thead>
								        <tr>
								            <th>파일 이름</th>
								            <th>타입</th>
								            <th>보기</th>
								            <th>삭제</th>
								        </tr>
							        </thead>
							        <tbody id="uploadedTrailerFileU">
							        </tbody>
							    </table>
							</div>
						</div>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="movieUpdateModalSaveButton" type="button" class="btn btn-success" data-dismiss="modal">저장</button>
                     <button id="movieUpdateModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
	

	<!-- 상세보기용 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="movieDetailModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="modalLabel"><span id="detailMovieTitle" style="font-weight: bold; font-size: 1.2em"></span></h4>
                </div>
                <div class="modal-body">
                	<div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="col-md-12">
	                            <div class="list-group">
	                                <div class="hide" data-id="movieNumber"></div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">제목</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="movieTitle"></div>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">타입</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="movieType"></div>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">영화 관람가</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="movieRating"></div>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">개봉일</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="movieReleasedate"></div>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">감독</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="movieDirector"></div>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">출연진</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="movieCast"></div>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">상영 시간</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="movieScreentime"></div>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">상영 상태</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="movieStatus"></div>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">장르</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="movieGenre"></div>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">줄거리</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: clip;" data-id="movieStoryline"></div>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">영문 제목</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="movieEngname"></div>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">포스터 주소</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="moviePoster"></div>
	                                	<table id="posterListTable" class="table table-bordered table-hover">
	                                		<thead>
	                                			<tr>
										            <th>파일 이름</th>
										            <th>보기</th>
										        </tr>
	                                		</thead>
	                                		<tbody id="posterListTableBody">
	                                			
	                                		</tbody>
	                                	</table>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">스틸컷 주소</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="movieSteelcut"></div>
	                                	<table id="steelcutListTable" class="table table-bordered table-hover">
	                                		<thead>
	                                			<tr>
										            <th>파일 이름</th>
										            <th>보기</th>
										        </tr>
	                                		</thead>
	                                		<tbody id="steelcutListTableBody">
	                                			
	                                		</tbody>
	                                	</table>
	                                </div>
	                                <div class="list-group-item row">
	                                	<div class="text-muted col-sm-3" style="width: 15%; ">트레일러 주소</div>
	                                	<div class="well col-sm-9" style="width: 80%; text-overflow: ellipsis;" data-id="movieTrailer"></div>
	                                	<table id="trailerListTable" class="table table-bordered table-hover">
	                                		<thead>
	                                			<tr>
										            <th>파일 이름</th>
										            <th>보기</th>
										        </tr>
	                                		</thead>
	                                		<tbody id="trailerListTableBody">
	                                			
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
                	 <button id="movieUpdateButton" type="button" class="btn btn-sm btn-success">영화 정보 변경</button>
                	 <button id="movieDeleteButton" type="button" class="btn btn-sm btn-warning">영화 정보 삭제</button>
                     <button id="movieDetailModalCloseButton" type="button" class="btn btn-sm btn-danger" data-dismiss="modal">닫기</button>
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
		  <img class="modal-content" id="imageModalItem">
		  <!-- Modal Caption (Image Text) -->
		  <div id="imageModalCaption"></div>
	</div>
	
	<!-- The Video View Modal -->
	<div id="videoModal" class="modal">
		<video width="50%" controls="controls" id="videoModalItem" style="margin-left: 25%;">
			  <source id="videoModalItemSource" src="" type="video/mp4">
			  Your browser does not support HTML5 video.
		</video>
	</div>


	<!-- Page-Level Demo Scripts - Tables - Use for reference -->
	<script>
	
	var movieInsertSearchCnt = 1;
	
	// 영화 API 검색 함수
	function selectPagination(a) {
		movieInsertSearchCnt = 2;
		$("#movieInsertSearchListPaginationCurPage").val(a);
		$("#movieInsertSearchButton").trigger("click");
		var selectActiveNum = (a % 10);
		$("#movieInsertSearchListPagination li").removeClass("active");
		$("#movieInsertSearchListPagination li:eq("+selectActiveNum+")").addClass("active");
		movieInsertSearchCnt = 1;
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
	
	// 관람가 마크
	function makeRatingTag(value) {
		if (value == "전체관람가" || value == "전체 관람가") {
			return "<span class='label label-success' style='border-radius: 50%;'>All</span>";
		} else if (value == "12세 관람가") {
			return "<span class='label label-primary' style='border-radius: 50%; background-color: blue;'>12</span>";
		} else if (value == "15세 관람가") {
			return "<span class='label label-warning' style='border-radius: 50%;'>15</span>";
		} else if (value == "청소년 관람불가") {
			return "<span class='label label-danger' style='border-radius: 50%;'>19</span>";
		} else if (value == "미정") {
			return "<span class='label label-default' style='border-radius: 50%;'>미정</span>";
		}
	}
	
		$(document).ready(function() {
			
			// 영화 추가 모달
			$("#movieInsertModalButton").click(function(e) {
				e.preventDefault();
				$('#movieInsertSearchModal').modal({
			        show: true, 
			        backdrop: 'static',
			        keyboard: true
			    });
				$("#movieInsertModal input[type=file]").each(function() {
					$(this).val("");
				});
				$("#uploadedSteelcutFile tr:has(td)").remove();
				$("#uploadedTrailerFile tr:has(td)").remove();
			});
			
			// 영화 API 검색 초기화
			$("#movieInsertSearchInitBtn").click(function(e) {
				e.preventDefault();
				$("#movieNm").val("");
				$("#directorNm").val("");
				$("#openStartDt").val("");
				$("#openEndDt").val("");
				$('#movieInsertSearchListTable').html("");
				$("#movieInsertSearchListPagination").html("");
				
			});
			
			// 영화 API 검색 모달 닫기 버튼
			$("#movieInsertSearchModalCloseButton").click(function(e) {
				e.preventDefault();
				$("#movieInsertSearchInitBtn").trigger("click");
				$('#movieInsertSearchModal').hide();
			});
			
			// 영화 API 검색
			$("#movieInsertSearchButton").click(function(e) {
				e.preventDefault();
				
				if (movieInsertSearchCnt == 1) {
					$("#movieInsertSearchListPaginationCurPage").val(1);
				} 
				
				var curPageNum = $("#movieInsertSearchListPaginationCurPage").val();
				var kobisService = new KobisOpenAPIRestService("44d0d4d6d46d53b3df1cc252113b2fe8");
				var resJson = null;
				try{
					resJson = kobisService.getMovieList(true,{curPage:curPageNum,itemPerPage:"10",
						movieNm:$("#movieNm").val(),directorNm:$("#directorNm").val(),
						openStartDt:$("#openStartDt").val(),openEndDt:$("#openEndDt").val()});
					
				}catch(er){
					resJson = $.parseJSON(er.message);
				}
				
				if (!resJson) {
					var appendStr = "<thead> <tr> <th>영화 코드</th> <th>영화 제목</th> <th> 영문 제목</th> <th>개봉일</th> <th>제작 국가</th> <th>감독</th> </tr> </thead>";
					appendStr += "<tbody><tr><td colspan='6' style='text-align: center;'>네트워크 장애로 결과를 가져오지 못했습니다.</td></tbody>";
					$('#movieInsertSearchListTable').html(appendStr);
					return;
				}
				
				if(resJson.failInfo){
					alert(resJson.failInfo.message);
				} else {
					
					$('#movieInsertSearchListTable').html("");
					$("#movieInsertSearchListPagination").html("");
					
					var movieList = resJson.movieListResult.movieList;
					var totCnt = resJson.movieListResult.totCnt;
					
					var appendStr = "<thead> <tr> <th>영화 코드</th> <th>영화 제목</th> <th> 영문 제목</th> <th>개봉일</th> <th>제작 국가</th> <th>감독</th> </tr> </thead>";
					
					// 검색 결과가 없는 경우
					if (totCnt == 0) {
						appendStr += "<tbody><tr><td colspan='6' style='text-align: center;'>검색 결과가 없습니다.</td></tbody>";
						$('#movieInsertSearchListTable').append(appendStr);
						$("#movieInsertSearchListCount").html("(" +totCnt + "건)");
						return;
					}
					
					for(var i=0;i<movieList.length;i++){
						var movie = movieList[i];
						
						appendStr += "<tbody id='movieInsertSearchListTableBody'> <tr data-id='"+movie.movieCd+"'><td>"+movie.movieCd+"</td><td>"+movie.movieNm+"</td>";
						
						
						appendStr += "<td>"
						if(movie.movieNmEn != null && movie.movieNmEn != ""){
							appendStr += movie.movieNmEn;
						}
						appendStr += "</td>"
						
						appendStr += "<td>"
						if(movie.openDt != null && movie.openDt != ""){
							appendStr += movie.openDt;
						}
						appendStr += "</td>"
						
						appendStr += "<td>"
						if(movie.repNationNm != null && movie.repNationNm != ""){
							appendStr += movie.repNationNm;
						}
						appendStr += "</td>"
						
						appendStr += "<td>"
						if(movie.directors != null && movie.directors != ""){
							for(var dir in movie.directors){
								appendStr += movie.directors[dir].peopleNm;
							}				
						}
						appendStr += "</td>"
						appendStr += "</tr></tbody>";
					}
					
					$('#movieInsertSearchListTable').append(appendStr);
					
					// 페이징 처리
					var totPage = Math.ceil(totCnt / 10);
					var curPageEnd = Math.ceil(curPageNum / 10.0 - 0.05) * 10;
					var curPageStart = curPageEnd - 9;
					if (curPageEnd > totPage) {
						var curPageEndFact = totPage;
					} else {
						var curPageEndFact = curPageEnd;
					}
					
					
					$("#movieInsertSearchListPagination").append('<li id="mislpPrev"><a href="javascript:selectPagination('+(curPageStart-10)+')"><span class="glyphicon glyphicon-chevron-left"></span></a></li>');
					for (var i = curPageStart; i <= curPageEndFact; i++) {
						$("#movieInsertSearchListPagination").append('<li><a href="javascript:selectPagination('+i+')">'+i+'</a></li>');
					}
					$("#movieInsertSearchListPagination").append('<li id="mislpNext"><a href="javascript:selectPagination('+(curPageStart+10)+')"><span class="glyphicon glyphicon-chevron-right"></span></a></li>');
					
					if (curPageStart == 1) {
						$("#mislpPrev").addClass("disabled");
					} 
					if (curPageEnd >= totPage) {
						$("#mislpNext").addClass("disabled");
					} 
					
					$("#movieInsertSearchListCount").html("(" +totCnt + "건)");
					
					if (movieInsertSearchCnt == 1) {
						$("#movieInsertSearchListPagination li").removeClass("active");
						$("#movieInsertSearchListPagination li:eq(1)").addClass("active");
					}
				}
				
			});
			
			// 영화 추가 > 영화 검색 API > 테이블 행 선택시 
			$("#movieInsertSearchListTable").on("click", "#movieInsertSearchListTableBody tr", function(e) {
				e.preventDefault();
				
				$('#movieStoryline').summernote('reset');
				// 영화 추가 - 서머노트 에디터 적용
				$('#movieStoryline').summernote({
			        height: 300,          // 기본 높이값
			        minHeight: null,      // 최소 높이값(null은 제한 없음)
			        maxHeight: null,      // 최대 높이값(null은 제한 없음)
			        lang: 'ko-KR',        // 한국어 지정(기본값은 en-US)
			        toolbar: [
			            ['font', ['bold', 'italic', 'underline']],
			            ['fontname', ['fontname']],
			            ['fontsize', ['fontsize']],
			            ['color', ['color']],
			            ['para', ['ul', 'ol', 'paragraph']],
			            ['height', ['height']],
			            ['table', ['table']],
			            ['insert', ['hr']],
			            ['view', ['fullscreen', 'codeview']]
			          ]
			    });
				
				// 데이터 불러오기
				var movieCdVal = $(this).attr("data-id");
				$.ajax({
					url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=44d0d4d6d46d53b3df1cc252113b2fe8&movieCd="+movieCdVal,
					type: "GET",
					error: function() {
						alert("시스템 오류입니다.");
					},
					success: function(data) {
						var info = data.movieInfoResult.movieInfo;
						$("#movieCode").val(info.movieCd);
						$("#movieTitle").val(info.movieNm);
						$("#movieEngname").val(info.movieNmEn);
						$("#movieScreentime").val(info.showTm);
						$("#movieReleasedate").val(info.openDt);
						
						// genre
						var genres = info.genres;
						var genre = "";
						for (var i = 0; i < genres.length; i++) {
							if (i == genres.length - 1) {
								genre += genres[i].genreNm;
								break;
							}
							genre += genres[i].genreNm + ", ";
						}
						$("#movieGenre").val(genre);
						
						// director
						var directors = info.directors;
						var director = "";
						for (var i = 0; i < directors.length; i++) {
							if (i == directors.length - 1) {
								director += directors[i].peopleNm;
								break;
							}
							director += directors[i].peopleNm + ", ";
						}
						$("#movieDirector").val(director);
						
						// cast
						var actors = info.actors;
						var actor = "";
						var actorsLength = actors.length > 10 ? 10 : actors.length;
						for (var i = 0; i < actorsLength; i++) {
							if (i == actorsLength - 1) {
								actor += actors[i].peopleNm;
								break;
							}
							actor += actors[i].peopleNm + ", ";
						}
						$("#movieCast").val(actor);
						
						// rating
						if (info.audits.length != 0) {
							var rating = info.audits[0].watchGradeNm;
							$("#ratingShow").val(rating);
						} else {
							$("#ratingShow").val("미정");
						}
						
					
						// showType
						var showTypes = info.showTypes;
						var showType = "";
						for (var i = 0; i < showTypes.length; i++) {
							if (i == showTypes.length - 1) {
								showType += showTypes[i].showTypeNm;
								break;
							}
							showType += showTypes[i].showTypeNm + ", ";
						}
						$("#typeView").val(showType);
						
						// 포스터 주소
						$("#moviePoster").val("http://choiys3574.cafe24.com/upload/gigabox/movie/poster/" + $("#movieCode").val());
						$("#movieSteelcut").val("http://choiys3574.cafe24.com/upload/gigabox/steelcut/" + $("#movieCode").val());
						$("#movieTrailer").val("http://choiys3574.cafe24.com/upload/gigabox/trailer/" + $("#movieCode").val());
						
						// 파일 업로드폼 초기화
						$("#movieInsertModal input[type=file]").each(function() {
							$(this).val("");
						});
						$("#uploadedPosterFile tr:has(td)").remove();
						$("#uploadedSteelcutFile tr:has(td)").remove();
						$("#uploadedTrailerFile tr:has(td)").remove();
						
						// 영화 추가 모달
			            $('#movieInsertModal').modal({
					        show: true, 
					        backdrop: 'static',
					        keyboard: true
					    });
						$('#movieInsertSearchModal').modal("hide");
					}
				});
			});
			
			// 영화 추가 서밋
			$("#movieInsertModalSaveButton").click(function() {
				$.ajax({
					url: "/admin/movie/movieInsert",
					type: "POST",
					data: $("#movieInsertForm").serialize(),
					
					error: function() {
						alert("시스템 오류입니다.");
					},
					success: function(res) {
						alert(res.result);
						self.location.reload(true);
					}
				});
			});
			
			// 닫기 버튼
			$("#movieInsertModalCloseButton").click(function() {
				$("#movieStoryline").text("");
				$("#movieInsertModal").modal("hide");
				$("#movieInsertModal").find('form')[0].reset();
				$("#movieInsertModal input[type=file]").each(function() {
					$(this).val("");
				});
				$("#uploadedPosterFile tr:has(td)").remove();
				$("#uploadedSteelcutFile tr:has(td)").remove();
				$("#uploadedTrailerFile tr:has(td)").remove();
				
				var movieCode = $("#movieCode").val();
				$.ajax({
					url: "http://choiys3574.cafe24.com/upload/gigabox/movie/poster/" + movieCode + "deleteAll",
					type: "GET",
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "GET"
					},
					error: function() {
						console.log("영화 입력 > 닫기시 업로드 파일들 삭제 오류.");
					},
					success: function(data) {
						console.log(data);
					}
				});
				$.ajax({
					url: "http://choiys3574.cafe24.com/upload/gigabox/movie/steelcut/" + movieCode + "deleteAll",
					type: "GET",
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "GET"
					},
					error: function() {
						console.log("영화 입력 > 닫기시 업로드 파일들 삭제 오류.");
					},
					success: function(data) {
						console.log(data);
					}
				});
				$.ajax({
					url: "http://choiys3574.cafe24.com/upload/gigabox/movie/trailer/" + movieCode + "deleteAll",
					type: "GET",
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "GET"
					},
					error: function() {
						console.log("영화 입력 > 닫기시 업로드 파일들 삭제 오류.");
					},
					success: function(data) {
						console.log(data);
					}
				});
			}); 
			
			
			
			// 영화 목록 > 클릭 > 영화 상세보기
			$('#movieListTableBody').on('click', 'tr', function (e) {
				e.preventDefault();
				
				// 데이터 불러오기 파트
				var dataId = $(this).attr("data-id");
				$.ajax({
					url: "/admin/movie/movieDetail/" + dataId,
					type: "PUT",
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "PUT"
					},
					error: function() {
						alert("시스템 오류입니다.");
					},
					success: function(data) {
						var movieCode = data.movieCode;
						var year = (data.movieReleasedate).substr(0, 4);
						var month = (data.movieReleasedate).substr(4, 2);
						var day = (data.movieReleasedate).substr(6, 2);
						var genreTotal = data.movieGenre;
						var genrePrefix = "<span class='label label-success label-md' style='font-size: 1.2em;'>";
						var genreSuffix = "</span> ";
						var genreTrim = genreTotal.replace(/\s/g, "");
						var genreArray = genreTrim.split(",");
						var genreFinal = "";
						for(var g = 0 ; g < genreArray.length ; g++){
							genreFinal += genrePrefix + genreArray[g] + genreSuffix;
						}
						
						$("#detailMovieTitle").html("<p class='d-inline text-center'>" + makeRatingTag(data.movieRating) + " &nbsp;&nbsp; " + data.movieTitle + "</p>");
						$("div[data-id=movieNumber]").text(data.movieNumber);
						$("div[data-id=movieTitle]").text(data.movieTitle);
						$("div[data-id=movieType]").text(data.movieType);
						$("div[data-id=movieRating]").text(data.movieRating);
						$("div[data-id=movieReleasedate]").html(year + "-" + month + "-" + day);
						$("div[data-id=movieDirector]").text(data.movieDirector);
						$("div[data-id=movieCast]").text(data.movieCast);
						$("div[data-id=movieScreentime]").text(data.movieScreentime + "분");
						$("div[data-id=movieStatus]").text(data.movieStatus);
						$("div[data-id=movieGenre]").html(genreFinal);
						$("div[data-id=movieStoryline]").html(data.movieStoryline);
						$("div[data-id=movieEngname]").text(data.movieEngname);
						$("div[data-id=moviePoster]").text(data.moviePoster);
						$("div[data-id=movieSteelcut]").text(data.movieSteelcut);
						$("div[data-id=movieTrailer]").text(data.movieTrailer);
						
						// 서머노트 초기화
						$('#movieStorylineU').summernote('reset');
						
						// 미리 수정 창에 데이터 넣어놓기!
						$("#movieNumberU").val(data.movieNumber);
						$("#movieCodeU").val(data.movieCode);
						$("#movieTitleU").val(data.movieTitle);
						$("#movieTypeU").val(data.movieType);
						$("#movieRatingU").val(data.movieRating);
						$("#movieReleasedateU").val(data.movieReleasedate);
						$("#movieDirectorU").val(data.movieDirector);
						$("#movieCastU").val(data.movieCast);
						$("#movieScreentimeU").val(data.movieScreentime);
						$("#movieGenreU").val(data.movieGenre);
						
						$("#movieEngnameU").val(data.movieEngname);
						$("#movieStatusU").val(data.movieStatus);
						
						
						$('#movieStorylineU').summernote({
					        height: 300,          // 기본 높이값
					        minHeight: null,      // 최소 높이값(null은 제한 없음)
					        maxHeight: null,      // 최대 높이값(null은 제한 없음)
					        lang: 'ko-KR',        // 한국어 지정(기본값은 en-US)
					        toolbar: [
					            ['font', ['bold', 'italic', 'underline']],
					            ['fontname', ['fontname']],
					            ['fontsize', ['fontsize']],
					            ['color', ['color']],
					            ['para', ['ul', 'ol', 'paragraph']],
					            ['height', ['height']],
					            ['table', ['table']],
					            ['insert', ['hr']],
					            ['view', ['fullscreen', 'codeview']]
					          ]
					    });
						$("#movieStorylineU").summernote("code", data.movieStoryline);
						
						var posterTBody = $("#posterListTableBody");
						var steelcutTBody = $("#steelcutListTableBody");
						var trailerTBody = $("#trailerListTableBody");
						
						// 포스터 목록 불러오기
						$.ajax({
							url: "http://choiys3574.cafe24.com/upload/gigabox/movie/poster/" + movieCode + "/fileList",
							type: "GET",
							headers: {
								"Content-Type": "application/json"
							},
							error: function(request,status,error) {
								console.log("포스터 목록 가져오기 오류");
								if (request.status == 500) {
									console.log("포스터 목록이 존재하지 않음.");
									posterTBody.html("<tr><td colspan='2' style='text-align: center;'>목록이 없습니다.</td></tr>");
								} else {
									console.log("기타 오류");
									posterTBody.html("<tr><td colspan='2' style='text-align: center;'>네트워크 장애입니다.</td></tr>");
								}
							},
							success: function(data) {
								console.log(data);
								var fileList = data.fileList;
								
								for (var i = 0; i < fileList.length; i++) {
									var dataName = fileList[i];
									var dataSrc = "http://choiys3574.cafe24.com" + data.rootPath + dataName;
									posterTBody.append("<tr>");
									posterTBody.append("<td>"+fileList[i]+"</td>");
									posterTBody.append("<td><button class='btn btn-sm btn-warning' onclick='openImageModal(this)' data-src='"+dataSrc+"' data-name='"+dataName+"'>보기</button></td>");
									posterTBody.append("</tr>");
								}
								
							} 
						});
						// 스틸컷 목록 불러오기
						$.ajax({
							url: "http://choiys3574.cafe24.com/upload/gigabox/movie/steelcut/" + movieCode + "/fileList",
							type: "GET",
							headers: {
								"Content-Type": "application/json"
							},
							error: function(request,status,error) {
								console.log("스틸컷 목록 가져오기 오류");
								if (request.status == 500) {
									console.log("스틸컷 목록이 존재하지 않음.");
									steelcutTBody.html("<tr><td colspan='2' style='text-align: center;'>목록이 없습니다.</td></tr>");
								} else {
									console.log("기타 오류");
									steelcutTBody.html("<tr><td colspan='2' style='text-align: center;'>네트워크 장애입니다.</td></tr>");
								}
							},
							success: function(data) {
								console.log(data);
								var fileList = data.fileList;
								
								for (var i = 0; i < fileList.length; i++) {
									var dataName = fileList[i];
									var dataSrc = "http://choiys3574.cafe24.com" + data.rootPath + dataName;
									steelcutTBody.append("<tr>");
									steelcutTBody.append("<td>"+fileList[i]+"</td>");
									steelcutTBody.append("<td><button class='btn btn-sm btn-warning' onclick='openImageModal(this)' data-src='"+dataSrc+"' data-name='"+dataName+"'>보기</button></td>");
									steelcutTBody.append("<tr>");
								}
								posterTBody.append("</tr>");
							} 
						});
						// 트레일러 목록 불러오기
						$.ajax({
							url: "http://choiys3574.cafe24.com/upload/gigabox/movie/trailer/" + movieCode + "/fileList",
							type: "GET",
							headers: {
								"Content-Type": "application/json"
							},
							error: function(request,status,error) {
								console.log("트레일러 목록 가져오기 오류");
								if (request.status == 500) {
									console.log("트레일러 목록이 존재하지 않음.");
									trailerTBody.html("<tr><td colspan='2' style='text-align: center;'>목록이 없습니다.</td></tr>");
								} else {
									console.log("기타 오류");
									trailerTBody.html("<tr><td colspan='2' style='text-align: center;'>네트워크 장애입니다.</td></tr>");
								}
							},
							success: function(data) {
								console.log(data);
								var fileList = data.fileList;
								
								for (var i = 0; i < fileList.length; i++) {
									var dataName = fileList[i];
									var dataSrc = "http://choiys3574.cafe24.com" + data.rootPath + dataName;
									trailerTBody.append("<tr>");
									trailerTBody.append("<td>"+fileList[i]+"</td>");
									trailerTBody.append("<td><button class='btn btn-sm btn-warning' onclick='openVideoModal(this)' data-src='"+dataSrc+"'>보기</button></td>");
									trailerTBody.append("</tr>");
								}
								
							} 
						});
					}
				});
				
				// 영화 상세보기 모달
	            $('#movieDetailModal').modal({
			        show: true, 
			        backdrop: 'static',
			        keyboard: true
			    });
		    });
			
			// 상세모달 닫기
			$("#movieDetailModalCloseButton").click(function() {
				$('#movieDetailModal').modal("hide");
				var posterTBody = $("#posterListTableBody");
				var steelcutTBody = $("#steelcutListTableBody");
				var trailerTBody = $("#trailerListTableBody");
				posterTBody.html("");
				steelcutTBody.html("");
				trailerTBody.html("");
			});
			
			// 영화 정보 수정 모달 
			$("#movieUpdateButton").click(function() {
				var dataId = $("div[data-id=movieNumber]").text();
				$("#movieDetailModalCloseButton").trigger("click");
				$('#movieUpdateModal').modal({
			        show: true, 
			        backdrop: 'static',
			        keyboard: true
			    });
			});
			
			// 영화 정보 수정
			$("#movieUpdateModalSaveButton").click(function() {
				$.ajax({
					url: "/admin/movie/movieUpdate",
					type: "POST",
					data: $("#movieUpdateForm").serialize(),
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
			$("#movieUpdateModalCloseButton").click(function() {
				$('#movieUpdateModal').modal("hide");
			});
			
			// 영화 정보 삭제
			$("#movieDeleteButton").click(function() {
				if (confirm("정말 삭제하시겠습니까?")) {
					var dataId = $("div[data-id=movieNumber]").text();
					console.log(dataId);
					$.ajax({
						url: "/admin/movie/movieDelete",
						type: "POST",
						data: {
							movieNumber: dataId
						},
						error: function() {
							alert("시스템 오류입니다.");
						},
						success: function(data) {
							alert("삭제되었습니다.");
							$("#movieDetailModalCloseButton").trigger("click");
							self.location.reload(true);
						}
					});
				}
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
	function openVideoModal(that) {
		// Get the modal
    	var modal = $("#videoModal");
    	var modalVid = document.getElementById('videoModalItem');
        var modalVidSrc = document.getElementById('videoModalItemSource');
        
        modalVidSrc.src = $(that).attr("data-src");
        modalVid.load();
        modal.modal({
	        show: true
	    });
        modal.on("hidden.bs.modal", function () {
        	modalVid.pause();
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
		
		// 포스터 업로드
		$("#posterUpload").on("change", function() {
			var fileTypeStr = $("#posterUpload").val().split(".")[1];
			
			$('#posterUpload').fileupload({
		        dataType: 'json', 
		        replaceFileInput: false,
		        formData: {
		        	fileName: $("#movieCode").val(),
		        	fileDir: "upload/gigabox/movie/poster/" + $("#movieCode").val(),
		        	purpose: "POSTER-UPLOAD",
		        	fileType: fileTypeStr
		        },
		        done: function (e, data) {
		            $("#uploadedPosterFile tr:has(td)").remove();
		            alert("업로드 처리 되었습니다.");
		            var result = data.result;
		            var dataSrc = "http://choiys3574.cafe24.com/upload/gigabox/movie/poster/" + $("#movieCode").val() + "/" + result.fileName + "." + result.fileType
	                var dataName = result.fileName + "." + result.fileType;
		            var deleteSrc = "http://choiys3574.cafe24.com/upload/gigabox/movie/poster/" + $("#movieCode").val() + "/" + result.fileName + "." + result.fileType + "/delete";
		            $("#uploadedPosterFile").append(
	                        $('<tr/>')
	                        .append($('<td/>').text(result.fileName + "." + result.fileType))
	                        .append($('<td/>').text(result.fileType))
	                        .append($('<td/>').text(result.thumb))
	                        .append($('<td/>').html("<button class='btn btn-sm btn-warning' onclick='openImageModal(this)' data-src='"+dataSrc+"' data-name='"+dataName+"'>보기</button>"))
	                        .append($('<td/>').html("<button class='btn btn-sm btn-danger' onclick='deleteUploadedFile(this)' data-src='"+dataSrc+"'>삭제</button>"))
	                        );
	                
		        }
		    });
		});
		
		// 스틸컷
		$("#steelcutUpload").on("change", function() {
			var fileTypeStr = $("#steelcutUpload").val().split(".")[1];
			var prevRow = $("#uploadedSteelcutFile tr").length;
			var fileNumStr = "-" + leadingZeros(prevRow + 1, 3);
			$('#steelcutUpload').fileupload({
		        dataType: 'json', 
		        replaceFileInput: false,
		        formData: {
		        	fileName: $("#movieCode").val(),
		        	fileDir: "upload/gigabox/movie/steelcut/" + $("#movieCode").val(),
		        	purpose: "STEELCUT-UPLOAD",
		        	fileType: fileTypeStr
		        },
		        done: function (e, data) {
		        	alert("업로드 처리 되었습니다.");
		            var result = data.result;
		            var dataSrc = "http://choiys3574.cafe24.com/upload/gigabox/movie/steelcut/" + $("#movieCode").val() + "/" + result.fileName + "." + result.fileType;
	                var dataName = result.fileName + "." + result.fileType;
	                var deleteSrc = "http://choiys3574.cafe24.com/upload/gigabox/movie/steelcut/" + $("#movieCode").val() + "/" + result.fileName + "." + result.fileType + "/delete";
		            $("#uploadedSteelcutFile").append(
	                        $('<tr/>')
	                        .append($('<td/>').text(result.fileName + "." + result.fileType))
	                        .append($('<td/>').text(result.fileType))
	                        .append($('<td/>').text(result.thumb))
	                        .append($('<td/>').html("<button class='btn btn-sm btn-warning' onclick='openImageModal(this)' data-src='"+dataSrc+"' data-name='"+dataName+"'>보기</button>"))
	                        .append($('<td/>').html("<button class='btn btn-sm btn-danger' onclick='deleteUploadedFile(this)' data-src='"+dataSrc+"'>삭제</button>"))
	                        );
	             	
		        }
		    });
		});
		
		// 트레일러
		$("#trailerUpload").on("change", function() {
			var fileTypeStr = $("#trailerUpload").val().split(".")[1];
			var prevRow = $("#uploadedTrailerFile tr").length;
			var fileNumStr = + "-" + leadingZeros(prevRow + 1, 3);
			
			$('#trailerUpload').fileupload({
		        dataType: 'json', 
		        replaceFileInput: false,
		        formData: {
		        	fileName: $("#movieCode").val(),
		        	fileDir: "upload/gigabox/movie/trailer/" + $("#movieCode").val(),
		        	purpose: "TRAILER-UPLOAD",
		        	fileType: fileTypeStr
		        },
		        done: function (e, data) {
		        	alert("업로드 처리 되었습니다.");
		            var result = data.result;
		            var dataSrc = "http://choiys3574.cafe24.com/upload/gigabox/movie/trailer/" + $("#movieCode").val() + "/" + result.fileName + "." + result.fileType;
		            var deleteSrc = "http://choiys3574.cafe24.com/upload/gigabox/movie/poster/" + $("#movieCode").val() + "/" + result.fileName + "." + result.fileType + "/delete";
		            $("#uploadedTrailerFile").append(
	                        $('<tr/>')
	                        .append($('<td/>').text(result.fileName + "." + result.fileType))
	                        .append($('<td/>').text(result.fileType))
	                        .append($('<td/>').html("<button class='btn btn-sm btn-warning' onclick='openVideoModal(this)' data-src='"+dataSrc+"'>보기</button>"))
	                		.append($('<td/>').html("<button class='btn btn-sm btn-danger' onclick='deleteUploadedFile(this)' data-src='"+dataSrc+"'>삭제</button>"))        
		            	);
		        },
		 
		        progress: function (e, data) {
		            var progress = parseInt(data.loaded / data.total * 100, 10);
		            $('#progress .bar').css(
		                'width',
		                progress + '%'
		            );
		        }
		    });
		});
		// 포스터 업로드 수정
		$("#posterUploadU").on("change", function() {
			var fileTypeStr = $("#posterUploadU").val().split(".")[1];
			
			$('#posterUploadU').fileupload({
		        dataType: 'json', 
		        replaceFileInput: false,
		        formData: {
		        	fileName: $("#movieCodeU").val(),
		        	fileDir: "upload/gigabox/movie/poster/" + $("#movieCodeU").val(),
		        	purpose: "POSTER-UPLOAD",
		        	fileType: fileTypeStr
		        },
		        done: function (e, data) {
		            $("#uploadedPosterFileU tr:has(td)").remove();
		            alert("업로드 처리 되었습니다.");
		            var result = data.result;
		            var dataSrc = "http://choiys3574.cafe24.com/upload/gigabox/movie/poster/" + $("#movieCodeU").val() + "/" + result.fileName + "." + result.fileType
	                var dataName = result.fileName + "." + result.fileType;
		            var deleteSrc = "http://choiys3574.cafe24.com/upload/gigabox/movie/poster/" + $("#movieCodeU").val() + "/" + result.fileName + "." + result.fileType + "/delete";
		            $("#uploadedPosterFileU").append(
	                        $('<tr/>')
	                        .append($('<td/>').text(result.fileName + "." + result.fileType))
	                        .append($('<td/>').text(result.fileType))
	                        .append($('<td/>').text(result.thumb))
	                        .append($('<td/>').html("<button class='btn btn-sm btn-warning' onclick='openImageModal(this)' data-src='"+dataSrc+"' data-name='"+dataName+"'>보기</button>"))
	                        .append($('<td/>').html("<button class='btn btn-sm btn-danger' onclick='deleteUploadedFile(this)' data-src='"+dataSrc+"'>삭제</button>"))
	                        );
	                
		        }
		    });
		});
		
		// 스틸컷 수정
		$("#steelcutUploadU").on("change", function() {
			var fileTypeStr = $("#steelcutUploadU").val().split(".")[1];
			var prevRow = $("#uploadedSteelcutFileU tr").length;
			var fileNumStr = "-" + leadingZeros(prevRow + 1, 3);
			$('#steelcutUploadU').fileupload({
		        dataType: 'json', 
		        replaceFileInput: false,
		        formData: {
		        	fileName: $("#movieCodeU").val(),
		        	fileDir: "upload/gigabox/movie/steelcut/" + $("#movieCodeU").val(),
		        	purpose: "STEELCUT-UPLOAD",
		        	fileType: fileTypeStr
		        },
		        done: function (e, data) {
		        	alert("업로드 처리 되었습니다.");
		            var result = data.result;
		            var dataSrc = "http://choiys3574.cafe24.com/upload/gigabox/movie/steelcut/" + $("#movieCodeU").val() + "/" + result.fileName + "." + result.fileType;
	                var dataName = result.fileName + "." + result.fileType;
	                var deleteSrc = "http://choiys3574.cafe24.com/upload/gigabox/movie/steelcut/" + $("#movieCodeU").val() + "/" + result.fileName + "." + result.fileType + "/delete";
		            $("#uploadedSteelcutFileU").append(
	                        $('<tr/>')
	                        .append($('<td/>').text(result.fileName + "." + result.fileType))
	                        .append($('<td/>').text(result.fileType))
	                        .append($('<td/>').text(result.thumb))
	                        .append($('<td/>').html("<button class='btn btn-sm btn-warning' onclick='openImageModal(this)' data-src='"+dataSrc+"' data-name='"+dataName+"'>보기</button>"))
	                        .append($('<td/>').html("<button class='btn btn-sm btn-danger' onclick='deleteUploadedFile(this)' data-src='"+dataSrc+"'>삭제</button>"))
	                        );
	             	
		        }
		    });
		});
		
		// 트레일러
		$("#trailerUploadU").on("change", function() {
			var fileTypeStr = $("#trailerUploadU").val().split(".")[1];
			var prevRow = $("#uploadedTrailerFileU tr").length;
			var fileNumStr = + "-" + leadingZeros(prevRow + 1, 3);
			
			$('#trailerUploadU').fileupload({
		        dataType: 'json', 
		        replaceFileInput: false,
		        formData: {
		        	fileName: $("#movieCodeU").val(),
		        	fileDir: "upload/gigabox/movie/trailer/" + $("#movieCodeU").val(),
		        	purpose: "TRAILER-UPLOAD",
		        	fileType: fileTypeStr
		        },
		        done: function (e, data) {
		        	alert("업로드 처리 되었습니다.");
		            var result = data.result;
		            var dataSrc = "http://choiys3574.cafe24.com/upload/gigabox/movie/trailer/" + $("#movieCodeU").val() + "/" + result.fileName + "." + result.fileType;
		            var deleteSrc = "http://choiys3574.cafe24.com/upload/gigabox/movie/poster/" + $("#movieCodeU").val() + "/" + result.fileName + "." + result.fileType + "/delete";
		            $("#uploadedTrailerFileU").append(
	                        $('<tr/>')
	                        .append($('<td/>').text(result.fileName + "." + result.fileType))
	                        .append($('<td/>').text(result.fileType))
	                        .append($('<td/>').html("<button class='btn btn-sm btn-warning' onclick='openVideoModal(this)' data-src='"+dataSrc+"'>보기</button>"))
	                		.append($('<td/>').html("<button class='btn btn-sm btn-danger' onclick='deleteUploadedFile(this)' data-src='"+dataSrc+"'>삭제</button>"))        
		            	);
		        },
		 
		        progress: function (e, data) {
		            var progress = parseInt(data.loaded / data.total * 100, 10);
		            $('#progress .bar').css(
		                'width',
		                progress + '%'
		            );
		        }
		    });
		});
		
		
	});
	</script>
</body>
</html>
