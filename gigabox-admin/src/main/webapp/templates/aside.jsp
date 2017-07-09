<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

		<!-- aside -->
        <aside id="admin_main_aside">
            <nav id="admin_main_aside_nav" class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        
                        <li>
                            <a href="/admin/index"><i class="fa fa-home fa-fw"></i> HOME</a>
                        </li>
                        <li>
                            <a href="/admin/movie/movieMain"><i class="fa fa-video-camera fa-fw"></i> 영화 관리</a>
                        </li>
                        <li>
                            <a href="/admin/cinema/cinemaMain"><i class="fa fa-building-o fa-fw"></i> 영화관 관리</a>
                        </li>
                        <li>
                            <a href="/admin/reservation/reservationMain"><i class="fa fa-calendar fa-fw"></i> 예매 관리</a>
                        </li>
                        <li>
                            <a href="/admin/user/userMain"><i class="fa fa-user fa-fw"></i> 회원 관리</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-question-circle fa-fw"></i> 고객센터 관리<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="/admin/cc/notice/noticeMain">공지사항 관리</a>
                                </li>
                                <li>
                                    <a href="/admin/cc/faq/faqMain">자주 묻는 질문 관리</a>
                                </li>
                                <li>
                                    <a href="/admin/cc/qna/qnaMain">문의 게시판 관리</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> 통계<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="/admin/stat/userStat">회원 통계</a>
                                </li>
                                <li>
                                    <a href="/admin/stat/branchStat">지점별 통계</a>
                                </li>
                                <li>
                                    <a href="/admin/stat/movieStat">영화별 통계</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </nav>
            <!-- /.navbar-static-side -->
        </aside>
        <!-- aside -->