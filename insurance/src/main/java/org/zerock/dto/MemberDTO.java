package org.zerock.dto;

import java.time.LocalDateTime;

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
public class MemberDTO {
    private int memberId;
    private String loginId;
    private String password;   // DB에는 해시 저장
    private String name;
    private String role;       // USER / COUNSELOR / ADMIN
    private String email;
    private String useYn;      // Y/N
    private LocalDateTime createdAt;
}
