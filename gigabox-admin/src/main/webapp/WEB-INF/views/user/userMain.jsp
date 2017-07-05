<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

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

<!-- summernote -->
<link href="/resources/summernote/summernote.css" rel="stylesheet"/>
<script type="text/javascript" src="/resources/summernote/summernote.min.js"></script>
<script type="text/javascript" src="/resources/summernote/lang/summernote-ko-KR.js"></script>
 

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<style type="text/css">

tr:hover td {
    background-color: #6495ED !important;
}

td {
    max-width: 150px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
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
</style>
<script>
    $(document).ready(function() {
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
        $('#startDateGroup').datepicker(options);
        $('#endDateGroup').datepicker(options);
        $('#userRegGroup').datepicker(options);
        $('#userRegUGroup').datepicker(options);
    });
</script>
</head>
 
<body>

	<div id="admin_user_wrapper">

		<c:import url="/templates/header.jsp" />
		<c:import url="/templates/aside.jsp" />

		<div id="page-wrapper">
			<section id="admin_user_section">
				<div class="row">
					<div class="col-lg-12">
						<h3 class="page-header">회원 관리 페이지</h3>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->


				<div class="row">

                <div class="col-lg-12">
                <article id="admin_user_control_article">

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-info-circle fa-fw"></i> 회원 검색
                        </div>
                        <!-- /.panel-heading -->
                        <form role="form" id="userSearchForm">
                        <div class="panel-body">
                            <div class="list-group">
                                <div class="list-group-item">
                                    <span class="pull-left text-muted" style="width: 80px; text-align: center;">회원검색&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <div class="form-group input-group" style="width: 500px;">
                                        <select class="form-control" style="width: 100px; height: 35px;" 
                                        	name="searchType" id="searchType">
                                        <option value="all">전체</option>
                                        <option value="id">ID</option>
                                        <option value="name">회원명</option>
                                        <option value="email">E-MAIL</option>
                                    </select>
                                    <input type="text" class="form-control" placeholder="검색 내용을 입력해 주세요." style="width: 400px; height: 35px;"
                                    	name="searchKeyword" id="searchKeyword">
                                    </div>
                                </div>
                                <div class="list-group-item">
                                	<span class="pull-left text-muted" style="width: 80px; text-align: center;">회원상태&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <div class="form-group input-group" style="width: 500px;">
                                        <select class="form-control" name="searchStatus" id="searchStatus">
	                                        <option value="정상가입">정상가입</option>
	                                        <option value="가입대기">가입대기</option>
	                                        <option value="탈퇴회원">탈퇴회원</option>
	                                        <option value="블라인드">블라인드</option>
	                                    </select>
                               		</div>
                               	</div>
                                <div class="list-group-item">
                                    <span class="pull-left text-muted" style="width: 80px; text-align: left;">가입기간&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <div class="form-group input-group" style="width: 500px;">
                                        <div class="input-group date" data-provide="datepicker" id="startDateGroup">
                                            <input type="text" class="form-control" id="startDate" name="startDate">
                                            <div class="input-group-addon">
                                                <span class="glyphicon glyphicon-th"></span>
                                            </div>
                                        </div>
                                        <span class="input-group-addon">~</span>
                                        <div class="input-group date" data-provide="datepicker" id="endDateGroup">
                                            <input type="text" class="form-control" id="endDate" name="endDate">
                                            <div class="input-group-addon">
                                                <span class="glyphicon glyphicon-th"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.list-group -->
                        </div>
                        <!-- /.panel-body -->
                        <div class="panel-footer" style="height: 50px;">
                            <div class="input-group pull-right">
                                <button type="submit" class="btn btn-primary" id="userSearchButton">검색</button>&nbsp;&nbsp;
                                <button type="reset" class="btn btn-danger" id="userSearchInitButton">초기화</button>
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
                <article id="admin_user_table_article">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="height: 50px;">
                            <i class="fa fa-user fa-fw"></i> 회원 목록
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-bordered table-hover" id="userListTable">
                                <thead>
                                    <tr>
                                        <th style="text-align: center;">ID</th>
                                        <th style="text-align: center;">이름</th>
                                        <th style="text-align: center;">성별</th>
                                        <th style="text-align: center;">이메일</th>
                                        <th style="text-align: center;">회원상태</th> 
                                        <th style="text-align: center;">가입일</th>
                                        <th style="text-align: center;">마일리지</th>
                                    </tr>
                                </thead>
                                <tbody id="userListTableBody">
                                	<c:forEach var="userItem" items="${userList}">
                                    <tr data-id="${userItem.userNumber}">
                                        <td style="text-align: center;">${userItem.userId}</td>
                                        <td style="text-align: center;">${userItem.userName}</td>
                                        <td style="text-align: center;">${userItem.userGender}</td>
                                        <td style="text-align: center;">${userItem.userEmail}</td>
                                        <td style="text-align: center;">${userItem.userStatus}</td>
                                        <td style="text-align: center;"><fmt:formatDate value="${userItem.userReg}" pattern="yyyy-MM-dd"/></td>
                                        <td style="text-align: center;">${userItem.userMileage}</td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <!-- /.panel-body -->
                        <div class="panel-footer">
                        	<div class="text-center">
						<ul class="pagination">

							<c:if test="${pageMaker.prev}">
								<li><a href="/admin/user/userMain${pageMaker.makeQuery(pageMaker.startPage-1)}">&laquo;</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}" var="idx">
								<li 
									<c:out value="${pageMaker.criteria.page == idx?'class=\"active\"':''}"/>>
									<a href="/admin/user/userMain${pageMaker.makeQuery(idx)}">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a href="/admin/user/userMain${pageMaker.makeQuery(pageMaker.endPage+1)}">&raquo;</a></li>
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
			<!-- /#admin_user_section -->
		
        </div>
        <!-- /#page-wrapper -->
	</div>
	<!-- /#admin_user_wrapper -->

	<c:import url="/templates/footer.jsp" />


	<!-- 사용자 상세보기 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="userDetailModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">회원 상세보기</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="userDetailForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userId">회원 아이디</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="userId" name="userId" type="text" 
                							readonly="readonly">
                						<input type="hidden" id="userNumber" name="userNumber">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userName">회원 이름</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="userName" name="userName" type="text"
                							readonly="readonly">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userGender">성별</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<select class="form-control" id="userGender" name="userGender" 
	                						disabled="disabled">
	               							<option value="M">남자</option>
	               							<option value="F">여자</option>
	               						</select>
               						</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userBirthday">생년월일</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<input class="form-control" id="userBirthday" name="userBirthday" type="text"
	                						readonly="readonly">
	                				</div>
	                			</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userEmail">이메일</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="userEmail" name="userEmail" 
                							readonly="readonly" type="email">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userTel">연락처</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input type="text" class="form-control" readonly="readonly" 
                							id="userTel" name="userTel">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userAddr">주소</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="userAddr" name="userAddr" type="text"
                							readonly="readonly">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userReg">가입일</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<div class="input-group date" data-provide="datepicker" id="userRegGroup">
                                            <input type="text" class="form-control" id="userReg" name="userReg">
                                            <div class="input-group-addon">
                                                <span class="glyphicon glyphicon-th"></span>
                                            </div>
                                        </div>
               						</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userMileage">마일리지</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="userMileage" name="userMileage" type="number"
                							readonly="readonly">
                						<div class="input-group-addon">
                                            <span>포인트</span>
                                        </div>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userStatus">가입상태</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="userStatus" name="userStatus" disabled="disabled">
                							<option value="정상가입">정상가입</option>
                							<option value="가입대기">가입대기</option>
                							<option value="탈퇴회원">회원탈퇴</option>
                							<option value="블라인드">블라인드</option>
                						</select>
                					</div>
                				</div>
                			</div>
                			
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="userEmailSendModalButton" type="button" class="btn btn-primary" data-dismiss="modal">E-mail</button> 
                	 <button id="userUpdateStartButton" type="button" class="btn btn-success" data-dismiss="modal">수정</button>
                     <button id="userDetailModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    
	<!-- 회원 수정 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="userUpdateModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">회원 수정</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="userUpdateForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userIdU">회원 아이디</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="userIdU" name="userId" type="text"
                							readonly="readonly">
                						<input type="hidden" id="userNumberU" name="userNumber">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userNameU">회원 이름</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="userNameU" name="userName" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userGenderU">성별</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<select class="form-control" id="userGenderU" name="userGender">
	               							<option value="M">남자</option>
	               							<option value="F">여자</option>
	               						</select>
               						</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userBirthdayU">생년월일</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<input class="form-control" id="userBirthdayU" name="userBirthday" type="text">
	                				</div>
	                			</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userEmailU">이메일</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="userEmailU" name="userEmail" type="email">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userTelU">연락처</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input type="text" class="form-control" id="userTelU" name="userTel">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userAddrU">주소</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="userAddrU" name="userAddr" type="text">
