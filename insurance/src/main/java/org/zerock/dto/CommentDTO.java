package org.zerock.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class CommentDTO {
    private Integer commentId;
    private Integer boardId;
    private Integer memberId;

    private String writerName;
    private String writerRole;

    private String content;
    private String officialYn;   
    private String deletedYn;    
    private LocalDateTime createdAt;   

}