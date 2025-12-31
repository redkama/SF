<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>게시글 작성</title>

  <style>
    :root{
      --bg:#f6f7fb; --card:#ffffff; --text:#111827; --muted:#6b7280; --line:#e5e7eb;
      --primary:#2563eb; --primary-weak:#eff6ff; --danger:#ef4444; --shadow:0 10px 25px rgba(0,0,0,.06);
      --radius:14px;
    }
    *{box-sizing:border-box}
    body{margin:0;font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Noto Sans KR";background:var(--bg);color:var(--text)}
    a{color:inherit;text-decoration:none}
    .wrap{max-width:980px;margin:28px auto;padding:0 16px}
    .page-title{display:flex;align-items:flex-end;justify-content:space-between;gap:12px;margin-bottom:14px}
    .page-title h1{margin:0;font-size:22px;letter-spacing:-.3px}
    .page-title .meta{color:var(--muted);font-size:13px}

    .card{background:var(--card);border:1px solid var(--line);border-radius:var(--radius);box-shadow:var(--shadow)}
    .toolbar{padding:14px 16px;display:flex;justify-content:space-between;align-items:center;gap:10px;border-bottom:1px solid var(--line)}
    .btn{display:inline-flex;align-items:center;justify-content:center;padding:10px 12px;border-radius:10px;border:1px solid var(--line);background:#fff;font-size:13px;cursor:pointer;transition:.12s ease;gap:8px;white-space:nowrap}
    .btn:hover{transform:translateY(-1px)}
    .btn.primary{border-color:#1d4ed8;background:var(--primary);color:#fff}
    .btn.ghost{background:var(--primary-weak);border-color:#dbeafe;color:#1d4ed8}

    .body{padding:18px}
    .grid{display:grid;grid-template-columns:160px 1fr 160px 1fr;gap:12px}
    .field label{display:block;font-size:12px;color:var(--muted);margin-bottom:6px}
    .in,.sel,.ta{width:100%;border:1px solid var(--line);border-radius:10px;padding:10px;font-size:14px;outline:none;background:#fff}
    .in:focus,.sel:focus,.ta:focus{border-color:#93c5fd;box-shadow:0 0 0 3px rgba(59,130,246,.15)}
    .ta{min-height:240px;resize:vertical}
    .row2{grid-column:1/-1}

    .actions{display:flex;justify-content:space-between;gap:10px;padding:14px 16px;border-top:1px solid var(--line);flex-wrap:wrap}
    .actions .left,.actions .right{display:flex;gap:10px;flex-wrap:wrap}

    @media(max-width:840px){.grid{grid-template-columns:1fr 1fr}.row2{grid-column:1/-1}}
    @media(max-width:640px){.actions{flex-direction:column;align-items:stretch}.actions .left,.actions .right{justify-content:flex-end}}
  </style>
</head>

<body>
<div class="wrap">

  <div class="page-title">
    <div>
      <h1>게시글 작성</h1>
      <div class="meta">board_type / insurance_type / status / open_yn까지 모두 입력</div>
    </div>
    <div>
      <a class="btn" href="<c:url value='/board/list'/>">목록</a>
    </div>
  </div>

  <form method="post" action="<c:url value='/board/write'/>">
    <div class="card">
      <div class="toolbar">
        <div></div>
        <div>
          <a class="btn ghost" href="<c:url value='/board/list'/>">전체보기</a>
        </div>
      </div>

      <div class="body">
        <div class="grid">
          <div class="field">
            <label>작성자 회원ID</label>
            <input class="in" type="number" name="memberId" required/>
          </div>

          <div class="field">
            <label>게시글 유형</label>
            <select class="sel" name="boardType" required>
              <option value="INQUIRY">문의</option>
              <option value="SHARE">공유</option>
            </select>
          </div>

          <div class="field">
            <label>보험 유형</label>
            <select class="sel" name="insuranceType" required>
              <option value="AUTO">자동차</option>
              <option value="HEALTH">건강</option>
              <option value="LIFE">생명</option>
              <option value="FIRE">화재</option>
            </select>
          </div>

          <div class="field">
            <label>상태</label>
            <select class="sel" name="status" required>
              <option value="WAIT" selected>대기</option>
              <option value="ANSWERED">답변완료</option>
              <option value="CLOSED">종료</option>
            </select>
          </div>

          <div class="field">
            <label>공개 여부</label>
            <select class="sel" name="openYn" required>
              <option value="Y" selected>공개</option>
              <option value="N">비공개</option>
            </select>
          </div>

          <div class="field row2">
            <label>제목</label>
            <input class="in" type="text" name="title" maxlength="200" required/>
          </div>

          <div class="field row2">
            <label>내용</label>
            <textarea class="ta" name="content" required></textarea>
          </div>
        </div>
      </div>

      <div class="actions">
        <div class="left">
          <a class="btn" href="<c:url value='/board/list'/>">취소</a>
        </div>
        <div class="right">
          <button class="btn primary" type="submit">등록</button>
        </div>
      </div>
    </div>
  </form>

</div>
</body>
</html>
