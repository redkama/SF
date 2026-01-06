package org.zerock.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.zerock.dto.MemberDTO;
import org.zerock.dto.MemberUpdateAdminDTO;
import org.zerock.dto.MemberUpdateDTO;
import org.zerock.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberMapper memberMapper;
    private final PasswordEncoder passwordEncoder; // BCrypt

    public void join(MemberDTO memberDTO) {
        memberDTO.setPassword(passwordEncoder.encode(memberDTO.getPassword()));
        memberMapper.insertMember(memberDTO);
    }

    public MemberDTO login(String loginId, String rawPassword) {
        MemberDTO member = memberMapper.selectByLoginId(loginId);
        if (member == null) return null;

        boolean ok = passwordEncoder.matches(rawPassword, member.getPassword());
        return ok ? member : null;
    }
    
    public boolean isLoginIdAvailable(String loginId) {
        return memberMapper.existsLoginId(loginId) == 0;
    }
    
    public MemberDTO updateProfile(int memberId, MemberUpdateDTO dto) {

        // 1) name/email은 무조건 업데이트
        memberMapper.updateNameEmail(memberId, dto.getName(), dto.getEmail());

        // 2) password는 값이 들어온 경우에만 업데이트(암호화)
        if (dto.getPassword() != null && !dto.getPassword().trim().isEmpty()) {
            String enc = passwordEncoder.encode(dto.getPassword());
            memberMapper.updatePassword(memberId, enc);
        }

        // 3) 최신 정보 다시 조회해서 반환(세션 갱신용)
        return memberMapper.selectByMemberId(memberId);
    }
    
    public List<MemberDTO> getMemberList() {
        return memberMapper.selectMemberList();
    }
    
    public MemberDTO getMemberById(int memberId) {
        return memberMapper.selectByMemberId(memberId);
    }

    public void updateMemberByAdmin(MemberUpdateAdminDTO dto) {
        // 비밀번호 입력 시에만 암호화
        if (dto.getPassword() != null && !dto.getPassword().isBlank()) {
            dto.setPassword(passwordEncoder.encode(dto.getPassword()));
        } else {
            dto.setPassword(null); // mapper에서 null이면 update 제외
        }
        memberMapper.updateMemberByAdmin(dto);
    }
    
    public void disableMember(int memberId) {
        memberMapper.disableMember(memberId);
    }



}
