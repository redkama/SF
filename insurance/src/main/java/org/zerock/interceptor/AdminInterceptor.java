package org.zerock.interceptor;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.zerock.dto.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminInterceptor implements HandlerInterceptor {
	
    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
    	
        HttpSession session = req.getSession(false);
        MemberDTO me = (session == null) ? null : (MemberDTO) session.getAttribute("loginMember");

        if (me == null) {
            saveRedirectAfterLogin(req, req.getSession(true));
            flash(req, res, "로그인이 필요합니다.");
            res.sendRedirect(req.getContextPath() + "/member/login");
            return false;
        }

        if (!"ADMIN".equals(me.getRole())) {
            flash(req, res, "접근 권한이 없습니다. (관리자 전용)");
            res.sendRedirect(req.getContextPath() + "/board/list");
            return false;
        }

        return true;
    }

    private void flash(HttpServletRequest req, HttpServletResponse res, String msg) {
        FlashMap flashMap = RequestContextUtils.getOutputFlashMap(req);
        flashMap.put("error", msg);

        FlashMapManager manager = RequestContextUtils.getFlashMapManager(req);
        if (manager != null) {
            manager.saveOutputFlashMap(flashMap, req, res);
        }
    }

    private void saveRedirectAfterLogin(HttpServletRequest req, HttpSession session) {
        // GET이면 현재 URL(+query) 저장
        if ("GET".equalsIgnoreCase(req.getMethod())) {
            String uri = req.getRequestURI(); // contextPath 포함
            String qs = req.getQueryString();
            session.setAttribute("redirectAfterLogin", (qs == null ? uri : uri + "?" + qs));
            return;
        }

        // POST면 referer(가능하면)로 저장, 아니면 목록
        String ref = req.getHeader("Referer");
        if (ref != null && !ref.isBlank()) {
            session.setAttribute("redirectAfterLogin", ref);
        } else {
            session.setAttribute("redirectAfterLogin", req.getContextPath() + "/board/list");
        }
    }
}
