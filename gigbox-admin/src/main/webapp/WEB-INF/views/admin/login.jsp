<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   <!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>관리자 로그인</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">관리자 로그인</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" id="loginForm" method="post" action="/admin/loginSession">
                            <fieldset>
                            	<div class="alert alert-danger" id="errorMessage">
                            		
                            	</div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="ID" name="adminId" type="text" 
                                    	id="adminId" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Password" name="adminPw" type="password"
                                    	id="adminPw">
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="useCookie" type="checkbox">자동 로그인
                                    </label>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <button class="btn btn-lg btn-success btn-block" id="loginButton">로그인</button>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/dist/js/sb-admin-2.js"></script>

	<script type="text/javascript">
		
		function formCheck(v_item, v_name, e_item) {
			if (v_item.val().replace(/\s/g, "") == "") {
				
				e_item.text(v_name + " 입력해 주세요.");
				e_item.show();
				v_item.val("");
				v_item.focus();
				return false;
			} else {
				return true;
			}
		}
	
		$(document).ready(function() {
			
			$("#errorMessage").hide();
			$("#loginButton").click(function(e) {
				e.preventDefault();
				console.log(!formCheck($("#adminId"), "아이디를", $("#errorMessage")));
				if (!formCheck($("#adminId"), "아이디를", $("#errorMessage"))) {
					return;
				}
				if (!formCheck($("#adminPw"), "비밀번호를", $("#errorMessage"))) {
					return;
				}
				
				$.ajax({
					url: "/admin/login.do",
					type: "POST",
					data: $("#loginForm").serialize(),
					error: function() {
						$("#errorMessage").text("시스템 오류입니다.");
						$("#errorMessage").show();
					},
					success: function(resultData) {
						if (resultData.message == 'ID-MISSING') {
							$("#errorMessage").text("해당 계정이 존재하지 않습니다.");
							$("#errorMessage").show();
							$("#adminId").val("");
							$("#adminPw").val("");
							$("#adminId").focus();
						} else if (resultData.message == 'PW-WRONG') {
							$("#errorMessage").text("비밀번호가 일치하지 않습니다.");
							$("#errorMessage").show();
							$("#adminPw").val("");
							$("#adminPw").focus();
						} else if (resultData.message == 'LOGIN-SUCCESS') {
							console.log("login success!!!");
							$("#loginForm").submit();
						} else if (resultData.message == 'ERROR') {
							$("#errorMessage").text("시스템 오류입니다.");
							$("#errorMessage").show();
						}
					}
				});
			});
		});
	
	</script>

</body>

</html>
    
