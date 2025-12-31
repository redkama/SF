<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>게시글 수정</title>
  <style>
    :root{
      --bg:#f6f7fb;--card:#ffffff;--text:#111827;--muted:#6b7280;--line:#e5e7eb;
      --primary:#2563eb;--primary-weak:#eff6ff;--danger:#ef4444;--shadow:0 10px 25px rgba(0,0,0,.06);
      --radius:14px;--mono: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas,"Liberation Mono","Courier New", monospace;
    }
    *{box-sizing:border-box}
    body{margin:0;background:var(--bg);color:var(--text);font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Noto Sans KR",Helvetica,Arial}
    a{color:inherit;text-decoration:none}
    .wrap{max-width:980px;margin:28px auto;padding:0 16px}
    .top{display:flex;align-items:flex-end;justify-content:space-between;gap:12px;margin-bottom:14px}
    .top h1{margin:0;font-size:22px;letter-spacing:-.3px}
    .top .meta{color:var(--muted);font-size:13px}
    .card{background:var(--card);border:1px solid var(--line);border-radius:var(--radius);box-shadow:var(--shadow);overflow:hidden}
    .body{padding:18px}
    .grid{display:grid;grid-template-columns:160px 1fr 160px 1fr;gap:12px}
    .row2{grid-column:1/-1}
    .field label{display:block;font-size:12px;color:var(--muted);margin-bottom:6px}
    .in,.sel,.ta{
      width:100%;border:1px solid var(--line);border-radius:10px;padding:10px;
      font-size:14px;outline:none;background:#fff
    }
    .in:focus,.sel:focus,.ta:focus{border-color:#93c5fd;box-shadow:0 0 0 3px rgba(59,130,246,.15)}
    .ta{min-height:260px;resize:vertical;line-height:1.6}
    .ro{background:#f9fafb}
    .actions{
      display:flex;justify-content:space-between;align-items:center;gap:10px;flex-wrap:wrap;
      padding:14px 18px;border-top:1px solid var(--line);background:#fafafa
    }
    .btn{
      display:inline-flex;align-items:center;justify-content:center;gap:8px;
      padding:10px 12px;border-radius:10px;border:1px solid var(--line);
      background:#fff;font-size:13px;cursor:pointer;transition:.12s ease;white-space:nowrap
    }
    .btn:hover{transform:translateY(-1px)}
    .btn.primary{background:var(--primary);border-color:#1d4ed8;color:#fff}
    .btn.ghost{background:var(--primary-weak);border-color:#dbeafe;color:#1d4ed8}
    .btn.danger{background:var(--danger);border-color:#dc2626;color:#fff}
    @media(max-width:840px){.grid{grid-template-columns:1fr 1fr}.row2{grid-column:1/-1}}
  </style>
</head>

<body>
<div class="wrap">
  <div class="top">
    <div>
      <h1>게시글 수정</h1>
      <div class="meta">#<c:out value="${board.boardId}"/> · 조회 <c:out value="${board.viewCnt}"/></div>
    </div>
    <div style="display:flex;gap:10px;">
      <a class="btn ghost" href="<c:url value='/board/list'/>">목록</a>
      <a class="btn" href="<c:url value='/board/detail'><c:param name='boardId' value='${board.boardId}'/></c:url>">상세</a>
    </div>
  </div>

  <form method="post" action="<c:url value='/board/edit'/>">
    <input type="hidden" name="boardId" value="${board.boardId}"/>

    <div class="card">
      <div class="body">
        <div class="grid">

          <!-- 시스템/표시 -->
          <div class="field">
            <label>게시글 ID</label>
            <input class="in ro" type="text" value="${board.boardId}" readonly />
          </div>

          <div class="field">
            <label>조회수</label>
            <input class="in ro" type="text" value="${board.viewCnt}" readonly />
          </div>

          <!-- 수정 가능: 전체 -->
          <div class="field">
            <label>작성자 회원ID</label>
            <input class="in ro" type="number" name="memberId" value="${board.memberId}" readonly />
          </div>

          <div class="field">
            <label>공개 여부</label>
            <select class="sel" name="openYn" required>
              <option value="Y" <c:if test="${board.openYn eq 'Y'}">selected</c:if>>공개</option>
              <option value="N" <c:if test="${board.openYn eq 'N'}">selected</c:if>>비공개</option>
            </select>
          </div>

          <div class="field">
            <label>게시글 유형</label>
            <select class="sel" name="boardType" required>
              <option value="INQUIRY" <c:if test="${board.boardType eq 'INQUIRY'}">selected</c:if>>문의</option>
              <option value="SHARE"   <c:if test="${board.boardType eq 'SHARE'}">selected</c:if>>공유</option>
            </select>
          </div>

          <div class="field">
            <label>보험 유형</label>
            <select class="sel" name="insuranceType" required>
              <option value="AUTO"   <c:if test="${board.insuranceType eq 'AUTO'}">selected</c:if>>자동차</option>
              <option value="HEALTH" <c:if test="${board.insuranceType eq 'HEALTH'}">selected</c:if>>건강</option>
              <option value="LIFE"   <c:if test="${board.insuranceType eq 'LIFE'}">selected</c:if>>생명</option>
              <option value="FIRE"   <c:if test="${board.insuranceType eq 'FIRE'}">selected</c:if>>화재</option>
            </select>
          </div>

          <div class="field">
            <label>상태</label>
            <select class="sel" name="status" readonly>
              <option value="WAIT"     <c:if test="${board.status eq 'WAIT'}">selected</c:if>>대기</option>
              <option value="ANSWERED" <c:if test="${board.status eq 'ANSWERED'}">selected</c:if>>답변완료</option>
              <option value="CLOSED"   <c:if test="${board.status eq 'CLOSED'}">selected</c:if>>종료</option>
            </select>
          </div>

          <div class="field row2">
            <label>제목</label>
            <input class="in" type="text" name="title" value="${board.title}" maxlength="200" required />
          </div>

          <div class="field row2">
            <label>내용</label>
            <textarea class="ta" name="content" required>${board.content}</textarea>
          </div>

          <!-- 표시 -->
          <div class="field">
            <label>작성일</label>
            <input class="in ro" type="text" value="${board.createdDate}" readonly />
          </div>
          <div class="field">
            <label>수정일</label>
            <input class="in ro" type="text" value="${board.updatedAt}" readonly />
          </div>

        </div>
      </div>

      <div class="actions">
        <a class="btn" href="<c:url value='/board/detail'><c:param name='boardId' value='${board.boardId}'/></c:url>">취소</a>

        <div style="display:flex;gap:10px;flex-wrap:wrap;">
          <button class="btn primary" type="submit">저장</button>
          <button class="btn danger" type="button" onclick="submitDelete()">삭제</button>
        </div>
      </div>
    </div>
  </form>

  <form id="deleteForm" method="post" action="<c:url value='/board/delete'/>">
    <input type="hidden" name="boardId" value="${board.boardId}"/>
  </form>

  <script>
    function submitDelete(){
      if(confirm('정말 삭제하시겠습니까? 삭제 후 복구가 어렵습니다.')){
        document.getElementById('deleteForm').submit();
      }
    }
  </script>

</div>
</body>
</html>
