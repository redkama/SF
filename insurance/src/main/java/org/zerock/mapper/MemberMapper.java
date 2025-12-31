package org.zerock.mapper;

import org.zerock.dto.MemberDTO;

public interface MemberMapper {
    MemberDTO selectByLoginId(String loginId);
    int insertMember(MemberDTO memberDTO);
}
