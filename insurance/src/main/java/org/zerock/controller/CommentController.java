package org.zerock.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.dto.CommentDTO;
import org.zerock.dto.MemberDTO;
import org.zerock.service.CommentService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/comment")
public class CommentController {

    @Autowired private CommentService commentService;

    @PostMapping("/write")
    public String write(
            @RequestParam int boardId,
            @RequestParam String content,
            @RequestParam(required=false) String officialYn,   // checkbox
            @RequestParam(required=false) String afterStatus,  // counselor/admin 전용
            @RequestParam Map<String,String> params,
            HttpSession session,
            RedirectAttributes ra
    ){
        MemberDTO me = (MemberDTO) session.getAttribute("loginMember");
        if(me == null){
            ra.addFlashAttribute("cerror", "로그인이 필요합니다.");
            addListParams(params, ra);
            ra.addAttribute("boardId", boardId);
            ra.addAttribute("focus", "comments");
            return "redirect:/board/detail";
        }

        if(content == null || content.trim().isEmpty()){
            ra.addFlashAttribute("cerror", "댓글 내용을 입력해주세요.");
            addListParams(params, ra);
            ra.addAttribute("boardId", boardId);
            ra.addAttribute("focus", "comments");
            return "redirect:/board/detail";
        }

        // officialYn / afterStatus 권한 제한
        String role = me.getRole(); // USER/COUNSELOR/ADMIN
        boolean staff = "ADMIN".equals(role) || "COUNSELOR".equals(role);

        CommentDTO dto = new CommentDTO();
        dto.setBoardId(boardId);
        dto.setMemberId(me.getMemberId());
        dto.setContent(content.trim());
        dto.setOfficialYn(staff && "Y".equals(officialYn) ? "Y" : "N");

        commentService.addComment(dto, staff ? afterStatus : null);

        ra.addFlashAttribute("cmsg", "댓글이 등록되었습니다.");
        addListParams(params, ra);
        ra.addAttribute("boardId", boardId);
        ra.addAttribute("focus", "comments");
        return "redirect:/board/detail";
    }

    @PostMapping("/update")
    public String update(
            @RequestParam int commentId,
            @RequestParam int boardId,
            @RequestParam String content,
            @RequestParam Map<String,String> params,
            HttpSession session,
            RedirectAttributes ra
    ){
        MemberDTO me = (MemberDTO) session.getAttribute("loginMember");
        if(me == null){
            ra.addFlashAttribute("cerror", "로그인이 필요합니다.");
            addListParams(params, ra);
            ra.addAttribute("boardId", boardId);
            ra.addAttribute("focus", "comments");
            return "redirect:/board/detail";
        }

        boolean ok = commentService.updateCommentByOwner(commentId, me.getMemberId(), content);
        if(!ok){
            ra.addFlashAttribute("cerror", "수정 권한이 없거나 댓글이 존재하지 않습니다.");
        }else{
            ra.addFlashAttribute("cmsg", "댓글이 수정되었습니다.");
        }

        addListParams(params, ra);
        ra.addAttribute("boardId", boardId);
        ra.addAttribute("focus", "comments");
        return "redirect:/board/detail";
    }

    @PostMapping("/delete")
    public String delete(
            @RequestParam int commentId,
            @RequestParam int boardId,
            @RequestParam Map<String,String> params,
            HttpSession session,
            RedirectAttributes ra
    ){
        MemberDTO me = (MemberDTO) session.getAttribute("loginMember");
        if(me == null){
            ra.addFlashAttribute("cerror", "로그인이 필요합니다.");
            addListParams(params, ra);
            ra.addAttribute("boardId", boardId);
            ra.addAttribute("focus", "comments");
            return "redirect:/board/detail";
        }

        boolean ok = commentService.deleteComment(commentId, me.getMemberId(), me.getRole());
        if(!ok){
            ra.addFlashAttribute("cerror", "삭제 권한이 없거나 댓글이 존재하지 않습니다.");
        }else{
            ra.addFlashAttribute("cmsg", "댓글이 삭제되었습니다.");
        }

        addListParams(params, ra);
        ra.addAttribute("boardId", boardId);
        ra.addAttribute("focus", "comments");
        return "redirect:/board/detail";
    }

    private void addListParams(Map<String,String> params, RedirectAttributes ra){
        String[] allowed = {"boardType","insuranceType","status","openYn","keyword","page","size"};
        for(String k: allowed){
            String v = params.get(k);
            if(v != null && !v.trim().isEmpty()){
                ra.addAttribute(k, v.trim());
            }
        }
    }
}
