<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<c:url var="listUrl" value="/board/list">
  <c:if test="${not empty param.boardType}"><c:param name="boardType" value="${param.boardType}" /></c:if>
  <c:if test="${not empty param.insuranceType}"><c:param name="insuranceType" value="${param.insuranceType}" /></c:if>
  <c:if test="${not empty param.status}"><c:param name="status" value="${param.status}" /></c:if>
  <c:if test="${not empty param.openYn}"><c:param name="openYn" value="${param.openYn}" /></c:if>
  <c:if test="${not empty param.keyword}"><c:param name="keyword" value="${param.keyword}" /></c:if>
  <c:if test="${not empty param.page}"><c:param name="page" value="${param.page}" /></c:if>
  <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}" /></c:if>
</c:url>

<c:url var="editUrl" value="/board/edit">
  <c:param name="boardId" value="${board.boardId}" />
  <c:if test="${not empty param.boardType}"><c:param name="boardType" value="${param.boardType}" /></c:if>
  <c:if test="${not empty param.insuranceType}"><c:param name="insuranceType" value="${param.insuranceType}" /></c:if>
  <c:if test="${not empty param.status}"><c:param name="status" value="${param.status}" /></c:if>
  <c:if test="${not empty param.openYn}"><c:param name="openYn" value="${param.openYn}" /></c:if>
  <c:if test="${not empty param.keyword}"><c:param name="keyword" value="${param.keyword}" /></c:if>
  <c:if test="${not empty param.page}"><c:param name="page" value="${param.page}" /></c:if>
  <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}" /></c:if>
</c:url>

<c:set var="keepKeys" value="boardType,insuranceType,status,openYn,keyword,page,size" />
<c:set var="me" value="${sessionScope.loginMember}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>게시글 상세 - INS 커뮤니티</title>

  <link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>" />
  <link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>" />
</head>

