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
</head>
 
<body>

	<div id="admin_faq_wrapper">

		<c:import url="/templates/header.jsp" />
		<c:import url="/templates/aside.jsp" />

		<div id="page-wrapper">
			<section id="admin_faq_section">
				<div class="row">
					<div class="col-lg-12">
						<h3 class="page-header">FAQ 관리 페이지</h3>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->

				<div class="row">
	                <div class="col-lg-12">
	                <article id="admin_faq_table_article">
	                    <div class="panel panel-default">
	                        <div class="panel-heading" style="height: 50px;">
	                            <i class="fa fa-question-circle fa-fw"></i> FAQ 목록
	                            <div class="pull-right">
	                                <div class="btn-group">
	                                    <button type="button" class="btn btn-success btn-sm" id="faqInsertModalButton">FAQ 추가</button>
	                                </div>
	                            </div>
	                        </div>
	                        <!-- /.panel-heading -->
	                        <div class="panel-body">
	                            <table width="100%" class="table table-bordered table-hover" id="faqListTable">
	                                <thead>
	                                    <tr>
	                                        <th style="text-align: center;">번호</th>
	                                        <th style="text-align: center;">분류</th>
	                                        <th style="text-align: center;">제목</th>
	                                    </tr>
	                                </thead>
	                                <tbody id="faqListTableBody">
	                                	<c:forEach var="faqItem" items="${faqList}">
	                                    <tr data-id="${faqItem.faqNumber}">
	                                        <td style="text-align: center;">${faqItem.faqNumber}</td>
	                                        <td style="text-align: center;"><span class="label label-success">${faqItem.faqType}</span></td>
	                                        <td style="text-align: left;">${faqItem.faqTitle}</td>
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
											<li><a href="/admin/cc/faq/faqMain${pageMaker.makeQuery(pageMaker.startPage-1)}">&laquo;</a></li>
										</c:if>
			
										<c:forEach begin="${pageMaker.startPage}"
											end="${pageMaker.endPage}" var="idx">
											<li 
												<c:out value="${pageMaker.criteria.page == idx?'class=\"active\"':''}"/>>
												<a href="/admin/cc/faq/faqMain${pageMaker.makeQuery(idx)}">${idx}</a>
											</li>
										</c:forEach>
			
										<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
											<li><a href="/admin/cc/faq/movieMain${pageMaker.makeQuery(pageMaker.endPage+1)}">&raquo;</a></li>
										</c:if>
									</ul>
									<div class="form-group input-group" style="margin: 0 auto;">
										<form id="faqSearchForm" class="form-horizontal">
			                                <select id="searchType" name="searchType" class="form-control" style="width: 200px; height: 35px;">
			                                    <option value="전체">전체</option>
			                                    <option value="마일리지">마일리지</option>
			                                    <option value="영화예매">영화예매</option>
												<option value="결제">결제</option>
												<option value="영화관">영화관</option>           
												<option value="홈페이지">홈페이지</option>
												<option value="기타">기타</option>
			                                </select>
			                                <input type="text" id="searchKeyword" name="searchKeyword" class="form-control" placeholder="검색할 내용을 입력해주세요." style="width: 600px; height: 35px;">
			                                <button type="submit" id="faqSearchButton" class="btn btn-primary">검색</button>
			                            </form>
		                            </div>
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


	<!-- 공지사항 상세보기 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="faqDetailModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">FAQ 상세보기</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="faqDetailForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="faqTitle">제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="faqTitle" name="faqTitle" type="text" 
                							readonly="readonly">
                						<input type="hidden" id="faqNumber" name="faqNumber">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="faqType">분류</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="faqType" name="faqType" type="text"
                							readonly="readonly">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="faqContent">내용</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<div class="form-control" id="faqContent" style="height: 400px;"></div>
                					</div>
                				</div>
                			</div>
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="faqUpdateModalButton" type="button" class="btn btn-success" data-dismiss="modal">수정</button>
                     <button id="faqDeleteButton" type="button" class="btn btn-warning" data-dismiss="modal">삭제</button>
                     <button id="faqDetailModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    
    <!-- 공지사항 추가 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="faqInsertModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">FAQ 등록</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="faqInsertForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="faqTitleI">제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="faqTitleI" name="faqTitle" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="faqTypeI">분류</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="faqTypeI" name="faqType">
		                                    <option value="마일리지">마일리지</option>
		                                    <option value="영화예매">영화예매</option>
											<option value="결제">결제</option>
											<option value="영화관">영화관</option>           
											<option value="홈페이지">홈페이지</option>
											<option value="기타">기타</option>
                						</select>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="faqContentI">내용</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<textarea class="form-control summernote" id="faqContentI" name="faqContent">
                						</textarea>
                					</div>
                				</div>
                			</div>
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="faqInsertSaveButton" type="button" class="btn btn-warning" data-dismiss="modal">저장</button>
                     <button id="faqInsertModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    
	<!-- 공지사항 수정 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="faqUpdateModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">FAQ 수정</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="faqUpdateForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="faqTitleU">제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="faqTitleU" name="faqTitle" type="text">
                						<input type="hidden" id="faqNumberU" name="faqNumber">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="faqTypeU">분류</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="faqTypeU" name="faqType">
                							<option value="mileage">마일리지</option>
		                                    <option value="reservation">영화예매</option>
											<option value="payment">결제</option>
											<option value="cinema">영화관</option>           
											<option value="homepage">홈페이지</option>
											<option value="etc">기타</option>
	                					</select>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="faqContentU">내용</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<textarea class="form-control summernote" id="faqContentU" name="faqContent">
                						</textarea>
                					</div>
                				</div>
                			</div>
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="faqUpdateSaveButton" type="button" class="btn btn-warning" data-dismiss="modal">저장</button>
                     <button id="faqUpdateModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
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
			
		$('#faqSearchButton').on("click", function(event) {
			event.preventDefault();
			var queryString = "/admin/cc/faq/faqMain"
				+ '${pageMaker.makeQuery(1)}'
				+ "&searchType="
				+ $("#searchType").val()
				+ "&searchKeyword=" + $('#searchKeyword').val();
			
			self.location = queryString;
		});
		
		// FAQ 추가 
		$("#faqInsertModalButton").click(function(e) {
			e.preventDefault();
			$("#faqTitleI").val("");
			$('#faqContentI').summernote({
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
			$("#faqContentI").summernote("code", "");
			
			// 모달 관리
            $('#faqInsertModal').modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
		});
		
		// FAQ 추가 모달 저장
		$("#faqInsertSaveButton").click(function(e) {
			e.preventDefault();
			$.ajax({
				url: "/admin/cc/faq/faqInsert",
				type: "POST",
				data: $("#faqInsertForm").serialize(),
				error: function() {
					console.log("FAQ 추가 실패");
				},
				success: function(data) {
					if (data.result == 'SUCCESS') {
						alert("FAQ 추가에 성공하였습니다.");
						self.location.reload(true);
					} else {
						alert("FAQ 추가에 실패하였습니다.");
					}		
				}
			});
			
		});
		
		// FAQ 추가 모달 닫기 버튼
		$("#faqInsertModalCloseButton").click(function(e) {
			e.preventDefault();
			$('#faqInsertModal').modal("hide");
		});
		
		
		// FAQ 세부내용 불러오기
		$('#faqListTableBody').on('click', 'tr', function(e) {
			e.preventDefault();
			
			// 데이터 불러오기 파트
			var dataId = $(this).attr("data-id");
			$.ajax({
				url: "/admin/cc/faq/faqDetail/" + dataId,
				type: "PUT",
				headers: {
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "PUT"
				},
				error: function() {
					alert("시스템 오류입니다.");
				},
				success: function(data) {
					
					$("#faqNumber").val(data.faqNumber);
					$("#faqTitle").val(data.faqTitle);
					$("#faqType").val(data.faqType);
					$("#faqContent").html(data.faqContent);
					
					
					// 업데이트 모달에 정보를 미리 줌.
					$("#faqNumberU").val(data.faqNumber);
					$("#faqTitleU").val(data.faqTitle);
					$("#faqTypeU option").each(function() {
						if ($(this).val() == data.faqType) {
							$(this).prop("selected", true);
						}
					});
					
					$('#faqContentU').summernote({
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
					$("#faqContentU").summernote("code", data.faqContent);
					
					// 모달 관리
		            $('#faqDetailModal').modal({
				        show: true, 
				        backdrop: 'static',
				        keyboard: true
				    });
					
				}
			});
			
	    });
		
		// FAQ 수정 버튼 클릭 --> 수정 모달 생성
        $("#faqUpdateModalButton").click(function(e) {
			e.preventDefault();
			$('#faqDetailModal').modal("hide");
			$('#faqUpdateModal').modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
        });
		
		// FAQ 수정 저장
		$("#faqUpdateSaveButton").click(function(e) {
			e.preventDefault();
			$.ajax({
				url: "/admin/cc/faq/faqUpdate",
				type: "POST",
				data: $("#faqUpdateForm").serialize(),
				error: function() {
					console.log("FAQ 수정 실패");
				},
				success: function(data) {
					if (data.result == 'SUCCESS') {
						alert("FAQ 수정에 성공하였습니다.");
						self.location.reload(true);
					} else {
						alert("FAQ 수정에 실패하였습니다.");
					}		
				}
			});
			
		});
		
		$("#faqUpdateModalCloseButton").click(function(e) {
			e.preventDefault();
			$('#faqUpdateModal').modal("hide");
			$('#faqDetailModal').modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
		});
		
		// 상세보기 모달 --> 삭제 버튼 클릭
		$("#faqDeleteButton").click(function(e) {
			e.preventDefault();
			console.log($("#faqNumber").val());
			$.ajax({
				url: "/admin/cc/faq/faqDelete",
				type: "POST",
				data: { faqNumber: $("#faqNumber").val()},
				error: function() {
					console.log("FAQ 삭제 실패");
				},
				success: function(data) {
					if (data.result == 'SUCCESS') {
						alert("FAQ 삭제에 성공하였습니다.");
						self.location.reload(true);
					} else {
						alert("FAQ 삭제에 실패하였습니다.");
					}		
				}
			});
			
		});
		
		
		// 상세모달 닫기
		$("#faqDetailModalCloseButton").click(function(e) {
			e.preventDefault();
			$('#faqDetailModal').modal("hide");
		});
		
	});
</script>	
	

</body>

</html>
