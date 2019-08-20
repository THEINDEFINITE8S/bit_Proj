<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#video {
	width: 300px;
}

#renore {
	width: 100px;
}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	/* function insertComment() {
		var youtubeUrl = document.getElementById("youtubeUrl").value;
		var youtubeUrlArray = String(youtubeUrl.split('/')[3]);
		youtubeUrlArray = String(youtubeUrlArray.split('=')[1]);
		var realUrl = '<iframe width="560" height="315" src="https://www.youtube.com/embed/'+youtubeUrlArray+'" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
		var reple = document.getElementById("reple").value;
		var check = 'www.youtube.com';
		if (youtubeUrl.indexOf(check) != -1) {
			alert('등록되었습니다!');
			var table = document.getElementById("commentsList");
			var row = table.insertRow(table.rows.length);
			var cell1 = row.insertCell();
			var cell2 = row.insertCell();
			var cell3 = row.insertCell();
			var cell4 = row.insertCell();
			cell1.innerHTML = "<td>" + realUrl + "</td>"
			cell2.innerHTML = "<td>" + reple + "</td>"
			cell3.innerHTML = "<td><input type='button' value='추천'></td>"
			cell4.innerHTML = "<td><input type='button' value='비추천'></td>"
			document.getElementById("youtubeUrl").value = "";
			document.getElementById("reple").value = "";
		} else {
			alert('올바른 youtube url을 입력해주세요!');
			document.getElementById("youtubeUrl").val("").focus();
		}
	} */
	$(document).ready(function(){
		getComments("1");
	});
	
	function deleteComment(no) {
		if(confirm("정말 삭제하시겠습니까?")==true) {
	 		$.ajax({
				url : "${pageContext.request.contextPath}/artist/comments/delete/" +no,
				type : "post",
				success : function(data) {
					alert("삭제 완료!");
					getComments(replyPage);
				}
			});			
		} else {
			return;
		}
	}
	
	function updateComment(no) {
 		var content = $('#comment'+no+' #content').val().trim();
 		if (content ==="") {
			alert("댓글을 입력하세요");
			$('#comment'+no+' #content').focus();
 		} else {
			$.ajax({
				url : "${pageContext.request.contextPath}/artist/comments/update/"+no,
				type: "post",
				data : {
					'content' : content,
					'no' : no
				},
				success : function(data) {
					getComments(replyPage);
				},
			    error:function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);}
			});	
 		}
	}
	
	function editComment(no, content){
 		var date = $('#comment'+no+ '> #commentDate').text();
 		var writer = $('#comment'+no+ '> #commentWriter').text();
	    var editForm ='';
	    editForm += "<td>"+writer+"</td>";
	    editForm += "<td><input type='text' placeholder='댓글을 입력하세요' name='content' id='content'></td>";
	    editForm += "<td>"+date+"</td>";	    
	    editForm += "<td><input id='btn' type='button' onclick='updateComment("+no+")' value='수정'>";
	    editForm += "<input id='btn' type='button' onclick='getComments()' value='취소'></td>";
	    
	    $('#comment'+no).html(editForm);
	}
	
	function insertComment() {
		var content = $("#content").val().trim();
		if(content ==="") {
			alert("댓글을 입력하세요");
			$("#content").focus();
		} else {
			$.ajax({
				url: "${pageContext.request.contextPath}/artist/comments/${requestScope.artist.aid}",
				type : "POST",
				data : $("#comments").serialize(),
				success: function(data) {
					$("#content").val("");
					$("#writer").val("");
					getComments("1");
				},
				   error:function(request,status,error){
					    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					    }
				});
		}
	}
	
	var replyPage = 1;
	
	function getComments(pageInfo) {
		$.ajax({
			type: "post",
			url : "${pageContext.request.contextPath}/artist/comments/${requestScope.artist.aid}/"+pageInfo,
			success: function(data) {
				printPaging(data.paging, $("#pagination"));
				console.log(data);
				var output = "";
				for(var i in data.list) {
					output += "<tr id='comment"+data.list[i].no+"'>";
					output += "<td id='commentWriter'>"+data.list[i].writer +"</td>";
					output += "<td id='commentContent'>"+data.list[i].content +"</td>";
					output += "<td id='commentDate'>"+data.list[i].regDate +"</td>";
					output += "<td>";
					output += "<button type='button' id='btnDelete' onclick='deleteComment("+data.list[i].no+")'>삭제</button>";
					output += "<button type='button' id='btnUpdate' onclick='editComment("+data.list[i].no+",\""+data.list[i].content+"\")'>수정</button>";
					output += "</td>";
					output += "</tr>";
				}
				$("#commentsList").html(output);
			}
		});
	}
	
	var printPaging= function(pageMaker, target) {
		var str ="";
		if (pageMaker.curPage > 1 ) {
			str += str += "<li><a href='javascript:getComments(1)'> [이전] </a></li>";
		}

		for (var i = pageMaker.blockBegin; i <= pageMaker.blockEnd; i++) {
			var strClass = pageMaker.curPage == i ? 'class=active' : '';
			str += "<li "+strClass+"><a href='javascript:getComments("+i+")'>"+i+"</a></li>";
		}

		if (pageMaker.curBlock < pageMaker.blockEnd ) {
			str += "<li><a href='javascript:getComments("+pageMaker.blockEnd+")'> [다음] </a></li>";
		}
		target.html(str);
	} 
</script>
</head>
<body>
	<h1>아티스트상세페이지</h1>
	<br>
	<h1>${requestScope.artist.aname }</h1>
	<img alt="" src="${requestScope.artist.src }">

	<table border="1">
		<thead>
            <tr>
               <td colspan="2">음악</td>
               <td>앨범</td>
               <td>추천수</td>
            </tr>
		</thead>
		<tbody>
			<c:forEach items="${requestScope.musicList }" var="music">
				<tr>
					<td><img alt="" src="${music.src }" width="200px"></td>
					<td>${music.mname }</td>
					<td>${music.album }</td>
					<td>${music.mCnt }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a>로그인 후 사용가능</a>
	<br>
	<form id ="comments">
		writer : <input type="text" placeholder="작성자" name="writer" id="writer"><br>
		<!-- youtube URL : <input type="text" id="youtubeUrl" placeholder="유튜브url 입력하세요" /><br> -->
		content : <input type="text" id="content" placeholder="댓글달아라" /><br> 
		<input type="button" id = "btn" onclick="insertComment()" value="등록" />
	</form>
	<br><hr>
	
	<table border="1">
			<thead>
				<tr>
					<th>작성자
					<!-- <th>영상 -->
					<th>댓글
					<th>작성일
					<th>버튼?
				</tr>
			</thead>
			<tbody id="commentsList">
			</tbody>
		</table>
		<div id="paging">
			<ul id="pagination">
			
			</ul>
		</div>
	</div>
	
	<!-- <table border id="commentsList" width=1500px>
		<tr>
			<td id="video">영상</td>
			<td id="rep">댓글</td>
			<td colspan="2" id="renore">추천/비추천</td>
		</tr>
	</table> -->

</body>
</html>