<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<footer class="site-footer">
  <div class="foot-inner">
    <div>
      <div class="foot-title">INS 커뮤니티</div>
      <div>보험 문의/공유 게시판 · 학습용 프로젝트</div>
      <div class="copy">© <%= java.time.Year.now() %> INS Community. All rights reserved.</div>
    </div>

    <div class="foot-links">
      <a href="${cpath}/board/list">게시판</a>
      <a href="#" onclick="window.scrollTo({top:0,behavior:'smooth'});return false;">맨위로</a>
    </div>
  </div>
</footer>
