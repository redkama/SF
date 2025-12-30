package org.zerock.aop;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j2;

@Component
@Log4j2
@Aspect
public class LogAdvice {
	
	/*
	 *  * : 반환타입  --> 반환타입은 어떤것이든 상관없음.
	 *  org.zerock.service.* : 패키지명  --> org.zerock.service 패키지 안이 대상 
	 *  *(..) : *(함수명), (..) 매개변수  --> 함수이름 상관없고, 매개변수 상관없음.
	 *  즉,
	 *  org.zerock.service 패키지안에 어떤 메소드가 등장하든 logParams() 작성한 코드가 선행적으로 동작해라!
	 */
	@Before("execution(* org.zerock.service.*.*(..))")
	public void logParams(JoinPoint jp) {
		log.info("-------------------------");
		log.info("logParams");
		
		Object[] params = jp.getArgs();
		log.info(Arrays.toString(params));
		Object target = jp.getTarget();
		log.info("target : " + target);
		
		log.info("-------------------------");
	}
	
	@Around("execution(* org.zerock.service.*.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) throws Throwable {
		log.info("------------@Around--------------");
		
		log.info("logTimes");
		
		long start = System.currentTimeMillis();
		Object result = pjp.proceed();
		long end = System.currentTimeMillis();
		
		log.info("-----------------------");
		log.info("TIME : " + (end-start));
		log.info("Method : " + pjp.getSignature().getName());
		log.info("result : " + result);
		
		return result;
	}

}
