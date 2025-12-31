package org.zerock.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AuthInterceptor implements HandlerInterceptor {
	
	@Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {

        HttpSession session = req.getSession(false);
        Object loginMember = (session == null) ? null : session.getAttribute("loginMember");

        if (loginMember == null) {
            res.sendRedirect(req.getContextPath() + "/member/login");
            return false;
        }
        return true;
    }

}
