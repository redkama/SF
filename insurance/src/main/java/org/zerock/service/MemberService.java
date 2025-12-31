package org.zerock.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.zerock.dto.MemberDTO;
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
}
