<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>회원정보 리스트 - INS 커뮤니티</title>

  <!-- ✅ 공용 + member 전용 -->
  <link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>" />
  <link rel="stylesheet" href="<c:url value='/resources/css/member.css'/>" />
</head>

<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="wrap-wide">

  <div class="page-title">
    <div>
      <div class="brand">보험 문의/공유 게시판</div>
      <div class="crumb">관리자 &gt; 회원정보 리스트 (총 <strong><c:out value="${totalCount}"/></strong>명)</div>
    </div>
    <div class="top-actions">
      <a class="btn ghost" href="<c:url value='/board/list'/>">게시판으로</a>
    </div>
  </div>

  <div class="card">
    <div class="card-hd">
      <div>
        <h1 class="title">회원정보 리스트</h1>
        <p class="sub">회원 정보를 조회합니다. (비밀번호는 표시하지 않습니다)</p>
      </div>
    </div>

    <div class="card-bd">

      <c:if test="${not empty error}">
        <div class="msg err"><c:out value="${error}"/></div>
      </c:if>
      <c:if test="${not empty msg}">
        <div class="msg ok"><c:out value="${msg}"/></div>
      </c:if>

      <div class="table-scroll">
        <table>
          <thead>
          <tr>
            <th style="width:90px;">회원ID</th>
            <th style="width:160px;">로그인ID</th>
            <th style="width:140px;">이름</th>
            <th style="width:120px;">권한</th>
            <th>이메일</th>
            <th style="width:120px;">사용여부</th>
            <th style="width:180px;">가입일</th>
          </tr>
          </thead>

          <tbody>
          <c:choose>
            <c:when test="${empty members}">
              <tr><td colspan="7" class="empty">회원 데이터가 없습니다.</td></tr>
            </c:when>

            <c:otherwise>
              <c:forEach var="m" items="${members}">
                <tr>
                  <td class="mono">#<c:out value="${m.memberId}"/></td>

                  <td class="mono">
                    <a class="link" href="<c:url value='/member/editMemAdmin'><c:param name='memberId' value='${m.memberId}'/></c:url>">
                      <c:out value="${m.loginId}"/>
                    </a>
                  </td>

                  <td>
                    <a href="<c:url value='/member/editMemAdmin'><c:param name='memberId' value='${m.memberId}'/></c:url>">
                      <strong><c:out value="${m.name}"/></strong>
                    </a>
                  </td>

                  <td>
                    <c:choose>
                      <c:when test="${m.role eq 'ADMIN'}"><span class="badge b-admin">ADMIN</span></c:when>
                      <c:when test="${m.role eq 'COUNSELOR'}"><span class="badge b-counselor">COUNSELOR</span></c:when>
                      <c:otherwise><span class="badge b-user">USER</span></c:otherwise>
                    </c:choose>
                  </td>

                  <td><c:out value="${m.email}"/></td>

                  <td>
                    <c:choose>
                      <c:when test="${m.useYn eq 'Y'}"><span class="badge b-usey">Y</span></c:when>
                      <c:otherwise><span class="badge b-usen">N</span></c:otherwise>
                    </c:choose>
                  </td>

                  <td class="mono"><c:out value="${m.createdAt}"/></td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
          </tbody>
        </table>
      </div>
    </div>
  </div>

</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>
