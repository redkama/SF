<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>회원가입</title>

  <style>
    :root{
      --bg:#f6f7fb; --card:#fff; --text:#111827; --muted:#6b7280; --line:#e5e7eb;
      --primary:#2563eb; --primary2:#1d4ed8; --danger:#ef4444; --ok:#16a34a;
      --shadow:0 10px 25px rgba(0,0,0,.06); --radius:14px;
    }
    *{box-sizing:border-box}
    body{
      margin:0; background:var(--bg);
      font-family:system-ui,-apple-system,Segoe UI,Roboto,Noto Sans KR,Arial,sans-serif;
      color:var(--text);
    }
    a{color:inherit;text-decoration:none}
    .wrap{max-width:980px;margin:0 auto;padding:28px 16px 60px;}
    .topbar{display:flex;align-items:center;justify-content:space-between;margin-bottom:14px;}
    .brand{font-weight:800;letter-spacing:-.3px;font-size:18px;}
    .crumb{color:var(--muted);font-size:13px;}
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
      display:flex;align-items:flex-end;justify-content:space-between;gap:10px;
    }
    .title{margin:0;font-size:18px;font-weight:800;letter-spacing:-.4px;}
    .sub{margin:6px 0 0;font-size:13px;color:var(--muted);}
    .card-bd{padding:18px;}

    .msg{
      margin:0 0 12px; padding:10px 12px; border-radius:12px; font-size:13px;
      border:1px solid rgba(239,68,68,.25);
      background:rgba(239,68,68,.08);
      color:#991b1b;
    }
    .msg-ok{
      border-color:rgba(22,163,74,.25);
      background:rgba(22,163,74,.08);
      color:#166534;
    }

    .grid{display:grid;grid-template-columns:1fr;gap:12px;max-width:520px;}
    label{display:block;font-size:13px;color:var(--muted);margin:0 0 6px;}
    .inp{
      width:100%; height:44px; border:1px solid var(--line); border-radius:12px;
      padding:0 12px; font-size:14px; outline:none; background:#fff;
    }
    .inp:focus{
      border-color:rgba(37,99,235,.55);
      box-shadow:0 0 0 4px rgba(37,99,235,.12);
    }

    .actions{display:flex;gap:10px;margin-top:14px;flex-wrap:wrap;}
    .btn{
      height:42px; padding:0 14px; border-radius:12px;
      border:1px solid var(--line); background:#fff;
      font-weight:700; font-size:14px; cursor:pointer;
      display:inline-flex; align-items:center; justify-content:center; gap:8px;
    }
    .btn-primary{border-color:transparent;background:var(--primary);color:#fff;}
    .btn-primary:hover{background:var(--primary2)}
    .btn-ghost{background:#fff;}

    .help{margin-top:12px;font-size:13px;color:var(--muted);max-width:520px;line-height:1.45;}
    .help a{color:var(--primary);font-weight:800;}
  </style>
</head>

<body>
  <div class="wrap">
    <div class="topbar">
      <div class="brand">보험 문의/공유 게시판</div>
      <div class="crumb">회원 &gt; 회원가입</div>
    </div>

    <div class="card">
      <div class="card-hd">
        <div>
          <h1 class="title">회원가입</h1>
          <p class="sub">가입 후 로그인하면 글 작성/수정/삭제가 가능합니다.</p>
        </div>
        <a class="btn btn-ghost" href="${cpath}/board/list">목록으로</a>
      </div>

      <div class="card-bd">

        <c:if test="${not empty error}">
          <div class="msg">${error}</div>
        </c:if>

        <form action="${cpath}/member/join" method="post" class="grid" autocomplete="off">
          <div>
            <label for="loginId">아이디</label>
            <input class="inp" type="text" id="loginId" name="loginId"
                   placeholder="예) user01" required />
          </div>

          <div>
            <label for="password">비밀번호</label>
            <input class="inp" type="password" id="password" name="password"
                   placeholder="비밀번호 입력" required />
          </div>

          <div>
            <label for="name">이름</label>
            <input class="inp" type="text" id="name" name="name"
                   placeholder="이름 입력" required />
          </div>

          <div>
            <label for="email">이메일</label>
            <input class="inp" type="email" id="email" name="email"
                   placeholder="예) user01@email.com" required />
          </div>

          <!-- role은 일단 기본 USER로 가입하게 숨겨둠 (관리자/상담사 계정은 DB에서만 만들자) -->
          <input type="hidden" name="role" value="USER"/>

          <div class="actions">
            <button type="submit" class="btn btn-primary">가입하기</button>
            <a class="btn btn-ghost" href="${cpath}/member/login">로그인으로</a>
          </div>
        </form>

        <div class="help">
          이미 계정이 있다면 <a href="${cpath}/member/login">로그인</a>을 진행해 주세요.
        </div>

      </div>
    </div>
  </div>
</body>
</html>
