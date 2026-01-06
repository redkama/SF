package org.zerock.mapper;

import java.util.List;

import org.zerock.dto.MemberDTO;
import org.zerock.dto.MemberUpdateAdminDTO;

public interface MemberMapper {
    MemberDTO selectByLoginId(String loginId);
    int insertMember(MemberDTO memberDTO);
    
    int existsLoginId(String loginId);
    
    MemberDTO selectByMemberId(int memberId);

    int updateNameEmail(int memberId, String name, String email);
    int updatePassword(int memberId, String password);
    
    List<MemberDTO> selectMemberList();
    
    int updateMemberByAdmin(MemberUpdateAdminDTO dto);
    
    int disableMember(int memberId);

}
