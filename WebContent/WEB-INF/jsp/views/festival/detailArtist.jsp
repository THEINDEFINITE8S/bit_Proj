<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	#video{
		width:300px;
	}
	#renore{
		width:100px;
	}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	function urlValidation(){
		var youtubeUrl = document.getElementById("youtubeUrl").value;
		var youtubeUrlArray = String(youtubeUrl.split('/')[3]);
		youtubeUrlArray = String(youtubeUrlArray.split('=')[1]);
		var realUrl = '<iframe width="560" height="315" src="https://www.youtube.com/embed/'+youtubeUrlArray+'" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
		var reple = document.getElementById("reple").value;
		var check = 'www.youtube.com';
		if(youtubeUrl.indexOf(check)!=-1){
			alert('등록되었습니다!');
			var table = document.getElementById("zickcamUrl");
			var row = table.insertRow(table.rows.length);
			var cell1 = row.insertCell();
			var cell2 = row.insertCell();
			var cell3 = row.insertCell();
			var cell4 = row.insertCell();
			cell1.innerHTML = "<td>"+realUrl+"</td>"
			cell2.innerHTML = "<td>"+reple+"</td>"
			cell3.innerHTML = "<td><input type='button' value='추천'></td>"
			cell4.innerHTML = "<td><input type='button' value='비추천'></td>"
			document.getElementById("youtubeUrl").value="";
			document.getElementById("reple").value="";
		}
		else{
			alert('올바른 Youtube URL을 입력해 주세요!');
			document.getElementById("youtubeUrl").focus();
		}
	}
</script>
</head>
<body>
	<h1>상세 아티스트 페이지</h1>
	<br>
	<h1>${requestScope.artist.aname }</h1>
	<img alt="" src="${requestScope.artist.src }">

		<table border="1">
			<thead>
				<tr>
					<td colspan="3">혜숙이의 추천 플레이리스트</td>
					<td>&nbsp&nbsp&nbsp&nbsp</td>
					<td colspan="5">내가 직접 만드는 플레이리스트</td>
				</tr>
				<tr>
					<td colspan="2">곡 명</td>
					<td>앨범 명</td>
					<td>  </td>
					<td colspan="2">곡 명</td>
					<td>앨범 명</td>
					<td>투표수</td>
					<td>투표하기</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${requestScope.musicList }" var="music">
					<tr>
						<td><img alt="" src="${music.src }" width="200px"></td>
						<td>${music.mname }</td>
						<td>${music.album }</td>
						<td>  </td>
						<td><img alt="" src="${music.src }" width="200px"></td>
						<td>${music.mname }</td>
						<td>${music.album }</td>
						<td>${music.mCnt }</td>
						<td><button type="submit">투표하기</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<a>로그인 하시면 댓글을 쓸 수 있습니다.</a><br>
		<form>
			<input type="text" id="youtubeUrl" placeholder="유튜브 링크를 입력하세요"/><br>
			<input type="text" id="reple" placeholder="댓글을 입력하세요"/><br>
			<input type="button" onclick="urlValidation()" value="등록"/>
		</form>
		<br>
		<table border id="zickcamUrl" width=1500px>
			<tr>
				<td id="video">영상</td>
				<td id="rep">댓글</td>
				<td colspan="2" id="renore">추천/비추천</td>
			</tr>	
		</table>
</body>
</html>