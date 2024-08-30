<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css" rel="stylesheet" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

</head>

<body>
	<div id="wrap">
		<!-- hearder -->
		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>

		<div id="container" class="clearfix">
			<div id="aside">
				<h2>방명록</h2>
				<ul>
					<li>일반방명록</li>
					<li>ajax방명록</li>
				</ul>
			</div>
			<!-- //aside -->

			<div id="content">

				<div id="content-head" class="clearfix">
					<h3>일반방명록</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>방명록</li>
							<li class="last">일반방명록</li>
						</ul>
					</div>
				</div>
				<!-- //content-head -->




				<div id="guestbook">
					<form id="guestbookform" action="${pageContext.request.contextPath}/guestbook/insert" method="get">
						<table id="guestAdd">
							<colgroup>
								<col style="width: 70px;">
								<col>
								<col style="width: 70px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th><label class="form-text" for="input-uname">이름</label>
									</td>
									<td><input id="input-uname" type="text" name="name" value=""></td>
									<th><label class="form-text" for="input-pass">패스워드</label>
									</td>
									<td><input id="input-pass" type="password" name="password" value=""></td>
								</tr>
								<tr>
									<td colspan="4"><textarea name="content" cols="72" rows="5" value=""></textarea></td>
								</tr>
								<tr class="button-area">
									<td colspan="4" class="text-center"><button type="submit">등록</button></td>
								</tr>
							</tbody>

						</table>

						<input type="hidden" name="action" value="add">

					</form>
					<!-- //guestWrite -->

					<br>

					<div id="guestbookListArea">

						<!-- //guestRead -->
					</div>

				</div>




				<!-- //guestbook -->

			</div>
			<!-- //content  -->
		</div>
		<!-- //container  -->
		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
		<!-- //footer -->
	</div>
	<!-- //wrap -->



	<script>
	document.addEventListener('DOMContentLoaded', function() {
	    console.log("DOM 로드");
	    
	    axios({
	        method: 'get',           
	        url: '${pageContext.request.contextPath}/api/guestbook/list',
	        headers: {"Content-Type" : "application/json; charset=utf-8"}, // 전송타입
	        //params: guestbookVo,
		    // data: guestbookVo,
	        responseType: 'json' // 수신타입
	    }).then(function (response) {
	        console.log(response.data); // 수신 데이터
	        
	        for(let i = 0; i < response.data.length; i++){
	            let guestbookVo = response.data[i];
	            render(guestbookVo);
	        }
	    }).catch(function (error) {
	        console.log(error);
	    });
	    
	    
	    let guestbookForm = document.querySelector('#guestbookform');
	      guestbookForm.addEventListener('submit',function(event){
	    	 event.preventDefault();
	      
	         console.log('dddd123')
	         
	         let name = document.querySelector('#input-uname').value;
	         let password = document.querySelector('#input-pass').value;
	         let content = document.querySelector("[name = content]").value;

	         console.log(name);
	         console.log(password);
	         console.log(content);
	         
	         let guestbookVo = {
	        		 
	        		 name: name,
	        		 password: password,
	        		 content: content
	         };
	         console.log(guestbookVo);
	         
	 	    axios({
		        method: 'get',           
		        url: '${pageContext.request.contextPath}/api/guestbook/write',
		        headers: {"Content-Type" : "application/json; charset=utf-8"}, // 전송타입
		        params: guestbookVo,
		       // data: guestbookVo,
		        responseType: 'json' // 수신타입
		    }).then(function (response) {
		        console.log(response.data); // 수신 데이터
		        
		        for(let i = 0; i < response.data.length; i++){
		            let guestbookVo = response.data[i];
		            render(guestbookVo);
		        }
		    }).catch(function (error) {
		        console.log(error);
		    });
	         
	         
	         
	      });
	});

	function render(guestbookVo){
	    let listArea = document.querySelector('#guestbookListArea');
	    
	    let str = '';
	    
	    str += '<table class="guestRead">';
	    str += '   <colgroup>';
	    str += '      <col style="width: 10%;">';
	    str += '      <col style="width: 40%;">';
	    str += '      <col style="width: 40%;">';
	    str += '      <col style="width: 10%;">';
	    str += '   </colgroup>';
	    str += '   <tr>';
	    str += '      <td> '+guestbookVo.no+' </td>';
	    str += '      <td> '+guestbookVo.name+' </td>';
	    str += '      <td> '+guestbookVo.regDate+' </td>';
	    str += '      <td><a href=""> [삭제] </a></td>';
	    str += '   </tr>';
	    str += '   <tr>';
	    str += '      <td colspan="4" class="text-left">'+guestbookVo.content+'</td>';
	    str += '   </tr>';
	    str += '</table>';
	    
	    listArea.insertAdjacentHTML('beforeend', str);   
	}

	

	
	
	
		
	</script>

</body>

</html>