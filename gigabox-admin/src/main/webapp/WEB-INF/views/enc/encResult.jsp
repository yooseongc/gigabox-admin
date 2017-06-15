<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>관리자 계정 암호화 결과</title>

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
                        <h3 class="panel-title">관리자 계정 암호화 결과</h3>
                    </div>
                    <div class="panel-body">
                    	<c:if test="${idCheckResult == 1}">
							<c:if test="${encCheckResult == 0}">                    
		                        <div class="alert alert-danger">
		                        	<strong>${adminId}</strong> 계정은 이미 암호화 되어 있습니다. 
		                        </div>
		                    </c:if>
							<c:if test="${encCheckResult == 1}">
								<c:if test="${encResult == 0}">                    
		                        	<div class="alert alert-danger">
		                        		<strong>${adminId}</strong> 계정 암호화에 문제가 발생하였습니다. 
		                        	</div>
		                        </c:if>
								<c:if test="${encResult == 1}">                    
		                        	<div class="alert alert-success">
		                        		<strong>${adminId}</strong> 계정 암호화에 성공하였습니다. 
		                        	</div>
		                        </c:if>
		                    </c:if>
	                    </c:if>
	                    <c:if test="${idCheckResult == 0}">
	                    	<div class="alert alert-danger">
		                        	<strong>${adminId}</strong> 계정이 존재하지 않습니다. 
		                    </div>
	                    </c:if>
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

</body>

</html>