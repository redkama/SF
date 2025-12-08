package org.zerock.mapper;

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
class TodoMapperTest {
	
	@Autowired
	private TodoMapper todoMapper;

	@Test
	void testInsert() {
		TodoDTO dto = TodoDTO.builder()
				.title("스프링공부")
				.description("공부 해야지 ㅎ")
				.done(false)
				.build();
		
		todoMapper.insert(dto);
		
		log.info("생성된 PK : " + dto.getId());
		
		assertNotNull(dto.getId());
		
	}
	
	
	
	
	
//	@Test
//	void testList() {
//		memberMapper.getList().forEach(member-> log.info(member));
//	}
//	
//	@Test
//	void testMemberById() {
//		MemberDTO dto = memberMapper.memberById(4);
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
//				.mno(4)
//				.build();
//		
//		memberMapper.update(dto);
//		
//		log.info(memberMapper.memberById(4));
//	}
//	
//	@Test
//	void testDelete() {
//		memberMapper.delete(4);
//	}
	
	
	
	

}
