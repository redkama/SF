package org.zerock.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.BoardSearchDTO;
import org.zerock.dto.PageDTO;
import org.zerock.service.BoardService;

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
    @GetMapping("/detail")
    public String detail(
            @RequestParam("boardId") int boardId,
            Model model) {

        model.addAttribute("board", boardService.getDetail(boardId));
        return "board/detail";
    }

    /* ==========================
       게시글 작성 화면
       ========================== */
    @GetMapping("/write")
    public String writeForm() {
        return "board/write";
    }

    /* ==========================
       게시글 등록
       ========================== */
    @PostMapping("/write")
    public String write(BoardDTO boardDTO) {

        boardService.register(boardDTO);

        return "redirect:/board/list";
    }

    /* ==========================
       게시글 수정 화면
       ========================== */
    @GetMapping("/edit")
    public String editForm(
            @RequestParam("boardId") int boardId,
            Model model) {

        model.addAttribute("board", boardService.getDetail(boardId));
        return "board/edit";
    }

    /* ==========================
       게시글 수정 처리
       ========================== */
    @PostMapping("/edit")
    public String edit(BoardDTO boardDTO) {

        boardService.modify(boardDTO);

        return "redirect:/board/detail?boardId=" + boardDTO.getBoardId();
    }

    /* ==========================
       게시글 삭제
       ========================== */
    @PostMapping("/delete")
    public String delete(@RequestParam("boardId") int boardId) {

        boardService.remove(boardId);

        return "redirect:/board/list";
    }
}
