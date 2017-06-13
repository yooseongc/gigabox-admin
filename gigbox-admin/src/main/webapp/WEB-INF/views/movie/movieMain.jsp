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

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<style>
tr:hover td {
    background-color: #6495ED !important;
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
                                                    <input type="checkbox" name="genre" value="공포">공포
                                                </label>
                                                <label class="checkbox-inline">
                                                    <input type="checkbox" name="genre" value="범죄">범죄
                                                </label>
                                                <label class="checkbox-inline">
                                                    <input type="checkbox" name="genre" value="액션">액션
                                                </label>
                                                <label class="checkbox-inline">
                                                    <input type="checkbox" name="genre" value="청춘">청춘
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
                                                    <input type="checkbox" name="genre" value="어드벤처">어드벤처
                                                </label>
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
                                                    <input type="checkbox" name="genre" value="판타지">판타지
                                                </label>
                                                <label class="checkbox-inline">
                                                    <input type="checkbox" name="genre" value="로맨스">로맨스
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="list-group-item">
                                        <span class="pull-left text-muted" style="width: 80px; text-align: center;">영화등급&nbsp;&nbsp;&nbsp;
                                        </span>
                                        <div class="form-group">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="rating" value="전체 관람가">전체 관람가
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

                <div class="col-lg-12">
                <article id="admin_movie_table_article">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="height: 50px;">
                            <i class="fa fa-video-camera fa-fw"></i> 영화 목록
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-success btn-sm">영화 추가</button>
                                </div>
                            </div>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-bordered table-hover" id="movieListTable">
                                <thead>
                                    <tr>
                                        <th class="center">영화번호</th>
                                        <th class="center">영화제목</th>
                                        <th class="center">영화타입</th>
                                        <th class="center">영화등급</th>
                                        <th class="center">개봉일</th>
                                        <th class="center">장르</th>
                                    </tr>
                                </thead>
                                <tbody id="movieListTableBody">
                                	<c:forEach var="movieItem" items="${movieList}">
                                    <tr data-id="${movieItem.movieNumber}">
                                        <td>${movieItem.movieNumber}</td>
                                        <td>${movieItem.movieTitle}</td>
                                        <td>${movieItem.movieType}</td>
                                        <td>${movieItem.movieRating}</td>
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

	<!-- Modal -->
    <div class="modal fade" id="movieDetailModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3 class="modal-title" id="modalLabel"><span id="detailMovieTitle" style="font-weight: bold;"></span></h3>
                </div>
                <div class="modal-body">
                	<div class="panel panel-default">
                        <div class="panel-body">
                            <div class="list-group">
                                <div class="list-group-item hide" data-id="movieNumber"></div>
                                <div class="list-group-item" data-id="movieTitle"></div>
                                <div class="list-group-item" data-id="movieType"></div>
                                <div class="list-group-item" data-id="movieRating"></div>
                                <div class="list-group-item" data-id="movieReleasedate"></div>
                                <div class="list-group-item" data-id="movieDirector"></div>
                                <div class="list-group-item" data-id="movieCast"></div>
                                <div class="list-group-item" data-id="movieScreentime"></div>
                                <div class="list-group-item" data-id="movieGenre"></div>
                                <div class="list-group-item" data-id="movieStoryline"></div>
                                <div class="list-group-item" data-id="movieEngname"></div>
                                <div class="list-group-item" data-id="moviePoster"></div>
                                <div class="list-group-item" data-id="movieSteelcut"></div>
                                <div class="list-group-item" data-id="movieTrailer"></div>
                            </div>
                            <!-- /.list-group -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->      	
                </div>
                <div class="modal-footer">
                	 <button id="movieUpdateBtn" type="button" class="btn btn-success">수정</button>
                	 <button id="movieDeleteBtn" type="button" class="btn btn-warn">삭제</button>
                     <button id="movieDetailModalCloseBtn" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

	<c:import url="/templates/footer.jsp" />

	<!-- jQuery -->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="/resources/dist/js/sb-admin-2.js"></script>


	<!-- DataTables JavaScript -->
	<script src="/resources/vendor/datatables/js/jquery.dataTables.min.js"></script>
	<script
		src="/resources/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
	<script
		src="/resources/vendor/datatables-responsive/dataTables.responsive.js"></script>

	<!-- Page-Level Demo Scripts - Tables - Use for reference -->
	<script>
		$(document).ready(function() {
			var table = $('#movieListTable').DataTable({
				"responsive" : true,
				"paging":   false,
				"searching": false
			});
			
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
						$("#detailMovieTitle").text(data.movieTitle);
						$("div[data-id=movieTitle]").text(data.movieTitle);
						$("div[data-id=movieType]").text(data.movieType);
						$("div[data-id=movieRating]").text(data.movieRating);
						$("div[data-id=movieReleasedate]").text(data.movieReleasedate);
						$("div[data-id=movieDirector]").text(data.movieDirector);
						$("div[data-id=movieCast]").text(data.movieCast);
						$("div[data-id=movieScreentime]").text(data.movieScreentime);
						$("div[data-id=movieGenre]").text(data.movieGenre);
						$("div[data-id=movieStoryline]").text(data.movieStoryline);
						$("div[data-id=movieEngname]").text(data.movieEngname);
						$("div[data-id=moviePoster]").text(data.moviePoster);
						$("div[data-id=movieSteelcut]").text(data.movieSteelcut);
						$("div[data-id=movieTrailer]").text(data.movieTrailer);
					} 
				});
				
				
	            $('#movieDetailModal').modal({
			        show: true, 
			        backdrop: 'static',
			        keyboard: true
			    });
		    });

		});
	</script>

</body>

</html>
