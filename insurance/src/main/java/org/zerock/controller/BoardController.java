package org.zerock.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.BoardSearchDTO;
import org.zerock.dto.MemberDTO;
import org.zerock.dto.PageDTO;
import org.zerock.service.BoardService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {

    private final BoardService boardService;
    
    /* ==========================
       게시글 목록
       ========================== */
    @GetMapping("/list")
    public String list(
            @ModelAttribute("search") BoardSearchDTO search,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model
    ) {
        PageDTO pageDTO = new PageDTO(page, size);

        int totalCount = boardService.getTotalCount(search);
        pageDTO.setTotalCount(totalCount); // ✅ 이거 필수

        List<BoardDTO> list = boardService.getList(search, pageDTO);

        model.addAttribute("list", list);
        model.addAttribute("page", pageDTO);
        model.addAttribute("totalCount", totalCount);

        return "board/list";
    }
    
    
    /* ==========================
       게시글 상세
       ========================== */
    @GetMapping("/view")
    public String view(
    		@RequestParam("boardId") int boardId,
            @ModelAttribute("search") BoardSearchDTO search,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model
    ) {
        model.addAttribute("board", boardService.getDetailWithViewCount(boardId));
        model.addAttribute("page", new PageDTO(page, size));
        return "board/detail";
    }
    
    @GetMapping("/detail")
    public String detail(
    		@RequestParam("boardId") int boardId,
            @ModelAttribute("search") BoardSearchDTO search,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model
    ) {
        model.addAttribute("board", boardService.getDetail(boardId));
        model.addAttribute("page", new PageDTO(page, size));
        return "board/detail";
    }

    /* ==========================
       게시글 작성 화면
       ========================== */
    @GetMapping("/write")
    public String writeForm(
    		@ModelAttribute("search") BoardSearchDTO search,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model
    ) {
        model.addAttribute("page", new PageDTO(page, size));
        return "board/write";
    }
    
    /* ==========================
       게시글 등록
       ========================== */
    @PostMapping("/write")
    public String write(BoardDTO boardDTO,
    				HttpSession session,
		            @ModelAttribute("search") BoardSearchDTO search,
		            @RequestParam(defaultValue = "1") int page,
		            @RequestParam(defaultValue = "10") int size,
		            RedirectAttributes rttr) {
    	
    	MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        boardDTO.setMemberId(loginMember.getMemberId()); // ✅ 서버에서 확정
		
		boardService.register(boardDTO);
		
		// ✅ 등록 후 목록으로 돌아가며 조건 유지
		rttr.addAttribute("boardType", search.getBoardType());
		rttr.addAttribute("insuranceType", search.getInsuranceType());
		rttr.addAttribute("keyword", search.getKeyword());
		rttr.addAttribute("page", page);
		rttr.addAttribute("size", size);
		
		return "redirect:/board/list";
	}
    
    /* ==========================
       게시글 수정 화면
       ========================== */
    @GetMapping("/edit")
    public String editForm(
    		@RequestParam("boardId") int boardId,
            @ModelAttribute("search") BoardSearchDTO search,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model
    ) {
        model.addAttribute("board", boardService.getDetail(boardId));
        model.addAttribute("page", new PageDTO(page, size));
        return "board/edit";
    }

    /* ==========================
       게시글 수정 처리
       ========================== */
    @PostMapping("/edit")
    public String edit(BoardDTO boardDTO, HttpSession session,
    		@ModelAttribute("search") BoardSearchDTO search,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            RedirectAttributes rttr) {
    	
    	MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
    	boardService.modify(boardDTO, loginMember.getMemberId(), loginMember.getRole());
		
		rttr.addAttribute("boardId", boardDTO.getBoardId());
		rttr.addAttribute("boardType", search.getBoardType());
		rttr.addAttribute("insuranceType", search.getInsuranceType());
		rttr.addAttribute("keyword", search.getKeyword());
		rttr.addAttribute("page", page);
		rttr.addAttribute("size", size);
		
		return "redirect:/board/detail";
	}
    
    /* ==========================
       게시글 삭제
       ========================== */
    @PostMapping("/delete")
    public String delete(
    		@RequestParam("boardId") int boardId,
            @ModelAttribute("search") BoardSearchDTO search,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            RedirectAttributes rttr) {

		boardService.remove(boardId);
		
		rttr.addAttribute("boardType", search.getBoardType());
		rttr.addAttribute("insuranceType", search.getInsuranceType());
		rttr.addAttribute("keyword", search.getKeyword());
		rttr.addAttribute("page", page);
		rttr.addAttribute("size", size);
		
		return "redirect:/board/list";
	}
}
