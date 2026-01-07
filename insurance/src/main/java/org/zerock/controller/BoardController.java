package org.zerock.controller;

import java.util.List;
import java.util.Objects;

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
import org.zerock.dto.CommentDTO;
import org.zerock.dto.MemberDTO;
import org.zerock.dto.PageDTO;
import org.zerock.service.BoardService;
import org.zerock.service.CommentService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {

    private final BoardService boardService;
    
    private final CommentService commentService;
    
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
            Model model,
            HttpSession session,
            RedirectAttributes ra
    ) {
        // ✅ 권한 체크(조회수 증가 전에!)
        if (!canAccessPrivate(boardId, session, ra, search, page, size)) {
            return "redirect:/board/list";
        }

        model.addAttribute("board", boardService.getDetailWithViewCount(boardId));
        model.addAttribute("page", new PageDTO(page, size));

        List<CommentDTO> comments = commentService.listByBoardId(boardId);
        model.addAttribute("comments", comments);
        model.addAttribute("commentCount", comments.size());

        return "board/detail";
    }

    @GetMapping("/detail")
    public String detail(
            @RequestParam("boardId") int boardId,
            @ModelAttribute("search") BoardSearchDTO search,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model,
            HttpSession session,
            RedirectAttributes ra
    ) {
        // ✅ 권한 체크(여긴 조회수 증가 없음)
        if (!canAccessPrivate(boardId, session, ra, search, page, size)) {
            return "redirect:/board/list";
        }

        model.addAttribute("board", boardService.getDetail(boardId));
        model.addAttribute("page", new PageDTO(page, size));

        List<CommentDTO> comments = commentService.listByBoardId(boardId);
        model.addAttribute("comments", comments);
        model.addAttribute("commentCount", comments.size());

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
        if (loginMember == null) {
            rttr.addFlashAttribute("error", "로그인이 필요합니다.");
            addListParams(search, page, size, rttr);
            return "redirect:/member/login";
        }

        boardDTO.setMemberId(loginMember.getMemberId());
        boardService.register(boardDTO);

        rttr.addFlashAttribute("msg", "게시글이 등록되었습니다.");
        addListParams(search, page, size, rttr);

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
        if (loginMember == null) {
            rttr.addFlashAttribute("error", "로그인이 필요합니다.");
            addListParams(search, page, size, rttr);
            return "redirect:/member/login";
        }

        boardService.modify(boardDTO, loginMember.getMemberId(), loginMember.getRole());

        rttr.addFlashAttribute("msg", "게시글이 수정되었습니다.");
        rttr.addAttribute("boardId", boardDTO.getBoardId());
        addListParams(search, page, size, rttr);

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
            HttpSession session,
            RedirectAttributes rttr
    ) {
        MemberDTO me = (MemberDTO) session.getAttribute("loginMember");
        if (me == null) {
            rttr.addFlashAttribute("error", "로그인이 필요합니다.");
            addListParams(search, page, size, rttr);
            return "redirect:/member/login";
        }

        // remove 내부에서 권한 검증한다면 OK
        // 아니면 remove(boardId, me.getMemberId(), me.getRole()) 형태로 권한을 넘기는 게 더 안전함
        boardService.remove(boardId);

        rttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
        addListParams(search, page, size, rttr);

        return "redirect:/board/list";
	}
    
    private boolean canAccessPrivate(
            int boardId,
            HttpSession session,
            RedirectAttributes rttr,
            BoardSearchDTO search,
            int page,
            int size
    ) {
        MemberDTO me = (MemberDTO) session.getAttribute("loginMember");

        // ✅ 접근 체크용 조회 (조회수 증가 X)
        BoardDTO board = boardService.getDetail(boardId);
        if (board == null) {
        	rttr.addFlashAttribute("error", "게시글이 존재하지 않습니다.");
            addListParams(search, page, size, rttr);
            return false;
        }

        // openYn == 'N' 이면 작성자/담당자/관리자만
        if ("N".equals(board.getOpenYn())) {
            boolean staff = (me != null) && ("ADMIN".equals(me.getRole()) || "COUNSELOR".equals(me.getRole()));
            boolean owner = (me != null) && Objects.equals(me.getMemberId(), board.getMemberId());

            if (!(staff || owner)) {
            	rttr.addFlashAttribute("error", "비공개 게시글은 작성자/담당자/관리자만 조회할 수 있습니다.");
                addListParams(search, page, size, rttr);
                return false;
            }
        }

        return true;
    }
    
    private void addListParams(BoardSearchDTO search, int page, int size, RedirectAttributes rttr) {
        if (search != null) {
            if (search.getBoardType() != null && !search.getBoardType().isBlank()) rttr.addAttribute("boardType", search.getBoardType());
            if (search.getInsuranceType() != null && !search.getInsuranceType().isBlank()) rttr.addAttribute("insuranceType", search.getInsuranceType());
            if (search.getStatus() != null && !search.getStatus().isBlank()) rttr.addAttribute("status", search.getStatus());
            if (search.getOpenYn() != null && !search.getOpenYn().isBlank()) rttr.addAttribute("openYn", search.getOpenYn());
            if (search.getKeyword() != null && !search.getKeyword().isBlank()) rttr.addAttribute("keyword", search.getKeyword());
        }
        rttr.addAttribute("page", page);
        rttr.addAttribute("size", size);
    }
}
