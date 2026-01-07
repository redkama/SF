package org.zerock.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.BoardSearchDTO;
import org.zerock.dto.PageDTO;

public interface BoardMapper {

    /* ==========================
       게시글 등록
       ========================== */
    int insertBoard(BoardDTO boardDTO);

    /* ==========================
       게시글 단건 조회
       ========================== */
    BoardDTO selectBoardById(int boardId);

    /* ==========================
       게시글 목록 조회 (페이징 + 검색)
       ========================== */
    List<BoardDTO> selectBoardList(
            @Param("search") BoardSearchDTO search,
            @Param("page") PageDTO page
    );

    /* ==========================
       게시글 전체 개수 (페이징용)
       ========================== */
    int selectBoardTotalCount(
            @Param("search") BoardSearchDTO search
    );

    /* ==========================
       게시글 수정
       ========================== */
    int updateBoard(BoardDTO boardDTO);

    /* ==========================
       게시글 삭제 (논리 삭제)
       ========================== */
    int deleteBoard(int boardId);

    /* ==========================
       조회수 증가
       ========================== */
    int increaseViewCount(int boardId);

	void updateStatus(@Param("boardId") int boardId,
            		@Param("status") String status);

	Map<String, Object> selectOwnerAndStatus(@Param("boardId") int boardId);
	
}
