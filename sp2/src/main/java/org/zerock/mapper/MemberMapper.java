package org.zerock.mapper;

import java.util.List;

import org.zerock.dto.MemberDTO;

public interface MemberMapper {

	void insert(MemberDTO dto);
	
	List<MemberDTO> getList();
	
	MemberDTO memberById(int mno);
	
	void update(MemberDTO dto);
	
	void delete(int mno);
}