.                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userRegU">가입일</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<div class="input-group date" data-provide="datepicker" id="userRegUGroup">
                                            <input type="text" class="form-control" id="userRegU" name="userReg">
                                            <div class="input-group-addon">
                                                <span class="glyphicon glyphicon-th"></span>
                                            </div>
                                        </div>
               						</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userMileageU">마일리지</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="userMileageU" name="userMileage" type="number">
                						<div class="input-group-addon">
                                            <span>포인트</span>
                                        </div>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userStatusU">가입상태</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="userStatusU" name="userStatus">
                							<option value="정상가입">정상가입</option>
                							<option value="가입대기">가입대기</option>
                							<option value="탈퇴회원">회원탈퇴</option>
                							<option value="블라인드">블라인드</option>
                						</select>
                					</div>
                				</div>
                			</div>
                			
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="userUpdateSaveButton" type="button" class="btn btn-warning" data-dismiss="modal">저장</button>
                     <button id="userUpdateModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

	<!-- 이메일 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="emailModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">E-mail 작성</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="emailForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userEmailTo">To: </label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="userEmailTo" name="userEmailTo" type="email"
                							readonly="readonly">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userEmailFrom">From: </label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="userEmailFrom" name="userEmailFrom" type="email"
                							readonly="readonly" value="gigabox777@gmail.com">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userEmailTitle">제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="userEmailTitle" name="userEmailTitle" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="userEmailContent">내용: </label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<textarea class="form-control summernote" id="userEmailContent" name="userEmailContent"></textarea>
                					</div>
                				</div>
                			</div>
                			
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="emailSendButton" type="button" class="btn btn-warning" data-dismiss="modal">보내기</button>
                     <button id="emailModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
	

	<script>
	$(document).ready(function() {
	
		
		if ('${param.searchType}' != '') {
			$("#searchType").val('${param.searchType}');
		}
		if ('${param.searchKeyword}' != '') {
			$("#searchKeyword").val('${param.searchKeyword}');
		}
		if ('${param.startDate}' != '') {
			$("#startDate").val('${param.startDate}');
		}
		if ('${param.endDate}' != '') {
			$("#endDate").val('${param.endDate}');
		}
			
		$('#userSearchButton').on("click",	function(event) {
			event.preventDefault();
			var queryString = "/admin/user/userMain"
				+ '${pageMaker.makeQuery(1)}'
				+ "&searchType="
				+ $("#searchType").val()
				+ "&searchKeyword=" + $('#searchKeyword').val()
				+ "&startDate=" + $('#startDate').val()
				+ "&endDate=" + $("#endDate").val()
				+ "&searchStatus=" + $("#searchStatus").val();
			
			self.location = queryString;
		});
		
		// 영화 목록 > 클릭 > 영화 상세보기
		$('#userListTableBody').on('click', 'tr', function (e) {
			e.preventDefault();
			
			// 데이터 불러오기 파트
			var dataId = $(this).attr("data-id");
			$.ajax({
				url: "/admin/user/userDetail/" + dataId,
				type: "PUT",
				headers: {
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "PUT"
				},
				error: function() {
					alert("시스템 오류입니다.");
				},
				success: function(data) {
					
					$("#userNumber").val(data.userNumber);
					$("#userId").val(data.userId);
					$("#userName").val(data.userName);
					$("#userBirthday").val(data.userBirthday);
					$("#userEmail").val(data.userEmail);
					$("#userTel").val(data.userTel);
					$("#userAddr").val(data.userAddr);
					$("#userReg").val(data.userReg);
					$("#userMileage").val(data.userMileage);
					
					// status
					var status = data.userStatus;
					if (status == '정상가입') {
						$("#userStatus option:eq(0)").attr("selected", true);
					} else if (status == '가입대기') {
						$("#userStatus option:eq(1)").attr("selected", true);
					} else if (status == '탈퇴회원') {
						$("#userStatus option:eq(2)").attr("selected", true);
					} else if (status == '블라인드') {
						$("#userStatus option:eq(3)").attr("selected", true);
					}
					
					// gender
					var gender = data.userGender;
					if (gender == 'M') {
						$("#userGender option:eq(0)").prop("selected", true);
					} else if (gender == 'F') {
						$("#userGender option:eq(1)").prop("selected", true);
					}
					
					// datepicker
					$("#userReg").prop('disabled', true);
					$("#userRegGroup").find(".input-group-addon").unbind("click");
					
					
					// 업데이트 모달에 정보를 미리 줌.
					
					$("#userNumberU").val(data.userNumber);
					$("#userIdU").val(data.userId);
					$("#userNameU").val(data.userName);
					$("#userBirthdayU").val(data.userBirthday);
					$("#userEmailU").val(data.userEmail);
					$("#userTelU").val(data.userTel);
					$("#userAddrU").val(data.userAddr);
					$("#userRegU").val(data.userReg);
					$("#userMileageU").val(data.userMileage);
					
					// status
					var status = data.userStatus;
					if (status == '정상가입') {
						$("#userStatusU option:eq(0)").attr("selected", true);
					} else if (status == '가입대기') {
						$("#userStatusU option:eq(1)").attr("selected", true);
					} else if (status == '탈퇴회원') {
						$("#userStatusU option:eq(2)").attr("selected", true);
					} else if (status == '블라인드') {
						$("#userStatusU option:eq(3)").attr("selected", true);
					}
					
					// gender
					var gender = data.userGender;
					if (gender == 'M') {
						$("#userGenderU option:eq(0)").prop("selected", true);
					} else if (gender == 'F') {
						$("#userGenderU option:eq(1)").prop("selected", true);
					}
					
					// 모달 관리
		            $('#userDetailModal').modal({
				        show: true, 
				        backdrop: 'static',
				        keyboard: true
				    });
					
					
				}
			});
			
	    });
		
		// 영화 수정 버튼 클릭
        $("#userUpdateStartButton").click(function(e) {
			e.preventDefault();
			$('#movieDetailModal').modal("hide");
			$('#userUpdateModal').modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
        });
		
		$("#userUpdateSaveButton").click(function(e) {
			e.preventDefault();
			$.ajax({
				url: "/admin/user/userUpdate",
				type: "POST",
				data: $("#userUpdateForm").serialize(),
				error: function() {
					alert("시스템 오류입니다.");
				},
				success: function(data) {
					alert(data.result);
					self.location.reload(true);
				}
			});
			
		});
		
		// 이메일 전송 모달 띄우기
		$("#userEmailSendModalButton").click(function(e) {
			e.preventDefault();
			// 영화 추가 - 서머노트 에디터 적용
			
			$('#userEmailContent').summernote({
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
			$("#userDetailModal").modal("hide");
			$("#userEmailTo").val($("#userEmail").val());
			$("#emailModal").modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
		});
		
		// 이메일 보내기
		$("#emailSendButton").click(function(e) {
			e.preventDefault();
			$.ajax({
				url: "/admin/user/email",
				type: "POST",
				data: $("#emailForm").serialize(),
				error: function() {
					alert("시스템 오류입니다.");
				},
				success: function(data) {
					alert("이메일 전송이 완료되었습니다.");
				}
			});
		});
		
		// 이메일 모달 닫기
		$("#emailModalCloseButton").click(function(e) {
			$("#emailModal").hide();
			$("#userEmailContent").summernote("code", "");
			$("#userDetailModal").modal("show");
		});
		
		// 상세모달 닫기
		$("#userDetailModalCloseButton").click(function(e) {
			e.preventDefault();
			$('#movieDetailModal').modal("hide");
		});
		
		// 수정모달 닫기
		$("#userUpdateModalCloseButton").click(function(e) {
			e.preventDefault();
			$('#movieUpdateModal').modal("hide");
		});
	});
</script>	
	

</body>

</html>
