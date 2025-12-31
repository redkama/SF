package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.dto.LoginDTO;
import org.zerock.dto.MemberDTO;
import org.zerock.service.MemberService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {

    private final MemberService memberService;
    
    @GetMapping("/join")
    public String joinForm() {
        return "member/join";
    }

    @PostMapping("/join")
    public String join(MemberDTO memberDTO,
                       RedirectAttributes rttr) {

        // (선택) 최소 검증
        if (memberDTO.getLoginId() == null || memberDTO.getLoginId().isBlank()
                || memberDTO.getPassword() == null || memberDTO.getPassword().isBlank()
                || memberDTO.getName() == null || memberDTO.getName().isBlank()
                || memberDTO.getEmail() == null || memberDTO.getEmail().isBlank()) {

            rttr.addFlashAttribute("error", "필수 항목을 입력해 주세요.");
            return "redirect:/member/join";
        }

        memberService.join(memberDTO);

        rttr.addFlashAttribute("msg", "회원가입이 완료되었습니다. 로그인 해주세요.");
        return "redirect:/member/login";
    }
    

    @GetMapping("/login")
    public String loginForm() {
        return "member/login";
    }

    @PostMapping("/login")
    public String login(LoginDTO loginDTO,
                        HttpSession session,
                        RedirectAttributes rttr) {

        MemberDTO loginMember = memberService.login(loginDTO.getLoginId(), loginDTO.getPassword());

        if (loginMember == null) {
            rttr.addFlashAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "redirect:/member/login";
        }

        // 세션 저장 (전체 MemberDTO를 넣어도 되지만 필요한 것만 추천)
        session.setAttribute("loginMember", loginMember);

        return "redirect:/board/list";
    }

    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/board/list";
    }
}
