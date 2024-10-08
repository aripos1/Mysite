<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/board.css" rel="stylesheet" type="text/css">

</head>


<body>
	<div id="wrap">

		<!-- hearder -->
		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>

		<div id="container" class="clearfix">
			<div id="aside">
				<h2>게시판</h2>
				<ul>
					<li><a href="">일반게시판</a></li>
					<li><a href="">댓글게시판</a></li>
				</ul>
			</div>
			<!-- //aside -->

			<div id="content">

				<div id="content-head">
					<h3>일반게시판</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>게시판</li>
							<li class="last">일반게시판</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //content-head -->

		<div id="board">
    <div id="read">
        <form action="#" method="get">
            <!-- 작성자 -->
            <div class="form-group">
                <span class="form-text">작성자</span> <span class="form-value">${BoardVo.userName}</span>
            </div>

            <!-- 조회수 -->
            <div class="form-group">
                <span class="form-text">조회수</span> <span class="form-value">${BoardVo.hit}</span>
            </div>

            <!-- 작성일 -->
            <div class="form-group">
                <span class="form-text">작성일</span> <span class="form-value">${BoardVo.regDate}</span>
            </div>

            <!-- 제목 -->
            <div class="form-group">
                <span class="form-text">제 목</span> <span class="form-value">${BoardVo.title}</span>
            </div>

            <!-- 내용 -->
            <div id="txt-content">
                <span class="form-value">${BoardVo.content}</span>
            </div>

            <!-- 수정 버튼 (작성자에게만 보임) -->
            <c:if test="${sessionScope.authUser != null && sessionScope.authUser.no == BoardVo.userNo}">
                <a id="btn_modify" href="${pageContext.request.contextPath}/board/modifyform?no=${BoardVo.no}">수정</a>
            </c:if>
            
            <!-- 목록 버튼 -->
            <a id="btn_list" href="${pageContext.request.contextPath}/board/list">목록</a>

        </form>
						<!-- //form -->
					</div>
					<!-- //read -->
				</div>
				<!-- //board -->
			</div>
			<!-- //content  -->

		</div>
		<!-- //container  -->

		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
		<!-- //footer -->
	</div>
	<!-- //wrap -->

</body>

</html>
