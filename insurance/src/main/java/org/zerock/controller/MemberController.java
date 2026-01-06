package org.zerock.controller;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.dto.LoginDTO;
import org.zerock.dto.MemberDTO;
import org.zerock.dto.MemberUpdateAdminDTO;
import org.zerock.dto.MemberUpdateDTO;
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
            memberDTO.setPassword(null);
            rttr.addFlashAttribute("form", memberDTO);
            return "redirect:/member/join";
        }
        
        // 2) 사전 중복 체크
        if (!memberService.isLoginIdAvailable(memberDTO.getLoginId())) {
            rttr.addFlashAttribute("error", "이미 사용 중인 아이디입니다.");
            memberDTO.setPassword(null);
            rttr.addFlashAttribute("form", memberDTO);
            return "redirect:/member/join";
        }

        // 3) 실제 가입 (경쟁상황 대비 예외도 잡기)
        try {
            memberService.join(memberDTO);
        } catch (DuplicateKeyException e) {
            rttr.addFlashAttribute("error", "이미 사용 중인 아이디입니다.");
            memberDTO.setPassword(null);
            rttr.addFlashAttribute("form", memberDTO);
            return "redirect:/member/join";
        }

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
    
    @GetMapping("/mypage")
    public String mypage(HttpSession session, RedirectAttributes rttr) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            rttr.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }
        return "member/mypage";
    }
    
    @GetMapping("/editMem")
    public String editForm(HttpSession session, RedirectAttributes rttr) {
        MemberDTO me = (MemberDTO) session.getAttribute("loginMember");
        if (me == null) {
            rttr.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }
        return "member/editMem";
    }

    @PostMapping("/editMem")
    public String edit(MemberUpdateDTO dto,
                       HttpSession session,
                       RedirectAttributes rttr) {

        MemberDTO me = (MemberDTO) session.getAttribute("loginMember");
        if (me == null) {
            rttr.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }

        // 업데이트 (password/name/email만)
        MemberDTO updated = memberService.updateProfile(me.getMemberId(), dto);

        // 세션 정보 갱신 (이게 중요)
        session.setAttribute("loginMember", updated);

        rttr.addFlashAttribute("msg", "회원정보가 수정되었습니다.");
        return "redirect:/member/mypage";
    }
    
    @GetMapping("/listMem")
    public String listMem(HttpSession session,
                          Model model,
                          RedirectAttributes rttr) {

        MemberDTO me = (MemberDTO) session.getAttribute("loginMember");
        if (me == null) {
            rttr.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }
        if (!"ADMIN".equals(me.getRole())) {
            rttr.addFlashAttribute("error", "접근 권한이 없습니다.");
            return "redirect:/board/list";
        }

        java.util.List<MemberDTO> members = memberService.getMemberList();
        model.addAttribute("members", members);
        model.addAttribute("totalCount", members.size());
        return "member/listMem";
    }
    
    @GetMapping("/editMemAdmin")
    public String editForm(@RequestParam int memberId,
                           Model model,
                           HttpSession session,
                           RedirectAttributes rttr) {

        MemberDTO me = (MemberDTO) session.getAttribute("loginMember");
        if (me == null) {  // ✅ 추가
            rttr.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }
        if (!"ADMIN".equals(me.getRole())) {
            rttr.addFlashAttribute("error", "접근 권한이 없습니다. (관리자 전용)");
            return "redirect:/board/list";
        }

        MemberDTO target = memberService.getMemberById(memberId);
        if (target == null) {
            rttr.addFlashAttribute("error", "존재하지 않는 회원입니다.");
            return "redirect:/member/listMem";
        }

        model.addAttribute("target", target);
        return "member/editMemAdmin";
    }

    @PostMapping("/editMemAdmin")
    public String edit(@ModelAttribute MemberUpdateAdminDTO dto,
                       HttpSession session,
                       RedirectAttributes rttr) {

        MemberDTO me = (MemberDTO) session.getAttribute("loginMember");
        if (me == null) {  // ✅ 추가
            rttr.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }
        if (!"ADMIN".equals(me.getRole())) {
            rttr.addFlashAttribute("error", "접근 권한이 없습니다. (관리자 전용)");
            return "redirect:/board/list";
        }

        try {
            memberService.updateMemberByAdmin(dto);
            rttr.addFlashAttribute("msg", "회원정보가 수정되었습니다.");
        } catch (Exception e) {
            rttr.addFlashAttribute("error", "수정 중 오류가 발생했습니다.");
        }

        return "redirect:/member/listMem";
    }

    @PostMapping("/deleteMemAdmin")
    public String deleteMemAdmin(@RequestParam int memberId,
                                 HttpSession session,
                                 RedirectAttributes rttr) {

        MemberDTO me = (MemberDTO) session.getAttribute("loginMember");
        if (me == null) {
            rttr.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }
        if (!"ADMIN".equals(me.getRole())) {
            rttr.addFlashAttribute("error", "접근 권한이 없습니다. (관리자 전용)");
            return "redirect:/board/list";
        }

        // (추천) 관리자 본인 계정 삭제 방지
        if (me.getMemberId() == memberId) {
            rttr.addFlashAttribute("error", "관리자 본인 계정은 삭제할 수 없습니다.");
            return "redirect:/member/editMemAdmin?memberId=" + memberId;
        }

        try {
            memberService.disableMember(memberId); // use_yn = 'N'
            rttr.addFlashAttribute("msg", "회원이 삭제(비활성화)되었습니다.");
        } catch (Exception e) {
            rttr.addFlashAttribute("error", "삭제 중 오류가 발생했습니다.");
            return "redirect:/member/editMemAdmin?memberId=" + memberId;
        }

        return "redirect:/member/listMem";
    }
    
    @PostMapping("/withdraw")
    public String withdraw(HttpSession session, RedirectAttributes rttr) {

        MemberDTO me = (MemberDTO) session.getAttribute("loginMember");
        if (me == null) {
            rttr.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }

        try {
            memberService.disableMember(me.getMemberId()); // use_yn='N'
            session.invalidate(); // 탈퇴 후 세션 끊기
            rttr.addFlashAttribute("msg", "회원탈퇴가 완료되었습니다.");
        } catch (Exception e) {
            rttr.addFlashAttribute("error", "회원탈퇴 중 오류가 발생했습니다.");
            return "redirect:/member/editMem";
        }

        return "redirect:/board/list";
    }


}
