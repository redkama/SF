package org.zerock.service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.TodoDTO;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class TodoServiceTest {

	@Autowired
	private TodoService todoService;
	
	@Test
	void testInsert() {
		TodoDTO dto = TodoDTO.builder()
				.title("홍길북")
				.description("test4@naver.com")
				.done(true)
				.build();
		
		todoService.insert(dto);

		log.info("생성된 PK : " + dto.getId());
		
		assertNotNull(dto.getId());
		
	}
	
//	@Test
//	void testList() {
//		memberService.getList().forEach(member-> log.info(member));
//	}
//	
//	@Test
//	void testMemberById() {
//		MemberDTO dto = memberService.memberById(3);
//		
//		log.info(dto);
//	}
//	
//	@Test
//	void testUpdate() {
//		MemberDTO dto = MemberDTO.builder()
//				.name("홍수정")
//				.password("1111")
//				.email("aaa@test.com")
//				.mno(3)
//				.build();
//
//		memberService.update(dto);
//		
//		log.info(memberService.memberById(3));
//		
//	}
//	
//	@Test
//	void testDelete() {
//		memberService.delete(3);
//	}

}
