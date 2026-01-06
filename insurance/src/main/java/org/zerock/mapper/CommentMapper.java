package org.zerock.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.zerock.dto.CommentDTO;

public interface CommentMapper {

    /**
     * 게시글 댓글 목록 (deleted_yn='N'만)
     * XML: comment.selectByBoardId
     */
    List<CommentDTO> selectByBoardId(@Param("boardId") int boardId);

    /**
     * 댓글 등록
     * XML: comment.insert
     * useGeneratedKeys=true keyProperty=commentId 로 commentId가 dto에 세팅됨
     */
    int insert(CommentDTO dto);

    /**
     * 댓글 수정(본인만)
     * XML: comment.updateByOwner
     * params: commentId, memberId, content
     */
    int updateByOwner(Map<String, Object> param);

    /**
     * 댓글 삭제(본인만, soft delete)
     * XML: comment.deleteByOwner
     * params: commentId, memberId
     */
    int deleteByOwner(Map<String, Object> param);

    /**
     * 댓글 삭제(관리자, soft delete)
     * XML: comment.deleteByAdmin
     */
    int deleteByAdmin(@Param("commentId") int commentId);

    /**
     * 댓글이 속한 게시글 ID 조회(redirect용/검증용)
     * XML: comment.selectBoardIdByCommentId
     */
    Integer selectBoardIdByCommentId(@Param("commentId") int commentId);
}
