package org.zerock.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.dto.CommentDTO;
import org.zerock.dto.MemberDTO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.CommentMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentMapper commentMapper;
    private final BoardMapper boardMapper; // status 업데이트용

    public List<CommentDTO> listByBoardId(int boardId){
        return commentMapper.selectByBoardId(boardId);
    }

    @Transactional
    public void addComment(CommentDTO dto, String requestedAfterStatus, MemberDTO actor){
    	
        commentMapper.insert(dto);

        String allowed = resolveAllowedAfterStatus(dto.getBoardId(), requestedAfterStatus, actor);
        if (allowed != null) {
            boardMapper.updateStatus(dto.getBoardId(), allowed);
        }
    }
    
    private String resolveAllowedAfterStatus(int boardId, String requestedAfterStatus, MemberDTO actor) {

        if (actor == null) return null;
        if (requestedAfterStatus == null || requestedAfterStatus.isBlank()) return null;

        // 1) 요청값 자체 검증(화이트리스트)
        Set<String> ALL = Set.of("WAIT", "ANSWERED", "CLOSED");
        if (!ALL.contains(requestedAfterStatus)) return null;

        String role = actor.getRole(); 
        boolean staff = "ADMIN".equals(role) || "COUNSELOR".equals(role);

        // 2) 게시글 소유자/현재 status 조회
        Map<String, Object> info = boardMapper.selectOwnerAndStatus(boardId);
        if (info == null) return null;

        Integer ownerId = toIntOrNull(info.get("memberId"));
        String currStatus = (String) info.get("status");

        // 3) 권한별 허용 afterStatus 결정
        if (staff) {
            // 직원: ANSWERED/CLOSED 허용 (UI에서 CLOSED를 막아도 서버는 일관되게 허용 가능)
            if ("ANSWERED".equals(requestedAfterStatus) || "CLOSED".equals(requestedAfterStatus)) {
                return requestedAfterStatus;
            }
            return null;
        }

        // 일반 USER: 작성자 + 현재 ANSWERED 일 때만 WAIT/CLOSED 허용
        boolean isOwner = (ownerId != null) && (ownerId == actor.getMemberId());
        if (isOwner && "ANSWERED".equals(currStatus)) {
            if ("WAIT".equals(requestedAfterStatus) || "CLOSED".equals(requestedAfterStatus)) {
                return requestedAfterStatus;
            }
        }

        return null;
    }

    /**
     * MyBatis가 숫자를 Integer/Long/BigDecimal 등으로 줄 수 있어서 안전 변환
     * (이게 안 맞으면 owner 비교가 실패해서 "유저가 상태변경이 안되는" 문제가 생기기도 함)
     */
    private Integer toIntOrNull(Object v) {
        if (v == null) return null;
        if (v instanceof Number n) return n.intValue();
        try {
            return Integer.parseInt(String.valueOf(v));
        } catch (Exception e) {
            return null;
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
