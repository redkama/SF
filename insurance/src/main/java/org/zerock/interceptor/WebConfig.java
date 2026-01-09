package org.zerock.interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
    	
    	// 로그인 필요 구간
        registry.addInterceptor(new AuthInterceptor())
		        .addPathPatterns("/member/**", "/board/**", "/comment/**")
		        .excludePathPatterns(
		                "/member/login", "/member/join", "/member/logout",    
		                "/board/list", "/board/view", "/board/detail");
        
        // 관리자 전용 구간
        registry.addInterceptor(new AdminInterceptor())
        		.addPathPatterns("/member/listMem", "/member/editMemAdmin", "/member/deleteMemAdmin");

    }
}
