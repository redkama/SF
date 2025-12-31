<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>보험 문의/공유 게시판</title>

  <!-- 실무에서는 공통 css 분리 권장: /resources/css/common.css, /resources/css/board.css -->
  <style>
    :root{
      --bg:#f6f7fb;
      --card:#ffffff;
      --text:#111827;
      --muted:#6b7280;
      --line:#e5e7eb;
      --primary:#2563eb;
      --primary-weak:#eff6ff;
      --danger:#ef4444;
      --success:#10b981;
      --warning:#f59e0b;
      --shadow: 0 10px 25px rgba(0,0,0,.06);
      --radius: 14px;
      --mono: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono","Courier New", monospace;
    }
    *{box-sizing:border-box}
    body{
      margin:0;
      font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Noto Sans KR",Helvetica,Arial,"Apple Color Emoji","Segoe UI Emoji";
      background: var(--bg);
      color: var(--text);
    }
    a{color:inherit; text-decoration:none}
    .wrap{max-width: 1100px; margin: 28px auto; padding: 0 16px;}
    .page-title{
      display:flex; align-items:flex-end; justify-content:space-between; gap:12px;
      margin-bottom: 14px;
    }
    .page-title h1{
      font-size: 22px; margin:0;
      letter-spacing:-.3px;
    }
    .page-title .meta{
      color: var(--muted);
      font-size: 13px;
    }

    .card{
      background: var(--card);
      border: 1px solid var(--line);
      border-radius: var(--radius);
      box-shadow: var(--shadow);
    }
    .toolbar{
      padding: 14px 16px;
      display:flex; align-items:center; justify-content:space-between; gap:12px;
      border-bottom:1px solid var(--line);
    }
    .toolbar .left{
      display:flex; align-items:center; gap:10px; flex-wrap:wrap;
    }
    .toolbar .right{
      display:flex; align-items:center; gap:10px;
    }

    .btn{
      display:inline-flex; align-items:center; justify-content:center;
      padding: 10px 12px;
      border-radius: 10px;
      border: 1px solid var(--line);
      background: #fff;
      font-size: 13px;
      cursor:pointer;
      transition: .12s ease;
      gap:8px;
      white-space:nowrap;
    }
    .btn:hover{transform: translateY(-1px)}
    .btn.primary{
      border-color: #1d4ed8;
      background: var(--primary);
      color:#fff;
    }
    .btn.ghost{
      background: var(--primary-weak);
      border-color: #dbeafe;
      color: #1d4ed8;
    }

    .filters{
      padding: 14px 16px;
      display:grid;
      grid-template-columns: 160px 160px 160px 140px 1fr 110px;
      gap:10px;
      border-bottom:1px solid var(--line);
    }
    .filters label{display:none}
    .input, .select{
      width:100%;
      padding:10px 10px;
      border-radius: 10px;
      border:1px solid var(--line);
      background:#fff;
      font-size:13px;
      outline:none;
    }
    .input:focus, .select:focus{
      border-color:#93c5fd;
      box-shadow: 0 0 0 3px rgba(59,130,246,.15);
    }
    .hint{
      padding: 0 16px 12px 16px;
      color: var(--muted);
      font-size: 12px;
    }

    table{
      width:100%;
      border-collapse: collapse;
    }
    thead th{
      text-align:left;
      padding: 12px 16px;
      font-size: 12px;
      color: var(--muted);
      border-bottom:1px solid var(--line);
      background: #fafafa;
    }
    tbody td{
      padding: 14px 16px;
      border-bottom:1px solid var(--line);
      font-size: 14px;
      vertical-align: middle;
    }
    tbody tr:hover{background:#fbfdff}
    .col-id{width:86px; color:var(--muted); font-family:var(--mono); font-size:12px}
    .col-meta{width:220px; color:var(--muted); font-size:13px}
    .col-stats{width:120px; color:var(--muted); font-size:13px}
    .title{
      font-weight: 600;
      letter-spacing:-.2px;
      line-height:1.3;
    }
    .sub{
      margin-top:6px;
      color: var(--muted);
      font-size: 12px;
      display:flex; gap:10px; flex-wrap:wrap;
    }

    .badge{
      display:inline-flex;
      align-items:center;
      padding: 4px 8px;
      border-radius: 999px;
      font-size: 11px;
      font-weight: 600;
      border: 1px solid transparent;
      gap:6px;
      white-space:nowrap;
    }
    .b-type-inq{background:#fff7ed; color:#9a3412; border-color:#fed7aa;}
    .b-type-share{background:#f0fdf4; color:#166534; border-color:#bbf7d0;}
    .b-ins{background:#f1f5f9; color:#334155; border-color:#e2e8f0;}
    .b-wait{background:#fffbeb; color:#92400e; border-color:#fde68a;}
    .b-answered{background:#ecfdf5; color:#065f46; border-color:#a7f3d0;}
    .b-closed{background:#f3f4f6; color:#374151; border-color:#e5e7eb;}
    .b-private{background:#fef2f2; color:#991b1b; border-color:#fecaca;}

    .empty{
      padding: 40px 16px;
      text-align:center;
      color: var(--muted);
    }

    .paging{
      display:flex; align-items:center; justify-content:center;
      gap:6px;
      padding: 14px 16px;
    }
    .page-link{
      min-width: 36px;
      height: 36px;
      display:inline-flex;
      align-items:center;
      justify-content:center;
      border-radius: 10px;
      border: 1px solid var(--line);
      background:#fff;
      font-size: 13px;
      color:#374151;
      padding: 0 10px;
    }
    .page-link:hover{background:#f9fafb}
    .page-link.active{
      background: var(--primary);
      color:#fff;
      border-color:#1d4ed8;
      font-weight:700;
    }
    .page-link.disabled{
      opacity:.45;
      pointer-events:none;
    }

    @media (max-width: 980px){
      .filters{grid-template-columns: 1fr 1fr 1fr; }
    }
    @media (max-width: 560px){
      .page-title{flex-direction:column; align-items:flex-start}
      .filters{grid-template-columns: 1fr 1fr; }
      thead{display:none}
      table, tbody, tr, td{display:block; width:100%}
      tbody td{border-bottom:none; padding: 10px 16px}
      tbody tr{border-bottom:1px solid var(--line)}
      .col-id, .col-meta, .col-stats{width:auto}
    }
  </style>
</head>

<body>
<div class="wrap">

  <!-- 상단 타이틀 -->
  <div class="page-title">
    <div>
      <h1>보험 문의/공유 게시판</h1>
      <div class="meta">
	    총 <strong><c:out value="${totalCount}"/></strong>건
	  </div>
    </div>

    <div>
      <a class="btn primary" href="<c:url value='/board/write'/>">+ 글쓰기</a>
    </div>
  </div>

  <div class="card">

    <!-- 툴바 -->
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

    <!-- 검색/필터 -->
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

        <div style="display:flex; gap:10px;">
          <button class="btn" type="submit">검색</button>
          <a class="btn" href="<c:url value='/board/list'/>">초기화</a>
        </div>

        <!-- 페이징 유지용 (컨트롤러/DTO 설계에 맞춰 조정) -->
        <input type="hidden" name="page" value="<c:out value='${page.page}'/>" />
        <input type="hidden" name="size" value="<c:out value='${page.size}'/>" />
      </div>

      <div class="hint">
        * 실무에서는 “필터 + 키워드 + 페이징 파라미터 유지”가 기본. 목록 클릭 후 뒤로가도 조건이 유지되게 구성합니다.
      </div>
    </form>

    <!-- 목록 테이블 -->
    <table>
      <thead>
      <tr>
        <th class="col-id">ID</th>
        <th>제목</th>
        <th class="col-meta">작성자 / 분류</th>
        <th class="col-stats">조회/댓글</th>
        <th class="col-meta">작성일</th>
      </tr>
      </thead>

      <tbody>
      <c:choose>
        <c:when test="${empty list}">
          <tr>
            <td colspan="5" class="empty">
              등록된 게시글이 없습니다.
            </td>
          </tr>
        </c:when>

        <c:otherwise>
          <c:forEach var="b" items="${list}">
            <tr>
              <td class="col-id">#<c:out value="${b.boardId}"/></td>

              <td>
                <a class="title" href="<c:url value='/board/view'>
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

                <div class="sub">
                  <!-- 공개 여부 -->
                  <c:if test="${b.openYn eq 'N'}">
                    <span class="badge b-private">비공개</span>
                  </c:if>

                  <!-- 게시글 유형 -->
                  <c:choose>
                    <c:when test="${b.boardType eq 'INQUIRY'}">
                      <span class="badge b-type-inq">문의</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge b-type-share">공유</span>
                    </c:otherwise>
                  </c:choose>

                  <!-- 보험 유형 -->
                  <span class="badge b-ins">
                    <c:out value="${b.insuranceType}"/>
                  </span>

                  <!-- 상태 -->
                  <c:choose>
                    <c:when test="${b.status eq 'WAIT'}">
                      <span class="badge b-wait">대기</span>
                    </c:when>
                    <c:when test="${b.status eq 'ANSWERED'}">
                      <span class="badge b-answered">답변완료</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge b-closed">종료</span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </td>

              <td class="col-meta">
                <div style="font-weight:600;">
                  <c:out value="${empty b.writerName ? '익명' : b.writerName}"/>
                </div>
                <div style="color:var(--muted); font-size:12px; margin-top:4px;">
                  작성자ID: <span style="font-family:var(--mono)"><c:out value="${b.memberId}"/></span>
                </div>
              </td>

              <td class="col-stats">
                <div>조회 <strong><c:out value="${b.viewCnt}"/></strong></div>
                <div style="margin-top:4px;">댓글 <strong><c:out value="${b.commentCount}"/></strong></div>
              </td>

              <td class="col-meta">
                <!-- BoardDTO에 getCreatedDate()가 있으니 그걸 우선 사용 -->
                <div><c:out value="${b.createdDate}"/></div>
              </td>
            </tr>
          </c:forEach>
        </c:otherwise>
      </c:choose>
      </tbody>
    </table>

    <!-- 페이징 -->
    <div class="paging">
      <!-- 이전 -->
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

      <!-- 페이지 번호 -->
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

      <!-- 다음 -->
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

  </div><!-- card -->

</div><!-- wrap -->
</body>
</html>
