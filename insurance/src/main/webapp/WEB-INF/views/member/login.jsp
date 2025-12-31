<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>로그인</title>

  <style>
    :root{
      --bg:#f6f7fb;
      --card:#fff;
      --text:#111827;
      --muted:#6b7280;
      --line:#e5e7eb;
      --primary:#2563eb;
      --primary2:#1d4ed8;
      --danger:#ef4444;
      --shadow:0 10px 25px rgba(0,0,0,.06);
      --radius:14px;
    }
    *{box-sizing:border-box}
    body{
      margin:0;
      background:var(--bg);
      font-family:system-ui,-apple-system,Segoe UI,Roboto,Noto Sans KR,Arial,sans-serif;
      color:var(--text);
    }
    a{color:inherit;text-decoration:none}
    .wrap{
      max-width:980px;
      margin:0 auto;
      padding:28px 16px 60px;
    }
    .topbar{
      display:flex;
      align-items:center;
      justify-content:space-between;
      margin-bottom:14px;
    }
    .brand{
      font-weight:800;
      letter-spacing:-.3px;
      font-size:18px;
    }
    .crumb{
      color:var(--muted);
      font-size:13px;
    }
    .card{
      background:var(--card);
      border:1px solid var(--line);
      border-radius:var(--radius);
      box-shadow:var(--shadow);
      overflow:hidden;
    }
    .card-hd{
      padding:18px 18px 14px;
      border-bottom:1px solid var(--line);
      display:flex;
      align-items:flex-end;
      justify-content:space-between;
      gap:10px;
    }
    .title{
      margin:0;
      font-size:18px;
      font-weight:800;
      letter-spacing:-.4px;
    }
    .sub{
      margin:6px 0 0;
      font-size:13px;
      color:var(--muted);
    }
    .card-bd{
      padding:18px;
    }

    .grid{
      display:grid;
      grid-template-columns:1fr;
      gap:12px;
      max-width:520px;
    }
    label{
      display:block;
      font-size:13px;
      color:var(--muted);
      margin:0 0 6px;
    }
    .inp{
      width:100%;
      height:44px;
      border:1px solid var(--line);
      border-radius:12px;
      padding:0 12px;
      font-size:14px;
      outline:none;
      background:#fff;
    }
    .inp:focus{
      border-color:rgba(37,99,235,.55);
      box-shadow:0 0 0 4px rgba(37,99,235,.12);
    }

    .msg{
      margin:0 0 12px;
      padding:10px 12px;
      border-radius:12px;
      border:1px solid rgba(239,68,68,.25);
      background:rgba(239,68,68,.08);
      color:#991b1b;
      font-size:13px;
    }

    .actions{
      display:flex;
      gap:10px;
      margin-top:14px;
      flex-wrap:wrap;
    }
    .btn{
      height:42px;
      padding:0 14px;
      border-radius:12px;
      border:1px solid var(--line);
      background:#fff;
      font-weight:700;
      font-size:14px;
      cursor:pointer;
      display:inline-flex;
      align-items:center;
      justify-content:center;
      gap:8px;
    }
    .btn-primary{
      border-color:transparent;
      background:var(--primary);
      color:#fff;
    }
    .btn-primary:hover{background:var(--primary2)}
    .btn-ghost{
      background:#fff;
    }
    .help{
      margin-top:12px;
      font-size:13px;
      color:var(--muted);
      max-width:520px;
      line-height:1.45;
    }
    .help a{
      color:var(--primary);
      font-weight:700;
    }
  </style>
</head>

<body>
  <div class="wrap">
    <div class="topbar">
      <div class="brand">보험 문의/공유 게시판</div>
      <div class="crumb">회원 &gt; 로그인</div>
    </div>

    <div class="card">
      <div class="card-hd">
        <div>
          <h1 class="title">로그인</h1>
          <p class="sub">로그인 후 글 작성/수정/삭제가 가능합니다.</p>
        </div>
        <a class="btn btn-ghost" href="${cpath}/board/list">목록으로</a>
      </div>

      <div class="card-bd">

        <!-- 로그인 실패 메시지 (MemberController에서 flashAttribute("error") 사용 시) -->
        <c:if test="${not empty error}">
          <div class="msg">${error}</div>
        </c:if>

        <form action="${cpath}/member/login" method="post" class="grid" autocomplete="off">
          <div>
            <label for="loginId">아이디</label>
            <input class="inp" type="text" id="loginId" name="loginId"
                   placeholder="login_id 입력" required />
          </div>

          <div>
            <label for="password">비밀번호</label>
            <input class="inp" type="password" id="password" name="password"
                   placeholder="비밀번호 입력" required />
          </div>

          <div class="actions">
            <button type="submit" class="btn btn-primary">로그인</button>
            <a class="btn btn-ghost" href="${cpath}/board/list">취소</a>
          </div>
        </form>

        <div class="help">
          아직 계정이 없으면 <a href="${cpath}/member/join">회원가입</a>을 진행해 주세요.
          <br/>
          (임시: join 화면/기능이 아직 없으면 링크는 나중에 연결해도 됩니다.)
        </div>

      </div>
    </div>
  </div>
</body>
</html>
