package org.zerock.interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new AuthInterceptor())
                .addPathPatterns("/board/write", "/board/edit", "/board/delete",
                                 "/comment/**")   // 댓글도 붙일거면 같이
                .excludePathPatterns("/member/**", "/board/list", "/board/view", "/board/detail");
    }
}
