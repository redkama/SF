package org.zerock.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Setter  //멤버 변수 변경 가능
@Getter  // 조회
@ToString  //멤버 변수 값 조회
public class LoginDTO {
    private String loginId;
    private String password;
}
