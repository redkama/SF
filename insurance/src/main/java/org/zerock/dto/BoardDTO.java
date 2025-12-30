package org.zerock.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Setter  //멤버 변수 변경 가능
@Getter  // 조회
@ToString  //멤버 변수 값 조회
@AllArgsConstructor  // 생성자
@NoArgsConstructor   //디폴트 생성자
@Builder             //setter 대용으로 사용 가능    
public class BoardDTO {

	  /** 게시글 ID */
    private int boardId;

    /** 작성자 회원 ID */
    private int memberId;

    /** 작성자 이름(조인 결과용) */
    private String writerName;

    /** 게시글 유형 (INQUIRY / SHARE) */
    private String boardType;

    /** 보험 카테고리 (AUTO / HEALTH / LIFE / FIRE ...) */
    private String insuranceType;

    /** 제목 */
    private String title;

    /** 내용 */
    private String content;

    /** 조회수 */
    private int viewCnt;

    /** 댓글 수 (목록용) */
    private int commentCount;

    /** 상태 (WAIT / ANSWERED / CLOSED) */
    private String status;
    
    /** 공개 여부 (Y/N) */
    private String openYn;

    /** 삭제 여부 (Y/N) */
    private String deletedYn;

    /** 생성일 */
    private LocalDateTime createdAt;

    /** 수정일 */
    private LocalDateTime updatedAt;
	
    public String getCreatedDate() {
        return createdAt == null ? "" : createdAt.format(DateTimeFormatter.ISO_DATE);
    }
		
}
