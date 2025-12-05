package org.zerock.service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.MemberDTO;
import org.zerock.mapper.MemberMapper;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class MemberServiceTest {

	@Autowired
	private MemberService memberService;
		
	
	@Test
	void testInsert() {
		MemberDTO dto = MemberDTO.builder()
				.name("홍길북")
				.email("test4@naver.com")
				.password("1234")
				.build();
		
		memberService.insert(dto);

		log.info("생성된 PK : " + dto.getMno());
		
		assertNotNull(dto.getMno());
		
	}
	
	@Test
	void testList() {
		memberService.getList().forEach(member-> log.info(member));
	}
	
	@Test
	void testMemberById() {
		MemberDTO dto = memberService.memberById(3);
		
		log.info(dto);
	}
	
	@Test
	void testUpdate() {
		MemberDTO dto = MemberDTO.builder()
				.name("홍수정")
				.password("1111")
				.email("aaa@test.com")
				.mno(3)
				.build();

		memberService.update(dto);
		
		log.info(memberService.memberById(3));
		
	}
	
	@Test
	void testDelete() {
		memberService.delete(3);
	}

}
