package org.zerock.dto;

import lombok.*;

@Setter
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardSearchDTO  {

    /** 게시글 유형 (INQUIRY / SHARE) */
    private String boardType;

    /** 보험 유형 (AUTO / HEALTH / LIFE / FIRE) */
    private String insuranceType;

    /** 상태 (WAIT / ANSWERED / CLOSED) */
    private String status;

    /** 공개 여부 (Y/N) */
    private String openYn;

    /** 검색 키워드 (제목/내용) */
    private String keyword;
}