<body class="board board-detail">
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="wrap">

  <div class="page-title">
    <div>
      <h1>게시글 상세</h1>
      <div class="page-meta mono">ID: #<c:out value="${board.boardId}"/></div>
    </div>
    <div class="top-actions">
      <a class="btn ghost" href="${listUrl}">목록</a>
    </div>
  </div>

  <!-- ✅ 게시글 작업(작성/수정/삭제 등) 메시지만 여기서 출력 -->
  <c:if test="${not empty error}">
    <div class="msg err"><c:out value="${error}"/></div>
  </c:if>
  <c:if test="${not empty msg}">
    <div class="msg ok"><c:out value="${msg}"/></div>
  </c:if>

  <!-- 게시글 카드 -->
  <div class="card">

    <div class="card-hd is-stack">
      <div class="badges">
        <c:choose>
          <c:when test="${board.boardType eq 'INQUIRY'}"><span class="badge b-type-inq">문의</span></c:when>
          <c:otherwise><span class="badge b-type-share">공유</span></c:otherwise>
        </c:choose>

        <span class="badge b-ins"><c:out value="${board.insuranceType}"/></span>

        <c:choose>
          <c:when test="${board.status eq 'WAIT'}"><span class="badge b-wait">대기</span></c:when>
          <c:when test="${board.status eq 'ANSWERED'}"><span class="badge b-answered">답변완료</span></c:when>
          <c:otherwise><span class="badge b-closed">종료</span></c:otherwise>
        </c:choose>
        
        <c:choose>
          <c:when test="${board.openYn eq 'N'}"><span class="badge b-private">비공개</span></c:when>
          <c:otherwise><span class="badge b-open">공개</span></c:otherwise>
        </c:choose>
      </div>

      <div class="detail-title"><c:out value="${board.title}"/></div>

      <div class="meta-grid">
        <div class="meta-item"><span>작성자</span><b><c:out value="${empty board.writerName ? '익명' : board.writerName}"/></b></div>
        <div class="meta-item"><span>작성자ID</span><b class="mono"><c:out value="${board.memberId}"/></b></div>
        <div class="meta-item"><span>작성일</span><b><c:out value="${board.createdDate}"/></b></div>
        <div class="meta-item"><span>조회수</span><b><c:out value="${board.viewCnt}"/></b></div>
        <div class="meta-item"><span>수정일</span><b><c:out value="${board.updatedAt}"/></b></div>
        <%-- <div class="meta-item"><span>삭제여부</span><b><c:out value="${board.deletedYn}"/></b></div> --%>
      </div>
    </div>

    <div class="card-bd">
      <div class="content-box"><c:out value="${board.content}"/></div>
    </div>

    <div class="card-ft">
      <div class="ft-left">
        <a class="btn" href="${listUrl}">목록</a>
      </div>

      <div class="ft-right">
        <c:if test="${not empty me}">
          <c:if test="${me.role eq 'ADMIN' || me.memberId eq board.memberId}">
            <a class="btn primary" href="${editUrl}">수정</a>

            <form method="post" action="<c:url value='/board/delete'/>"
                  style="margin:0;"
                  onsubmit="return confirm('정말 삭제하시겠습니까? 삭제 후 복구가 어렵습니다.');">
              <input type="hidden" name="boardId" value="<c:out value='${board.boardId}'/>"/>

              <!-- 목록 파라미터 유지 -->
              <c:forEach var="k" items="${fn:split(keepKeys, ',')}">
                <c:if test="${not empty param[k]}">
                  <input type="hidden" name="${k}" value="<c:out value='${param[k]}'/>"/>
                </c:if>
              </c:forEach>

              <button class="btn danger" type="submit">삭제</button>
            </form>
          </c:if>
        </c:if>
      </div>
    </div>

  </div><!-- /card -->

  <!-- ✅ 댓글 카드: wrap 안에 넣어서 폭 맞춤 -->
  <div id="comments" class="card comment-card">
    <div class="card-hd">
      <div>
        <h2 class="title comment-title">댓글</h2>
        <p class="sub">총 <strong><c:out value="${commentCount}"/></strong>개</p>
      </div>
    </div>

    <div class="card-bd">

      <!-- ✅ 댓글 작업 메시지는 cmsg/cerror만 여기서 출력 -->
      <c:if test="${not empty cerror}">
        <div class="msg err"><c:out value="${cerror}"/></div>
      </c:if>
      <c:if test="${not empty cmsg}">
        <div class="msg ok"><c:out value="${cmsg}"/></div>
      </c:if>

      <!-- 댓글 작성 -->
      <c:choose>
        <c:when test="${empty me}">
          <div class="msg err">댓글 작성은 로그인 후 가능합니다.</div>
          <a class="btn primary" href="${cpath}/member/login">로그인</a>
        </c:when>

        <c:otherwise>
          <form class="comment-form" method="post" action="<c:url value='/comment/write'/>">
            <input type="hidden" name="boardId" value="<c:out value='${board.boardId}'/>"/>

            <!-- 목록 파라미터 유지 -->
            <c:forEach var="k" items="${fn:split(keepKeys, ',')}">
              <c:if test="${not empty param[k]}">
                <input type="hidden" name="${k}" value="<c:out value='${param[k]}'/>"/>
              </c:if>
            </c:forEach>

            <textarea class="ta" name="content" rows="3" placeholder="댓글을 입력하세요" required></textarea>

            <c:if test="${me.role eq 'ADMIN' || me.role eq 'COUNSELOR'}">
              <div class="comment-tools">
                <label style="display:flex; gap:8px; align-items:center; font-size:13px; color:var(--muted);">
                  <input type="checkbox" name="officialYn" value="Y" checked />
                  공식 답변 표시
                </label>

                <select class="sel" name="afterStatus" style="max-width:240px;">
                  <option value="">상태 변경 안함</option>
                  <option value="ANSWERED">답변완료로 변경</option>
                  <!-- <option value="CLOSED">종료로 변경</option> -->
                </select>
              </div>
            </c:if>
            
            <c:if test="${me.memberId eq board.memberId && me.role eq 'USER' && board.status eq 'ANSWERED'}">
              <div class="comment-tools">
                <select class="sel" name="afterStatus" style="max-width:240px;">
                  <option value="">상태 변경 안함</option>
                  <option value="WAIT">대기로 재변경</option>
                  <option value="CLOSED">종료로 변경</option>
                </select>
              </div>
            </c:if>

            <div class="comment-submit">
              <button class="btn primary" type="submit">댓글 등록</button>
            </div>
          </form>
        </c:otherwise>
      </c:choose>

      <div style="height:14px;"></div>

      <!-- 댓글 목록 -->
      <c:choose>
        <c:when test="${empty comments}">
          <div class="empty">첫 댓글을 남겨보세요.</div>
        </c:when>

        <c:otherwise>
          <c:forEach var="c" items="${comments}">
            <div class="comment-item ${c.officialYn eq 'Y' ? 'is-official' : ''}">
              <div class="comment-head">
                <div class="comment-who">
                  <strong><c:out value="${c.writerName}"/></strong>

                  <c:choose>
                    <c:when test="${c.writerRole eq 'ADMIN'}"><span class="badge b-admin">ADMIN</span></c:when>
                    <c:when test="${c.writerRole eq 'COUNSELOR'}"><span class="badge b-counselor">COUNSELOR</span></c:when>
                    <c:otherwise><span class="badge b-user">USER</span></c:otherwise>
                  </c:choose>

                  <c:if test="${c.officialYn eq 'Y'}">
                    <span class="badge b-official">공식</span>
                  </c:if>

                  <span class="comment-time"><c:out value="${c.createdAt}"/></span>
                </div>

                <div class="comment-actions">
                  <c:if test="${not empty me && me.memberId eq c.memberId}">
                    <button class="btn" type="button" onclick="toggleEdit(<c:out value='${c.commentId}'/>)">수정</button>
                  </c:if>

                  <c:if test="${not empty me && (me.memberId eq c.memberId || me.role eq 'ADMIN')}">
                    <form method="post" action="<c:url value='/comment/delete'/>" style="margin:0;"
                          onsubmit="return confirm('댓글을 삭제하시겠습니까?');">
                      <input type="hidden" name="commentId" value="<c:out value='${c.commentId}'/>"/>
                      <input type="hidden" name="boardId" value="<c:out value='${board.boardId}'/>"/>

                      <c:forEach var="k" items="${fn:split(keepKeys, ',')}">
                        <c:if test="${not empty param[k]}">
                          <input type="hidden" name="${k}" value="<c:out value='${param[k]}'/>"/>
                        </c:if>
                      </c:forEach>

                      <button class="btn danger" type="submit">삭제</button>
                    </form>
                  </c:if>
                </div>
              </div>

              <div id="cbody-${c.commentId}" class="comment-body">
                <c:out value="${c.content}"/>
              </div>

              <c:if test="${not empty me && me.memberId eq c.memberId}">
                <form id="cedit-${c.commentId}" class="comment-edit" method="post"
                      action="<c:url value='/comment/update'/>" style="display:none;">
                  <input type="hidden" name="commentId" value="<c:out value='${c.commentId}'/>"/>
                  <input type="hidden" name="boardId" value="<c:out value='${board.boardId}'/>"/>

                  <c:forEach var="k" items="${fn:split(keepKeys, ',')}">
                    <c:if test="${not empty param[k]}">
                      <input type="hidden" name="${k}" value="<c:out value='${param[k]}'/>"/>
                    </c:if>
                  </c:forEach>

                  <textarea class="ta" name="content" rows="3" required><c:out value="${c.content}"/></textarea>

                  <div class="comment-edit-actions">
                    <button class="btn" type="button" onclick="toggleEdit(<c:out value='${c.commentId}'/>)">취소</button>
                    <button class="btn primary" type="submit">저장</button>
                  </div>
                </form>
              </c:if>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>

    </div><!-- /card-bd -->
  </div><!-- /comment card -->

</div><!-- /wrap -->

<script>
  function toggleEdit(id){
    const body = document.getElementById('cbody-' + id);
    const form = document.getElementById('cedit-' + id);
    if(!form) return;
    const on = (form.style.display === 'none' || form.style.display === '');
    form.style.display = on ? 'block' : 'none';
    if(body) body.style.display = on ? 'none' : 'block';
  }

  // focus=comments 로 돌아오면 댓글 영역으로 스크롤
  (function(){
    const p = new URLSearchParams(location.search);
    if(p.get('focus') === 'comments'){
      const el = document.getElementById('comments');
      if(el) el.scrollIntoView({behavior:'smooth', block:'start'});
    }
  })();
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>
