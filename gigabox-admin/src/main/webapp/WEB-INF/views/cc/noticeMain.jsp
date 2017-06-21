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

	<div id="admin_notice_wrapper">

		<c:import url="/templates/header.jsp" />
		<c:import url="/templates/aside.jsp" />

		<div id="page-wrapper">
			<section id="admin_notice_section">
				<div class="row">
					<div class="col-lg-12">
						<h3 class="page-header">공지사항 관리 페이지</h3>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->

				<div class="row">
	                <div class="col-lg-12">
	                <article id="admin_notice_table_article">
	                    <div class="panel panel-default">
	                        <div class="panel-heading" style="height: 50px;">
	                            <i class="fa fa-info-circle fa-fw"></i> 공지사항 목록
	                            <div class="pull-right">
	                                <div class="btn-group">
	                                    <button type="button" class="btn btn-success btn-sm" id="noticeInsertModalButton">공지사항 추가</button>
	                                </div>
	                            </div>
	                        </div>
	                        <!-- /.panel-heading -->
	                        <div class="panel-body">
	                            <table width="100%" class="table table-bordered table-hover" id="noticeListTable">
	                                <thead>
	                                    <tr>
	                                        <th style="text-align: center;">번호</th>
	                                        <th style="text-align: center;">지점</th>
	                                        <th style="text-align: center;">제목</th>
	                                        <th style="text-align: center;">등록일</th>
	                                    </tr>
	                                </thead>
	                                <tbody id="noticeListTableBody">
	                                	<c:forEach var="noticeItem" items="${noticeList}">
	                                    <tr data-id="${noticeItem.noticeNumber}">
	                                        <td style="text-align: center;">${noticeItem.noticeNumber}</td>
	                                        <td style="text-align: center;">${noticeItem.noticeBranchname}</td>
	                                        <c:if test="${noticeItem.noticeStatus == '중요'}">
	                                        	<td style="text-align: left; font-weight: bold;"><span class="label label-danger">공지</span> &nbsp;${noticeItem.noticeTitle}</td>
	                                        </c:if>
	                                        <c:if test="${noticeItem.noticeStatus == '일반'}">
	                                        	<td style="text-align: left;">${noticeItem.noticeTitle}</td>
	                                        </c:if>
	                                        <td style="text-align: center;"><fmt:formatDate value="${noticeItem.noticeRegisterdate}" pattern="yyyy-MM-dd"/></td>
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
											<li><a href="/admin/cc/notice/noticeMain${pageMaker.makeQuery(pageMaker.startPage-1)}">&laquo;</a></li>
										</c:if>
			
										<c:forEach begin="${pageMaker.startPage}"
											end="${pageMaker.endPage}" var="idx">
											<li 
												<c:out value="${pageMaker.criteria.page == idx?'class=\"active\"':''}"/>>
												<a href="/admin/cc/notice/noticeMain${pageMaker.makeQuery(idx)}">${idx}</a>
											</li>
										</c:forEach>
			
										<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
											<li><a href="/admin/cc/notice/movieMain${pageMaker.makeQuery(pageMaker.endPage+1)}">&raquo;</a></li>
										</c:if>
									</ul>
									<div class="form-group input-group" style="margin: 0 auto;">
										<form id="noticeSearchForm" class="form-horizontal">
			                                <select id="searchType" name="searchType" class="form-control" style="width: 200px; height: 35px;">
			                                    <option value="t">제목</option>
			                                    <option value="c">내용</option>
			                                    <option value="tc">제목+내용</option>
			                                    <option value="b">지점</option>
			                                </select>
			                                <input type="text" id="searchKeyword" name="searchKeyword" class="form-control" placeholder="검색할 내용을 입력해주세요." style="width: 600px; height: 35px;">
			                                <button type="submit" id="noticeSearchButton" class="btn btn-primary">검색</button>
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
    <div class="modal fade" id="noticeDetailModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">공지사항 상세보기</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="noticeDetailForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="noticeTitle">제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="noticeTitle" name="noticeTitle" type="text" 
                							readonly="readonly">
                						<input type="hidden" id="noticeStatus" name="noticeStatus">
                						<input type="hidden" id="noticeNumber" name="noticeNumber">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="noticeBranchname">지점</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="noticeBranchname" name="noticeBranchname" type="text"
                							readonly="readonly">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="noticeRegisterdate">작성일</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
	                					<input class="form-control" id="noticeRegisterdate" name="noticeRegisterdate" type="text"
	                						readonly="readonly">
	                				</div>
	                			</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="noticeContent">내용</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<textarea class="form-control" id="noticeContent" name="noticeContent" 
                							readonly="readonly" rows="20"></textarea>
                					</div>
                				</div>
                			</div>
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="noticeUpdateModalButton" type="button" class="btn btn-success" data-dismiss="modal">수정</button>
                     <button id="noticeDeleteButton" type="button" class="btn btn-warning" data-dismiss="modal">삭제</button>
                     <button id="noticeDetailModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    
    <!-- 공지사항 추가 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="noticeInsertModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">공지사항 등록</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="noticeInsertForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="noticeTitleI">제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="noticeTitleI" name="noticeTitle" type="text">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="noticeBranchnameI">지점</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="noticeBranchnameI" name="noticeBranchname">
                							<option value="전체">전체</option>
                						</select>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="noticeStautsI">공지 설정</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="noticeStatusI" name="noticeStatus">
                							<option value="일반">일반</option>
                							<option value="중요">중요</option>
	                					</select>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="noticeContentI">내용</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<textarea class="form-control summernote" id="noticeContentI" name="noticeContent">
                						</textarea>
                					</div>
                				</div>
                			</div>
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="noticeInsertSaveButton" type="button" class="btn btn-warning" data-dismiss="modal">저장</button>
                     <button id="noticeInsertModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
             <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    
	<!-- 공지사항 수정 모달 -->
	<!-- Modal -->
    <div class="modal fade" id="noticeUpdateModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">공지사항 수정</h4>
                </div>
                <div class="modal-body">
                	<div class="col-lg-12">
                		<form class="form-horizontal" id="noticeUpdateForm">
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="noticeTitleU">제목</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<input class="form-control" id="noticeTitleU" name="noticeTitle" type="text">
                						<input type="hidden" id="noticeNumberU" name="noticeNumber">
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="noticeBranchnameU">지점</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="noticeBranchnameU" name="noticeBranchname">
                							<option value="전체">전체</option>
                						</select>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="noticeStatusU">공지 설정</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<select class="form-control" id="noticeStatusU" name="noticeStatus">
                							<option value="일반">일반</option>
                							<option value="중요">중요</option>
	                					</select>
                					</div>
                				</div>
                			</div>
                			<div class="form-group">
                				<label class="col-sm-2 control-label" for="noticeContentU">내용</label>
                				<div class="col-sm-10">
                					<div class="input-group col-sm-12">
                						<textarea class="form-control summernote" id="noticeContentU" name="noticeContent">
                						</textarea>
                					</div>
                				</div>
                			</div>
                		</form>
                	</div>
                </div>
                <div class="modal-footer">
                	 <button id="noticeUpdateSaveButton" type="button" class="btn btn-warning" data-dismiss="modal">저장</button>
                     <button id="noticeUpdateModalCloseButton" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
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

	
	$(document).ready(function() {
	
		// branchname 미리 주기
		$.ajax({
			url: "/admin/cc/notice/branchnameList",
			type: "PUT",
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "PUT"
			},
			error: function() {
				console.log("지점 이름 불러오기 실패");
			},
			success: function(data) {
				for (var i = 0; i < data.length; i++) {
					$("#noticeBranchnameI").append("<option value='" + data[i].branchName + "'>" + data[i].branchName + "</option>");
					$("#noticeBranchnameU").append("<option value='" + data[i].branchName + "'>" + data[i].branchName + "</option>");
				}			
			}
		});
		
		
		if ('${param.searchType}' != '') {
			$("#searchType").val('${param.searchType}');
		}
		if ('${param.searchKeyword}' != '') {
			$("#searchKeyword").val('${param.searchKeyword}');
		}
			
		$('#noticeSearchButton').on("click", function(event) {
			event.preventDefault();
			var queryString = "/admin/cc/notice/noticeMain"
				+ '${pageMaker.makeQuery(1)}'
				+ "&searchType="
				+ $("#searchType").val()
				+ "&searchKeyword=" + $('#searchKeyword').val();
			
			self.location = queryString;
		});
		
		// 공지사항 추가 
		$("#noticeInsertModalButton").click(function(e) {
			e.preventDefault();
			$("#noticeTitleI").val("");
			$('#noticeContentI').summernote({
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
			$("#noticeContentI").summernote("code", "");
			
			// 모달 관리
            $('#noticeInsertModal').modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
		});
		
		// 공지사항 추가 모달 저장
		$("#noticeInsertSaveButton").click(function(e) {
			e.preventDefault();
			$.ajax({
				url: "/admin/cc/notice/noticeInsert",
				type: "POST",
				data: $("#noticeInsertForm").serialize(),
				error: function() {
					console.log("공지사항 추가 실패");
				},
				success: function(data) {
					if (data.result == 'SUCCESS') {
						alert("공지사항 추가에 성공하였습니다.");
						self.location.reload(true);
					} else {
						alert("공지사항 추가에 실패하였습니다.");
					}		
				}
			});
			
		});
		
		// 공지사항 추가 모달 닫기 버튼
		$("#noticeInsertModalCloseButton").click(function(e) {
			e.preventDefault();
			$('#noticeInsertModal').modal("hide");
		});
		
		
		// 공지사항 세부내용 불러오기
		$('#noticeListTableBody').on('click', 'tr', function(e) {
			e.preventDefault();
			
			// 데이터 불러오기 파트
			var dataId = $(this).attr("data-id");
			$.ajax({
				url: "/admin/cc/notice/noticeDetail/" + dataId,
				type: "PUT",
				headers: {
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "PUT"
				},
				error: function() {
					alert("시스템 오류입니다.");
				},
				success: function(data) {
					
					var date = new Date(data.noticeRegisterdate);
					var dateStr = dateToYYYYMMDD(date);
					
					$("#noticeNumber").val(data.noticeNumber);
					$("#noticeBranchname").val(data.noticeBranchname);
					$("#noticeTitle").val(data.noticeTitle);
					$("#noticeContent").html(data.noticeContent);
					$("#noticeRegisterdate").val(dateStr);
					// status
					var status = data.noticeStatus;
					if (status == '중요') {
						$("#noticeTitle").prepend("<span class='label label-danger'>공지</span>").css("font-weight", "bold");
					} 
					
					// 업데이트 모달에 정보를 미리 줌.
					$("#noticeNumberU").val(data.noticeNumber);
					$("#noticeTitleU").val(data.noticeTitle);
					$("#noticeBranchnameU option").each(function() {
						if ($(this).val() == data.noticeBranchname) {
							$(this).prop("selected", true);
						}
					});
					$("#noticeStatus option").each(function() {
						if ($(this).val() == data.noticeStatus) {
							$(this).prop("selected", true);
						}
					});
					
					$('#noticeContentU').summernote({
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
					$("#noticeContentU").summernote("code", data.noticeContent);
					
					// 모달 관리
		            $('#noticeDetailModal').modal({
				        show: true, 
				        backdrop: 'static',
				        keyboard: true
				    });
					
				}
			});
			
	    });
		
		// 공지사항 수정 버튼 클릭 --> 수정 모달 생성
        $("#noticeUpdateModalButton").click(function(e) {
			e.preventDefault();
			$('#noticeDetailModal').modal("hide");
			$('#noticeUpdateModal').modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
        });
		
		// 공지사항 수정 저장
		$("#noticeUpdateSaveButton").click(function(e) {
			e.preventDefault();
			$.ajax({
				url: "/admin/cc/notice/noticeUpdate",
				type: "POST",
				data: $("#noticeUpdateForm").serialize(),
				error: function() {
					console.log("공지사항 수정 실패");
				},
				success: function(data) {
					if (data.result == 'SUCCESS') {
						alert("공지사항 수정에 성공하였습니다.");
						self.location.reload(true);
					} else {
						alert("공지사항 수정에 실패하였습니다.");
					}		
				}
			});
			
		});
		
		$("#noticeUpdateModalCloseButton").click(function(e) {
			e.preventDefault();
			$('#noticeUpdateModal').modal("hide");
			$('#noticeDetailModal').modal({
		        show: true, 
		        backdrop: 'static',
		        keyboard: true
		    });
		});
		
		// 상세보기 모달 --> 삭제 버튼 클릭
		$("#noticeDeleteButton").click(function(e) {
			e.preventDefault();
			console.log($("#noticeNumber").val());
			$.ajax({
				url: "/admin/cc/notice/noticeDelete",
				type: "POST",
				data: { noticeNumber: $("#noticeNumber").val()},
				error: function() {
					console.log("공지사항 삭제 실패");
				},
				success: function(data) {
					if (data.result == 'SUCCESS') {
						alert("공지사항 삭제에 성공하였습니다.");
						self.location.reload(true);
					} else {
						alert("공지사항 삭제에 실패하였습니다.");
					}		
				}
			});
			
		});
		
		
		// 상세모달 닫기
		$("#noticeDetailModalCloseButton").click(function(e) {
			e.preventDefault();
			$('#noticeDetailModal').modal("hide");
		});
		
	});
</script>	
	

</body>

</html>
