<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>상세 | 보험 문의/공유 게시판</title>

  <style>
    :root{
      --bg:#f6f7fb; --card:#ffffff; --text:#111827; --muted:#6b7280; --line:#e5e7eb;
      --primary:#2563eb; --primary-weak:#eff6ff; --danger:#ef4444; --success:#10b981; --warning:#f59e0b;
      --shadow: 0 10px 25px rgba(0,0,0,.06); --radius: 14px;
      --mono: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono","Courier New", monospace;
    }
    *{box-sizing:border-box}
    body{margin:0;font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Noto Sans KR",Helvetica,Arial;background:var(--bg);color:var(--text)}
    a{color:inherit;text-decoration:none}
    .wrap{max-width: 980px; margin: 28px auto; padding: 0 16px;}
    .page-title{display:flex; align-items:flex-end; justify-content:space-between; gap:12px; margin-bottom: 14px;}
    .page-title h1{font-size: 22px; margin:0; letter-spacing:-.3px;}
    .page-title .meta{color:var(--muted); font-size:13px}
    .card{background:var(--card); border:1px solid var(--line); border-radius:var(--radius); box-shadow:var(--shadow);}
    .hd{padding:16px; border-bottom:1px solid var(--line);}
    .bd{padding:16px;}
    .ft{padding:14px 16px; border-top:1px solid var(--line); display:flex; justify-content:space-between; gap:10px; flex-wrap:wrap;}
    .title{font-size:20px; font-weight:750; letter-spacing:-.3px; line-height:1.3; margin: 6px 0 10px;}
    .badges{display:flex; gap:8px; flex-wrap:wrap; margin-top: 8px;}
    .badge{
      display:inline-flex; align-items:center; padding: 4px 8px; border-radius:999px; font-size:11px; font-weight:700;
      border: 1px solid transparent; gap:6px; white-space:nowrap;
    }
    .b-type-inq{background:#fff7ed; color:#9a3412; border-color:#fed7aa;}
    .b-type-share{background:#f0fdf4; color:#166534; border-color:#bbf7d0;}
    .b-ins{background:#f1f5f9; color:#334155; border-color:#e2e8f0;}
    .b-wait{background:#fffbeb; color:#92400e; border-color:#fde68a;}
    .b-answered{background:#ecfdf5; color:#065f46; border-color:#a7f3d0;}
    .b-closed{background:#f3f4f6; color:#374151; border-color:#e5e7eb;}
    .b-private{background:#fef2f2; color:#991b1b; border-color:#fecaca;}

    .meta-grid{
      display:grid;
      grid-template-columns: 1fr 1fr;
      gap:10px;
      margin-top: 12px;
      color: var(--muted);
      font-size: 13px;
    }
    .meta-item{
      background:#fafafa;
      border:1px solid var(--line);
      border-radius: 12px;
      padding: 10px 12px;
      display:flex; justify-content:space-between; gap:10px;
    }
    .meta-item b{color:#374151}
    .content{
      margin-top: 14px;
      background:#ffffff;
      border:1px solid var(--line);
      border-radius: 12px;
      padding: 14px 14px;
      line-height: 1.75;
      font-size: 15px;
      white-space: pre-wrap; /* 줄바꿈 유지 */
      word-break: break-word;
    }

    .btn{
      display:inline-flex; align-items:center; justify-content:center;
      padding: 10px 12px; border-radius: 10px;
      border: 1px solid var(--line); background:#fff; font-size: 13px; cursor:pointer; transition:.12s ease; gap:8px;
    }
    .btn:hover{transform: translateY(-1px)}
    .btn.primary{border-color:#1d4ed8; background:var(--primary); color:#fff;}
    .btn.ghost{background:var(--primary-weak); border-color:#dbeafe; color:#1d4ed8;}
    .btn.danger{border-color:#fecaca; background:#fef2f2; color:#991b1b;}
    .mono{font-family:var(--mono)}
    @media(max-width:720px){
      .meta-grid{grid-template-columns: 1fr;}
    }
  </style>
</head>

<body>
<div class="wrap">

  <div class="page-title">
    <div>
      <h1>게시글 상세</h1>
      <div class="meta">ID: <span class="mono">#<c:out value="${board.boardId}"/></span></div>
    </div>

    <a class="btn ghost" href="<c:url value='/board/list'/>">목록</a>
  </div>

  <div class="card">

    <div class="hd">
      <div class="badges">
        <!-- 공개 여부 -->
        <c:if test="${board.openYn eq 'N'}">
          <span class="badge b-private">비공개</span>
        </c:if>

        <!-- 게시글 유형 -->
        <c:choose>
          <c:when test="${board.boardType eq 'INQUIRY'}">
            <span class="badge b-type-inq">문의</span>
          </c:when>
          <c:otherwise>
            <span class="badge b-type-share">공유</span>
          </c:otherwise>
        </c:choose>

        <!-- 보험 유형 -->
        <span class="badge b-ins"><c:out value="${board.insuranceType}"/></span>

        <!-- 상태 -->
        <c:choose>
          <c:when test="${board.status eq 'WAIT'}">
            <span class="badge b-wait">대기</span>
          </c:when>
          <c:when test="${board.status eq 'ANSWERED'}">
            <span class="badge b-answered">답변완료</span>
          </c:when>
          <c:otherwise>
            <span class="badge b-closed">종료</span>
          </c:otherwise>
        </c:choose>
      </div>

      <div class="title">
        <c:out value="${board.title}"/>
      </div>

      <div class="meta-grid">
        <div class="meta-item">
          <span>작성자</span>
          <b><c:out value="${empty board.writerName ? '익명' : board.writerName}"/></b>
        </div>

        <div class="meta-item">
          <span>작성자ID</span>
          <b class="mono"><c:out value="${board.memberId}"/></b>
        </div>

        <div class="meta-item">
          <span>작성일</span>
          <b><c:out value="${board.createdDate}"/></b>
        </div>

        <div class="meta-item">
          <span>조회수</span>
          <b><c:out value="${board.viewCnt}"/></b>
        </div>

        <div class="meta-item">
          <span>수정일</span>
          <b><c:out value="${board.updatedAt}"/></b>
        </div>

        <div class="meta-item">
          <span>삭제여부</span>
          <b><c:out value="${board.deletedYn}"/></b>
        </div>
      </div>
    </div>

    <div class="bd">
      <div class="content"><c:out value="${board.content}"/></div>
    </div>

    <div class="ft">
      <div style="display:flex; gap:10px; flex-wrap:wrap;">
        <a class="btn" href="<c:url value='/board/list'/>">목록</a>
      </div>

      <div style="display:flex; gap:10px; flex-wrap:wrap;">
        <a class="btn primary"
           href="<c:url value='/board/edit'><c:param name='boardId' value='${board.boardId}'/></c:url>">수정</a>

        <form method="post" action="<c:url value='/board/delete'/>"
              onsubmit="return confirm('정말 삭제하시겠습니까?');" style="margin:0;">
          <input type="hidden" name="boardId" value="<c:out value='${board.boardId}'/>"/>
          <button class="btn danger" type="submit">삭제</button>
        </form>
      </div>
    </div>

  </div>
</div>
</body>
</html>
