<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body>

<div class="container mt-3">
	<h2>Todo Read</h2>
	<form action="/todo/modify" method="post" id="form">
	  <input type="hidden" name="id" value="${todo.id}">
	  <div class="mb-3 mt-3">
	    <label for="title">Title:</label>
	    <input type="text" class="form-control" id="title" name="title" 
	    	value="<c:out value='${todo.title}' />">
	  </div>
	  <div class="mb-3">
	    <label for="description">Description:</label>
	    <input type="text" class="form-control" id="description" name="description"
	    	value="<c:out value='${todo.description}' />">
	  </div>
	  <div class="mb-3">
	    <label for="done">Done:</label>
		  
		  <input type="checkbox" class="form-check-input" id="done" name="done" 
		  		value="true" ${todo.done ? "checked" : ""}>
		  <input type="hidden" name="done" value="false">
		  
	  </div>
	  
	  <button type="submit" class="btn btn-primary update">수정</button>
	  <button type="button" class="btn btn-danger delete">삭제</button>
	  <button type="button" class="btn btn-info list">목록</button>
	</form>
</div>

<script type="text/javascript">
	const formObj = document.getElementById("form");
/* 	document.querySelector(".update").addEventListener("click", ()=> {
		formObj.action = "/todo/modify";
		formObj.method = "post";
		formObj.submit();
	}); */
	
	document.querySelector(".delete").addEventListener("click", ()=> {
		formObj.action = "/todo/delete";
		formObj.method = "post";
		formObj.submit();
	});
	
	document.querySelector(".list").addEventListener("click", ()=> {
		formObj.reset();
		formObj.action = "/todo/list";
		formObj.method = "get";
		formObj.submit();
	});
</script>


</body>
</html>