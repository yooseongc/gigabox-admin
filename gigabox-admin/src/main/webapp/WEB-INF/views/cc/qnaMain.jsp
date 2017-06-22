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

	<div id="admin_qna_wrapper">

		<c:import url="/templates/header.jsp" />
		<c:import url="/templates/aside.jsp" />

		<div id="page-wrapper">
			<section id="admin_qna_section">
				<div class="row">
					<div class="col-lg-12">
						<h3 class="page-header">QNA 관리 페이지</h3>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->
				
				<form id="qnaSearchForm" class="form-horizontal">
				<div class="row">
	                <div class="col-lg-12">
	                <article id="admin_qna_table_article">
	                    <div class="panel panel-default">
	                        <div class="panel-heading" style="height: 50px;">
	                            <i class="fa fa-question-circle fa-fw"></i> QNA 목록
	                            <div class="pull-right">
	                                <select id="inquiryType" name="inquiryType" class="form-control" style="width: 150px; height: 35px;">
	                                    <option value="">전체</option>
	                                    <option value="Q">답변 미완료</option>
	                                    <option value="A">답변 완료</option>
	                                </select>
	                            </div>
	                        </div>
	                        <!-- /.panel-heading -->
	                        <div class="panel-body">
	                            <table width="100%" class="table table-bordered table-hover" id="qnaListTable">
	                                <thead>
	                                    <tr>
	                                        <th style="text-align: center;">번호</th>
	                                        <th style="text-align: center;">제목</th>
	                                        <th style="text-align: center;">작성자</th>
	                                        <th style="text-align: center;">등록일</th>
	                                        <th style="text-align: center;">답변</th>
	                                    </tr>
	                                </thead>
	                                <tbody id="qnaListTableBody">
	                                	<c:forEach var="qnaItem" items="${inquiryList}">
	                                    <tr data-id="${qnaItem.inquiry.inquiryNumber}">
	                                        <td style="text-align: center;">${qnaItem.inquiry.inquiryNumber}</td>
	                                        <c:if test="${qnaItem.answerExist == 1}">
	                                        	<td style="text-align: left;"><span class="label label-primary">답변 완료</span> &nbsp;${qnaItem.inquiry.inquiryTitle}</td>
	                                        </c:if>
	                                        <c:if test="${qnaItem.answerExist == 0}">
	                                        	<td style="text-align: left;"><span class="label label-warning">답변 미완료</span> &nbsp;${qnaItem.inquiry.inquiryTitle}</td>
	                                        </c:if>
	                                        <td style="text-align: center;">${qnaItem.user.userId}</td>
	                                        <td style="text-align: center;"><fmt:formatDate value="${qnaItem.inquiry.inquiryRegisterdate}" pattern="yyyy-MM-dd"/></td>
	                                    	<c:if test="${qnaItem.answerExist == 1}">
	                                        	<td style="text-align: center;"><button class="btn btn-sm btn-primary" data-num="${qnaItem.inquiry.inquiryNumber}"
	                                        		data-groupnum="${qnaItem.inquiry.inquiryGroupnumber}" onclick="viewAnswer(this, event);">답변 보기</button></td>
	                                        </c:if>
	                                        <c:if test="${qnaItem.answerExist == 0}">
	                                        	<td style="text-align: center;"><button class="btn btn-sm btn-warning" data-num="${qnaItem.inquiry.inquiryNumber}" 
	                                        		data-groupnum="${qnaItem.inquiry.inquiryGroupnumber}" onclick="writeAnswer(this, event);">답변 달기</button></td>
	                                        </c:if>
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
											<li><a href="/admin/cc/qna/qnaMain${pageMaker.makeQuery(pageMaker.startPage-1)}">&laquo;</a></li>
										</c:if>
			
										<c:forEach begin="${pageMaker.startPage}"
											end="${pageMaker.endPage}" var="idx">
											<li 
												<c:out value="${pageMaker.criteria.page == idx?'class=\"active\"':''}"/>>
												<a href="/admin/cc/qna/qnaMain${pageMaker.makeQuery(idx)}">${idx}</a>
											</li>
										</c:forEach>
			
										<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
											<li><a href="/admin/cc/qna/movieMain${pageMaker.makeQuery(pageMaker.endPage+1)}">&raquo;</a></li>
										</c:if>
									</ul>
									<div class="form-group input-group" style="margin: 0 auto;">
										
			                                <select id="searchType" name="searchType" class="form-control" style="width: 200px; height: 35px;">
			                                    <option value="t">제목</option>
			                                    <option value="c">내용</option>
			                                    <option value="tc">제목+내용</option>
			                                </select>
			                                <input type="text" id="searchKeyword" name="searchKeyword" class="form-control" placeholder="검색할 내용을 입력해주세요." style="width: 600px; height: 35px;">
			                                <button type="submit" id="qnaSearchButton" class="btn btn-primary">검색</button>
			                            
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
            	</form>
            	
        	</section>
			<!-- /#admin_user_section -->
        </div>
        <!-- /#page-wrapper -->
	</div>
	<!-- /#admin_qna_wrapper -->
	
	<c:import url="/templates/footer.jsp" />


	<!-- QNA 질문 상세보기 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="qnaDetailQModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">QNA 질문 상세보기</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="qnaDetailQForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inquiryTitleQ">제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="inquiryTitleQ" name="inquiryTitle" type="text" 
                							readonly="readonly">
                						<input type="hidden" id="inquiryNumberQ" name="inquiryNumber">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inquiryWriterQ">작성자</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="inquiryWriterQ" name="inquiryWriter" type="text" 
                							readonly="readonly">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inquiryRegisterdateQ">작성일</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<input class="form-control" id="inquiryRegisterdateQ" name="inquiryRegisterdate" type="text"
	                						readonly="readonly">
	                				</div>
	                			</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inquiryContentQ">내용</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<div class="form-control" id="inquiryContentQ" style="height: 400px;"></div>
                					</div>
                				</div>
                			</div>
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                     <button id="qnaDetailModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    
	<!-- QNA 답변 상세보기 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="qnaDetailAModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">QNA 답변 상세보기</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="qnaDetailAForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inquiryTitleA">제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="inquiryTitleA" name="inquiryTitle" type="text" 
                							readonly="readonly">
                						<input type="hidden" id="inquiryNumberA" name="inquiryNumber">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inquiryWriterA">작성자</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="inquiryWriterA" name="inquiryWriter" type="text" 
                							readonly="readonly" value="GigaBox 관리자">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inquiryRegisterdateA">작성일</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<input class="form-control" id="inquiryRegisterdateA" name="inquiryRegisterdate" type="text"
	                						readonly="readonly">
	                				</div>
	                			</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inquiryContentA">내용</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<div class="form-control" id="inquiryContentA" style="height: 400px;"></div>
                					</div>
                				</div>
                			</div>
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	<button id="qnaDetailUpdateModalButton" type="button" class="btn btn-primary" data-dismiss="modal">수정</button>
                	<button id="qnaDetailDeleteButton" type="button" class="btn btn-warning" data-dismiss="modal">삭제</button>
                    <button id="qnaDetailModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    
    <!-- 답변 달기 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="qnaInsertModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">QNA 답변 등록</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="qnaInsertForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inqueryTitleI">제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="inquiryTitleI" name="inquiryTitle" type="text">
                						<input type="hidden" id="inquiryGroupnumberI" name="inquiryGroupnumber">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inquiryWriterI">작성자</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="inquiryWriterI" name="inquiryWriter"
                							readonly="readonly" value="GigaBox 관리자">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inquiryContentI">내용</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<textarea class="form-control summernote" id="inquiryContentI" name="inquiryContent">
                						</textarea>
                					</div>
                				</div>
                			</div>
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="qnaInsertSaveButton" type="button" class="btn btn-warning" data-dismiss="modal">저장</button>
                     <button id="qnaInsertModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    
	<!-- QNA 답변 수정 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="qnaUpdateModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">QNA 답변 수정</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="qnaUpdateForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inquiryTitleU">제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="inquiryTitleU" name="inquiryTitle" type="text">
                						<input type="hidden" id="inquiryNumberU" name="inquiryNumber">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inquiryWriterU">작성자</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="inquiryWriterU" name="inquiryWriter"
                							readonly="readonly" value="GigaBox 관리자">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="inquiryContentU">내용</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<textarea class="form-control summernote" id="inquiryContentU" name="inquiryContent">
                						</textarea>
                					</div>
                				</div>
                			</div>
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="qnaUpdateSaveButton" type="button" class="btn btn-warning" data-dismiss="modal">저장</button>
                     <button id="qnaUpdateModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

	<script>
	
	// 날짜 변환 함수
	function dateToYYYYMMDD(date) {
	    function pad(num) {
	        num = num + '';
	        return num.length < 2 ? '0' + num : num;
	    }
	    return date.getFullYear() + '-' + pad(date.getMonth()+1) + '-' + pad(date.getDate());
	}
	
	// 답변 보기 모달 띄우기
	function viewAnswer(that, event) {
		event.preventDefault();
		event.stopPropagation();
		var inquiryNumber = $(that).attr("data-num");
		var groupNumber = $(that).attr("data-groupnum");
		$.ajax({
			url: "/admin/cc/qna/qnaDetailA/" + groupNumber,
			type: "PUT",
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "PUT"
			},
			error: function() {
				alert("시스템 오류입니다.");
			},
			success: function(data) {
				
				var inquiry = data;
				
				var date = new Date(inquiry.inquiryRegisterdate);
				var dateStr = dateToYYYYMMDD(date);
				
				$("#inquiryNumberA").val(inquiry.inquiryNumber);
				$("#inquiryTitleA").val(inquiry.inquiryTitle);
				$("#inquiryContentA").html(inquiry.inquiryContent);
				$("#inquiryRegisterdateA").val(dateStr);
				
				$("#inquiryNumberU").val(inquiry.inquiryNumber);
				$("#inquiryTitleU").val(inquiry.inquiryTitle);
				$("#inquiryRegisterdateU").val(dateStr);
				
				$('#inquiryContentU').summernote({
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
				$("#inquiryContentU").summernote("code", inquiry.inquiryContent);
				
				// 모달 관리
	            $('#qnaDetailAModal').modal({
			        show: true, 
			        backdrop: 'static',
			        keyboard: true
			    });
				
			}
		});
	}
	
	// 답변 작성 모달 띄우기
	function writeAnswer(that, event) {
		event.preventDefault();
		event.stopPropagation();
		var inquiryNumber = $(that).attr("data-num");
		var groupNumber = $(that).attr("data-groupnum");
		
		// 초기화
		$("#inquiryGroupnumberI").val(groupNumber);
		$("#inquiryTitleI").val(""); 
		$('#inquiryContentI').summernote({
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
		$("#inquiryContentI").summernote("code", "");
		
		// 모달 관리
		
        $('#qnaInsertModal').modal({
	        show: true, 
	        backdrop: 'static',
	        keyboard: true
	    });
		return false;
	}
	
	$(document).ready(function() {
	
		if ('${param.searchType}' != '') {
			$("#searchType").val('${param.searchType}');
		}
		if ('${param.searchKeyword}' != '') {
			$("#searchKeyword").val('${param.searchKeyword}');
		}
		if ("${param.inquiryType}" != '') {
			$("#inquiryType").val('${param.inquiryType}');
		}
			
		$('#qnaSearchButton').on("click", function(event) {
			event.preventDefault();
			var queryString = "/admin/cc/qna/qnaMain"
				+ '${pageMaker.makeQuery(1)}'
				+ "&searchType="
				+ $("#searchType").val()
				+ "&searchKeyword=" + $('#searchKeyword').val()
				+ "&inquiryType=" + $("#inquiryType").val();
			
			self.location = queryString;
		});
		
		$("#inquiryType").change(function(e) {
			e.preventDefault();
			$("#qnaSearchButton").trigger("click");
		});
		
		
		// QNA 답변 추가 모달 저장
		$("#qnaInsertSaveButton").click(function(e) {
			e.preventDefault();
			$.ajax({
				url: "/admin/cc/qna/qnaInsertA",
				type: "POST",
				data: $("#qnaInsertForm").serialize(),
				error: function() {
					console.log("QNA 답변 추가 실패");
				},
				success: function(data) {
					if (data.result == 'SUCCESS') {
						alert("QNA 답변 추가에 성공하였습니다.");
						self.location.reload(true);
					} else {
						alert("QNA 답변 추가에 실패하였습니다.");
					}		
				}
			});
			
		});
		
		// QNA 추가 모달 닫기 버튼
		$("#qnaInsertModalCloseButton").click(function(e) {
			e.preventDefault();
			$('#qnaInsertModal').modal("hide");
		});
		
		
		// QNA 질문 세부내용 불러오기
		$('#qnaListTableBody').on('click', 'tr', function(e) {
			e.preventDefault();
			
			// 데이터 불러오기 파트
			var dataId = $(this).attr("data-id"); // inquiryNumber
			$.ajax({
				url: "/admin/cc/qna/qnaDetailQ/" + dataId,
				type: "PUT",
				headers: {
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "PUT"
				},
				error: function() {
					alert("시스템 오류입니다.");
				},
				success: function(data) {
					
					var inquiry = data.inquiry;
					var user = data.user;
					
					var date = new Date(inquiry.inquiryRegisterdate);
					var dateStr = dateToYYYYMMDD(date);
					
					$("#inquiryNumberQ").val(inquiry.inquiryNumber);
					$("#inquiryTitleQ").val(inquiry.inquiryTitle);
					$("#inquiryContentQ").html(inquiry.inquiryContent);
					$("#inquiryRegisterdateQ").val(dateStr);
					$("#inquiryWriterQ").val(user.userName + "(" + user.userId + ")");
					// 모달 관리
		            $('#qnaDetailQModal').modal({
				        show: true, 
				        backdrop: 'static',
				        keyboard: true
				    });
					
				}
			});
	    });
		
		
		// QNA 답변 상세보기 --> 수정 버튼 클릭 --> 수정 모달 생성
        $("#qnaDetailUpdateModalButton").click(function(e) {
			e.preventDefault();
			$('#qnaDetailAModal').modal("hide");
			$('#qnaUpdateModal').modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
        });
		
		// QNA 답변 수정 저장
		$("#qnaUpdateSaveButton").click(function(e) {
			e.preventDefault();
			$.ajax({
				url: "/admin/cc/qna/qnaUpdateA",
				type: "POST",
				data: $("#qnaUpdateForm").serialize(),
				error: function() {
					console.log("QNA 답변 수정 실패");
				},
				success: function(data) {
					if (data.result == 'SUCCESS') {
						alert("QNA 답변 수정에 성공하였습니다.");
						self.location.reload(true);
					} else {
						alert("QNA 답변 수정에 실패하였습니다.");
					}		
				}
			});
			
		});
		
		$("#qnaUpdateModalCloseButton").click(function(e) {
			e.preventDefault();
			$('#qnaUpdateModal').modal("hide");
			$('#qnaDetailAModal').modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
		});
		
		// QNA 답변 상세보기 모달 --> 삭제 버튼 클릭
		$("#qnaDetailDeleteButton").click(function(e) {
			e.preventDefault();
			$.ajax({
				url: "/admin/cc/qna/qnaDeleteA",
				type: "POST",
				data: { inquiryNumber: $("#inquiryNumberA").val()},
				error: function() {
					console.log("QNA 답변 삭제 실패");
				},
				success: function(data) {
					if (data.result == 'SUCCESS') {
						alert("QNA 답변 삭제에 성공하였습니다.");
						self.location.reload(true);
					} else {
						alert("QNA 답변 삭제에 실패하였습니다.");
					}		
				}
			});
			
		});
		
		
		// 상세모달 닫기
		$("#qnaDetailModalCloseButton").click(function(e) {
			e.preventDefault();
			$('#qnaDetailModal').modal("hide");
		});
		
	});
</script>	
	

</body>

</html>
