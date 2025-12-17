package org.zerock.service.exception;

import lombok.Getter;

@Getter
public class ReplyException extends RuntimeException{
	private int code;
	private String msg;
	
	public ReplyException(int code, String msg) {
		this.code = code;
		this.msg = msg;
	}

}
