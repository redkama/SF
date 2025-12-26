package org.zerock.mapper;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.annotation.Commit;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.dto.AccountDTO;
import org.zerock.dto.AccountRole;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class AccountMapperTest {

	@Autowired
	private AccountMapper accountMapper;
	
	@Autowired
	private PasswordEncoder encoder;
	
	
	@Test
	@Transactional
	@Commit
	void testInsert() {
		
		for(int i=1; i<=100; i++) {
			AccountDTO account = 
					AccountDTO.builder()
					.uid("user"+i)
					.upw(encoder.encode("1111"))
					.uname("User"+i)
					.email("user"+i+"@test.com")					
					.build();
			
			account.addRole(AccountRole.USER);
			
			if(i>=80) 
				account.addRole(AccountRole.MANAGER);			
			
			if(i>=90)
				account.addRole(AccountRole.ADMIN);
			
			accountMapper.insert(account);
			accountMapper.insertRoles(account);
		}
	}
	
	@Test
	public void testSelectOne() {
		AccountDTO accountDTO = accountMapper.selectOne("user100");
		
		log.info(accountDTO);
		log.info(accountDTO.getRoleNames());
	}
	
}