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

<a href="/todo/register" class="d-flex justify-content-end mb-3">
	<button type="button" class="btn btn-primary">등록</button>
</a>
<table class="table">
  <thead>
    <tr>
      <th scope="col">Id</th>
      <th scope="col">Title</th>
      <th scope="col">Description</th>
      <th scope="col">Done</th>
      <th scope="col">Created Date</th>
    </tr>
  </thead>
  <tbody>
  	<c:forEach var="todo" items="${todoList}">
	    <tr>
	      <td><c:out value="${todo.id}"></c:out></td>
	      <td>
	      	<a href="/todo/read/${todo.id}">
	      		<c:out value="${todo.title}"></c:out>
	      	</a>
	      </td>
	      <td><c:out value="${todo.description}"></c:out></td>
	      <td><c:out value="${todo.done}"></c:out></td>
	      <td><c:out value="${todo.createdDate}"></c:out></td>
	    </tr>
  	</c:forEach>
  </tbody>
</table>
</body>
</html>