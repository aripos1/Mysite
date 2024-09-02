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


<style>
/* 모달창 배경 회색부분 */
.modal {
	width: 100%; /* 가로전체 */
	height: 100%; /* 세로전체 */
	display: none; /* 시작할때 숨김처리 */
	position: fixed; /* 화면에 고정 */
	left: 0; /* 왼쪽에서 0에서 시작 */
	top: 0; /* 위쪽에서 0에서 시작 */
	z-index: 999; /* 제일위에 */
	overflow: auto; /* 내용이 많으면 스크롤 생김 */
	background-color: rgba(0, 0, 0, 0.4); /* 배경이 검정색에 반투명 */
}

/* 모달창 내용 흰색부분 */
.modal .modal-content {
	width: 400px;
	margin: 100px auto; /* 상하 100px, 좌우 가운데 */
	padding: 0px 20px 20px 20px; /* 안쪽여백 */
	background-color: #ffffff; /* 배경색 흰색 */
	border: 1px solid #888888; /* 테두리 모양 색 */
}

/* 닫기버튼 */
.modal .modal-content .closeBtn {
	text-align: right;
	color: #aaaaaa;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}
</style>



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

					<!-- 모달 창 컨텐츠 -->
					<div id="myModal" class="modal">

						<div id="guestbook" class="modal-content">
							<button class="closeBtn" type="button">×</button>
							<div class="m-header">패스워드를 입력하세요</div>
							<div class="m-body">
								<input id="modalPw" class="m-password" type="password" name="password" value=""><br> 
								<input id="modalNo" class="m-no" type="text" name="no" value="">
							</div>
							<div class="m-footer">
								<button id="btnDelete" class="btnDelete" type="button">삭제</button>
							</div>
						</div>

					</div>
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
	    
	    //리스트 가져오기
	    getListRender();
		
	    //등록하기 가져오기
	    let guestbookForm = document.querySelector('#guestbookform');
	    guestbookForm.addEventListener('submit', addRender);
	    
	    //모달창 띄우기 가져오기    
	  	let listArea = document.querySelector('#guestbookListArea');
  		listArea.addEventListener("click", callModal)
	  	
  		//모달창 닫기 가져오기
		let cloaseBtn = document.querySelector(".closeBtn");
  		cloaseBtn.addEventListener("click", closeModal)
  		
  		
  		//삭제하기 가져오기
  	  	let btnDelete = document.querySelector('#btnDelete');
  			btnDelete.addEventListener("click", deleteRomove)
  	
	});

	 
	
	
	
	
	//삭제하기 
		
  	function deleteRomove() {
  			console.log("삭제")
  	        let modalNoTag = document.querySelector("#modalNo");
  	        let modalPwTag = document.querySelector("#modalPw");
  	    
  	        let no = modalNoTag.value;
  	  	    let password = modalPwTag.value;
  	        
  	        let guestVo={
  	        		no: no,
  	        		password: password
  	        		
  	        }
  	      axios({
  	        method: 'get',           // put, post, delete                   
  	        url: '${pageContext.request.contextPath}/api/guestbook/delete',
  	        headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
  	        params: guestVo,  //get방식 파라미터로 값이 전달
  	        data: guestVo,   //put, post, delete 방식 자동으로 JSON으로 변환 전달
  	    
  	        responseType: 'json' //수신타입
  	    }).then(function (response) {
  	        console.log(response.data); //수신데이타
  	        
  	        if(response.data == true){
  	        	
  	        	let deleteId = '#t-'+no; 
  	        	let removeTable= document.querySelector(deleteId);
  	        	removeTable.remove();
  	        	closeModal();
  	        	
  	        }else{
  	        	alert('비밀번호를 확인하세요');
  	        
  	        }
  	  
  	    }).catch(function (error) {
  	        console.log(error);
  	    
  	    });
   
		
	}
  			
	
	
	//모달창 닫기
	function closeModal(event){
		let modalTag = document.querySelector('#myModal');
			modalTag.style.display = 'none';
	}
	
	
	//모달창 호출 버튼 클릭 및 모달창 띄우기	
	function callModal(event){

  		if(event.target.tagName == 'BUTTON'){
  			
  			//버튼안에 태그에서 data-no 값 가져오기
  			let no = event.target.dataset.no;
  			
  			
  			//모달창의 input의 value = no
  			let txtNoTag = document.querySelector('#modalNo');
  			txtNoTag.value = no;
  			
  			// 버튼을 누르면 모달창 보이기
  			let modalTag = document.querySelector('#myModal');
  			modalTag.style.display = 'block';
	  			
  		}else{
  			
  		}
		
	}

	// 등록을 누르면 실행      
	function addRender(event){
		 
	  	 event.preventDefault();
         
         let name = document.querySelector('#input-uname').value;
         let password = document.querySelector('#input-pass').value;
         let content = document.querySelector("[name = content]").value;

         console.log(name);
         console.log(password);
         console.log(content);
         
         let guestVo = {
        		 name: name,
        		 password: password,
        		 content: content
         };
        console.log(guestVo);
 	    axios({
	        method: 'get',           
	        url: '${pageContext.request.contextPath}/api/guestbook/write',
	        headers: {"Content-Type" : "application/json; charset=utf-8"}, // 전송타입
	        params: guestVo,
	       // data: guestbookVo,
	        responseType: 'json' // 수신타입
	    }).then(function (response) {
	        console.log(response.data); // 수신 데이터
	        //댓글 위아래 선택
	      	render(response.data,'down');
	       //폼 비우기
	      	guestbookForm.reset();
	      
	    }).catch(function (error) {
	        console.log(error);
	    });
    }

    // 저장하기 end   
	      
	//리스트 가져와서 그리기
	function getListRender() {
	   axios({
	        method: 'get',           
	        url: '${pageContext.request.contextPath}/api/guestbook/list',
	        headers: {"Content-Type" : "application/json; charset=utf-8"}, // 전송타입
	        //params: guestbookVo,
		    // data: guestbookVo,
	        responseType: 'json' // 수신타입
	    }).then(function (response) {
	    	console.log(response);
	        console.log(response.data); // 수신 데이터
	        
	        for(let i = 0; i < response.data.length; i++){
	            let guestVo = response.data[i];
	            render(guestVo,'down');
	        }
	    }).catch(function (error) {
	        console.log(error);
	    });
	   
	} 
	// 리스트 가져오기 end	      
	      
	function render(guestVo, dir){
		console.log(guestVo);
		console.log(dir);
	    let listArea = document.querySelector('#guestbookListArea');
	    
	    let str = '';
	    
	    str += '<table id="t-'+guestVo.no+'" class="guestRead">';
	    str += '   <colgroup>';
	    str += '      <col style="width: 10%;">';
	    str += '      <col style="width: 40%;">';
	    str += '      <col style="width: 40%;">';
	    str += '      <col style="width: 10%;">';
	    str += '   </colgroup>';
	    str += '   <tr>';
	    str += '      <td> '+guestVo.no+' </td>';
	    str += '      <td> '+guestVo.name+' </td>';
	    str += '      <td> '+guestVo.regDate+' </td>';
	    str += '      <td><button class="callModal" type ="button" data-no="'+guestVo.no+'">삭제</button></td>';
	    str += '   </tr>';
	    str += '   <tr>';
	    str += '      <td colspan="4" class="text-left">'+guestVo.content+'</td>';
	    str += '   </tr>';
	    str += '</table>';
	    
	    if(dir =='down'){
	    	 	 listArea.insertAdjacentHTML('beforeend', str);   
	    }else if(dir =='up'){
	     	 listArea.insertAdjacentHTML('afterbegin', str);  
	    }else{
	    	 console.log('방향체크 해주세용');

	    }
	   
	}



	
	
	
		
</script>

</body>

</html>