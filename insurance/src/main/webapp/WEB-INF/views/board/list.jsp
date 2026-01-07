<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>보험 문의/공유 게시판 - INS 커뮤니티</title>

  <link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>" />
  <link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>" />
</head>

<body class="board board-list">
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<c:set var="me" value="${sessionScope.loginMember}" />

<div class="wrap-wide">

  <div class="page-title">
    <div>
      <h1>보험 문의/공유 게시판</h1>
      <div class="meta">
        총 <strong><c:out value="${totalCount}"/></strong>건
      </div>
    </div>

    <div class="top-actions">
      <a class="btn primary" href="<c:url value='/board/write'/>">+ 글쓰기</a>
    </div>
  </div>

  <div class="card">

    <div class="toolbar">
      <div class="left">
        <a class="btn ghost" href="<c:url value='/board/list'/>">전체보기</a>

        <c:if test="${not empty search.keyword}">
          <span class="badge b-ins">키워드: <c:out value="${search.keyword}"/></span>
        </c:if>
      </div>

      <div class="right">
        <span class="badge b-ins">페이지 <c:out value="${page.page}"/> / <c:out value="${page.totalPage}"/></span>
      </div>
    </div>

    <form method="get" action="<c:url value='/board/list'/>">
      <div class="filters">

        <select class="select" name="boardType">
          <option value="">전체 유형</option>
          <option value="INQUIRY" <c:if test="${search.boardType eq 'INQUIRY'}">selected</c:if>>문의</option>
          <option value="SHARE"   <c:if test="${search.boardType eq 'SHARE'}">selected</c:if>>공유</option>
        </select>

        <select class="select" name="insuranceType">
          <option value="">전체 보험</option>
          <option value="AUTO"   <c:if test="${search.insuranceType eq 'AUTO'}">selected</c:if>>자동차</option>
          <option value="HEALTH" <c:if test="${search.insuranceType eq 'HEALTH'}">selected</c:if>>건강</option>
          <option value="LIFE"   <c:if test="${search.insuranceType eq 'LIFE'}">selected</c:if>>생명</option>
          <option value="FIRE"   <c:if test="${search.insuranceType eq 'FIRE'}">selected</c:if>>화재</option>
        </select>

        <select class="select" name="status">
          <option value="">전체 상태</option>
          <option value="WAIT"     <c:if test="${search.status eq 'WAIT'}">selected</c:if>>대기</option>
          <option value="ANSWERED" <c:if test="${search.status eq 'ANSWERED'}">selected</c:if>>답변완료</option>
          <option value="CLOSED"   <c:if test="${search.status eq 'CLOSED'}">selected</c:if>>종료</option>
        </select>

        <select class="select" name="openYn">
          <option value="">공개/비공개</option>
          <option value="Y" <c:if test="${search.openYn eq 'Y'}">selected</c:if>>공개</option>
          <option value="N" <c:if test="${search.openYn eq 'N'}">selected</c:if>>비공개</option>
        </select>

        <input class="input" type="text" name="keyword"
               value="<c:out value='${search.keyword}'/>"
               placeholder="제목/내용 키워드 검색" />

        <div style="display:flex; gap:10px; justify-content:flex-end;">
          <button class="btn" type="submit">검색</button>
          <a class="btn" href="<c:url value='/board/list'/>">초기화</a>
        </div>

        <input type="hidden" name="page" value="<c:out value='${page.page}'/>" />
        <input type="hidden" name="size" value="<c:out value='${page.size}'/>" />
      </div>

      <div class="hint">
        * 필터 : 문의유형(문의, 공유) / 보험유형(자동차, 건강, 생명, 화재) / 상태(대기, 답변완료, 종료) / 공개여부(공개, 비공개)
      </div>
    </form>

    <table>
      <thead>
      <tr>
        <th class="col-id">ID</th>
        <th>제목 / 분류</th>
        <th class="col-meta">작성자</th>
        <th class="col-stats">조회/댓글</th>
        <th class="col-meta">작성일</th>
      </tr>
      </thead>

      <tbody>
      <c:choose>
        <c:when test="${empty list}">
          <tr><td colspan="5" class="empty">등록된 게시글이 없습니다.</td></tr>
        </c:when>

        <c:otherwise>
          <c:forEach var="b" items="${list}">
          <c:set var="canView"
       		  value="${b.openYn eq 'Y'
                 || (not empty me
                     && (me.role eq 'ADMIN'
                         || me.role eq 'COUNSELOR'
                         || me.memberId eq b.memberId))}" />
            <tr>
              <td class="col-id">#<c:out value="${b.boardId}"/></td>

              <td>
        	   <c:choose>
      		    <c:when test="${canView}">
              	  <a class="title-link" href="<c:url value='/board/view'>
                    <c:param name='boardId' value='${b.boardId}'/>
                    <c:if test='${not empty search.boardType}'><c:param name='boardType' value='${search.boardType}'/></c:if>
                    <c:if test='${not empty search.insuranceType}'><c:param name='insuranceType' value='${search.insuranceType}'/></c:if>
                    <c:if test='${not empty search.status}'><c:param name='status' value='${search.status}'/></c:if>
                    <c:if test='${not empty search.openYn}'><c:param name='openYn' value='${search.openYn}'/></c:if>
                    <c:if test='${not empty search.keyword}'><c:param name='keyword' value='${search.keyword}'/></c:if>
                    <c:param name='page' value='${page.page}'/>
                    <c:param name='size' value='${page.size}'/>
                    </c:url>">
                    <c:out value="${b.title}"/>
                  </a>
                </c:when>
                
                <c:otherwise>
		          <!-- 클릭 불가(권한 없음) -->
		          <span class="title-link is-locked"
		                onclick="alert('비공개 글은 작성자/담당자/관리자만 열람할 수 있습니다.');">
		            🔒 비공개 글입니다
		          </span>
		        </c:otherwise>
		      </c:choose>
                

                <div class="subline">
                  <c:choose>
                    <c:when test="${b.boardType eq 'INQUIRY'}"><span class="badge b-type-inq">문의</span></c:when>
                    <c:otherwise><span class="badge b-type-share">공유</span></c:otherwise>
                  </c:choose>

                  <span class="badge b-ins"><c:out value="${b.insuranceType}"/></span>

                  <c:choose>
                    <c:when test="${b.status eq 'WAIT'}"><span class="badge b-wait">대기</span></c:when>
                    <c:when test="${b.status eq 'ANSWERED'}"><span class="badge b-answered">답변완료</span></c:when>
                    <c:otherwise><span class="badge b-closed">종료</span></c:otherwise>
                  </c:choose>
                  
                  <c:choose>
                    <c:when test="${b.openYn eq 'N'}"><span class="badge b-private">비공개</span></c:when>
                    <c:otherwise><span class="badge b-open">공개</span></c:otherwise>
                  </c:choose>
                </div>
              </td>

              <td class="col-meta">
                <div style="font-weight:600;">
                  <c:out value="${empty b.writerName ? '익명' : b.writerName}"/>
                </div>
                <div style="color:var(--muted); font-size:12px; margin-top:4px;">
                  작성자ID: <span class="mono"><c:out value="${b.memberId}"/></span>
                </div>
              </td>

              <td class="col-stats">
                <div>조회 <strong><c:out value="${b.viewCnt}"/></strong></div>
                <div style="margin-top:4px;">댓글 <strong><c:out value="${b.commentCount}"/></strong></div>
              </td>

              <td class="col-meta">
                <div><c:out value="${b.createdDate}"/></div>
              </td>
            </tr>
          </c:forEach>
        </c:otherwise>
      </c:choose>
      </tbody>
    </table>

    <div class="paging">

      <a class="page-link <c:if test='${not page.hasPrev}'>disabled</c:if>"
         href="<c:url value='/board/list'>
            <c:if test='${not empty search.boardType}'><c:param name='boardType' value='${search.boardType}'/></c:if>
            <c:if test='${not empty search.insuranceType}'><c:param name='insuranceType' value='${search.insuranceType}'/></c:if>
            <c:if test='${not empty search.status}'><c:param name='status' value='${search.status}'/></c:if>
            <c:if test='${not empty search.openYn}'><c:param name='openYn' value='${search.openYn}'/></c:if>
            <c:if test='${not empty search.keyword}'><c:param name='keyword' value='${search.keyword}'/></c:if>
            <c:param name='page' value='${page.startPage - 1}'/>
            <c:param name='size' value='${page.size}'/>
         </c:url>">Prev</a>

      <c:forEach var="p" begin="${page.startPage}" end="${page.endPage}">
        <a class="page-link <c:if test='${p eq page.page}'>active</c:if>"
           href="<c:url value='/board/list'>
              <c:if test='${not empty search.boardType}'><c:param name='boardType' value='${search.boardType}'/></c:if>
              <c:if test='${not empty search.insuranceType}'><c:param name='insuranceType' value='${search.insuranceType}'/></c:if>
              <c:if test='${not empty search.status}'><c:param name='status' value='${search.status}'/></c:if>
              <c:if test='${not empty search.openYn}'><c:param name='openYn' value='${search.openYn}'/></c:if>
              <c:if test='${not empty search.keyword}'><c:param name='keyword' value='${search.keyword}'/></c:if>
              <c:param name='page' value='${p}'/>
              <c:param name='size' value='${page.size}'/>
           </c:url>"><c:out value="${p}"/></a>
      </c:forEach>

      <a class="page-link <c:if test='${not page.hasNext}'>disabled</c:if>"
         href="<c:url value='/board/list'>
            <c:if test='${not empty search.boardType}'><c:param name='boardType' value='${search.boardType}'/></c:if>
            <c:if test='${not empty search.insuranceType}'><c:param name='insuranceType' value='${search.insuranceType}'/></c:if>
            <c:if test='${not empty search.status}'><c:param name='status' value='${search.status}'/></c:if>
            <c:if test='${not empty search.openYn}'><c:param name='openYn' value='${search.openYn}'/></c:if>
            <c:if test='${not empty search.keyword}'><c:param name='keyword' value='${search.keyword}'/></c:if>
            <c:param name='page' value='${page.endPage + 1}'/>
            <c:param name='size' value='${page.size}'/>
         </c:url>">Next</a>
    </div>

  </div>
</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>
