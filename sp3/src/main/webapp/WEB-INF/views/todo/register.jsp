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
	<h2>Todo Register</h2>
	<form action="/todo/register" method="post">
	  <div class="mb-3 mt-3">
	    <label for="title">Title:</label>
	    <input type="text" class="form-control" id="title" placeholder="Enter title" name="title">
	  </div>
	  <div class="mb-3">
	    <label for="description">Description:</label>
	    <input type="text" class="form-control" id="description" placeholder="Enter description" name="description">
	  </div>
	  <div class="mb-3">
		  <label>Done:</label>
  		  <input type="checkbox" class="form-check-input" name="done" value="true">
  		  <input type="hidden" name="done" value="false">
	   </div>

			  
	  <button type="submit" class="btn btn-primary">등록</button>
	  <button type="reset" class="btn btn-info">취소</button>
	</form>
</div>

</body>
</html>