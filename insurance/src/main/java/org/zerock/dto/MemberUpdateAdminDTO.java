package org.zerock.dto;

import lombok.Data;

@Data
public class MemberUpdateAdminDTO {
	private int memberId;
    private String password; // 비우면 변경 안함
    private String name;
    private String role;     
    private String email;
    private String useYn;    
}
