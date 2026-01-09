package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.BoardSearchDTO;
import org.zerock.dto.PageDTO;
import org.zerock.mapper.BoardMapper;
import org.zerock.service.exception.ForbiddenException;
import org.zerock.service.exception.NotFoundException;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardService {

    private final BoardMapper boardMapper;

    /* ==========================
       게시글 등록
       ========================== */
    @Transactional
    public void register(BoardDTO boardDTO) {
        boardMapper.insertBoard(boardDTO);
    }

    /* ==========================
       게시글 상세 조회
       - 조회수 증가 포함
       ========================== */
    @Transactional
    public BoardDTO getDetailWithViewCount(int boardId) {

        int updated = boardMapper.increaseViewCount(boardId);
        if (updated == 0) {
            throw new NotFoundException("게시글을 찾을 수 없습니다.");
        }

        BoardDTO board = boardMapper.selectBoardById(boardId);
        if (board == null) {
            throw new NotFoundException("게시글을 찾을 수 없습니다.");
        }

        return board;
    }
    
    public BoardDTO getDetail(int boardId) {
        BoardDTO board = boardMapper.selectBoardById(boardId);
        if (board == null) {
            throw new NotFoundException("게시글을 찾을 수 없습니다.");
        }
        return board;
    }

    /* ==========================
       게시글 목록 조회
       ========================== */
    public List<BoardDTO> getList(BoardSearchDTO search, PageDTO page) {
        return boardMapper.selectBoardList(search, page);
    }

    /* ==========================
       게시글 전체 건수
       ========================== */
    public int getTotalCount(BoardSearchDTO search) {
        return boardMapper.selectBoardTotalCount(search);
    }

    /** edit 화면 진입용(권한 체크 포함) */
    public BoardDTO getForEdit(int boardId, int actorId, String role) {
        BoardDTO board = getDetail(boardId);
        assertCanModify(board, actorId, role);
        return board;
    }

    @Transactional
    public void modify(BoardDTO boardDTO, int actorId, String role) {
        BoardDTO existing = getDetail(boardDTO.getBoardId());
        assertCanModify(existing, actorId, role);

        int updated = boardMapper.updateBoard(boardDTO);
        if (updated == 0) throw new NotFoundException("수정할 게시글이 존재하지 않습니다.");
    }

    /* ==========================
       게시글 삭제 (논리 삭제)
       ========================== */
    @Transactional
    public void remove(int boardId, int actorId, String role) {
        BoardDTO existing = getDetail(boardId);
        assertCanModify(existing, actorId, role);

        int updated = boardMapper.deleteBoard(boardId);
        if (updated == 0) throw new NotFoundException("삭제할 게시글이 존재하지 않습니다.");
    }
    
    /** 권한 규칙: ADMIN 또는 작성자만 수정/삭제 가능 */
    private void assertCanModify(BoardDTO board, int actorId, String role) {
        boolean admin = "ADMIN".equals(role);
        boolean owner = board.getMemberId() == actorId;

        if (!(admin || owner)) {
            throw new ForbiddenException("수정/삭제 권한이 없습니다.");
        }
    }
}
