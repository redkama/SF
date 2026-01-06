package org.zerock.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.dto.CommentDTO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.CommentMapper;

import lombok.RequiredArgsConstructor;

@Service
public class CommentService {

    @Autowired private CommentMapper commentMapper;
    @Autowired private BoardMapper boardMapper; // status 업데이트용 (이미 있는 mapper 사용)

    public List<CommentDTO> listByBoardId(int boardId){
        return commentMapper.selectByBoardId(boardId);
    }

    @Transactional
    public void addComment(CommentDTO dto, String afterStatus){
        commentMapper.insert(dto);

        // afterStatus가 있으면 게시글 상태 변경
        if(afterStatus != null && !afterStatus.isBlank()){
        	// 허용값만
            if(!afterStatus.equals("WAIT") &&
               !afterStatus.equals("ANSWERED") &&
               !afterStatus.equals("CLOSED")) {
                return; 
            }
            boardMapper.updateStatus(dto.getBoardId(), afterStatus);
        }
    }

    public boolean updateCommentByOwner(int commentId, int memberId, String content){
        int updated = commentMapper.updateByOwner(Map.of(
                "commentId", commentId,
                "memberId", memberId,
                "content", content
        ));
        return updated == 1;
    }

    public boolean deleteComment(int commentId, int memberId, String role){
        if("ADMIN".equals(role)){
            return commentMapper.deleteByAdmin(commentId) == 1;
        }
        return commentMapper.deleteByOwner(Map.of(
                "commentId", commentId,
                "memberId", memberId
        )) == 1;
    }
}
