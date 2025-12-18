package org.zerock.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.dto.SampleDTO;
import org.zerock.service.ReplyService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@RestController
@RequiredArgsConstructor
@Log4j2
@RequestMapping("/replies")
public class ReplyController {

	private final ReplyService replyService;
	
	@GetMapping("/")
	public SampleDTO test() {
		
		return SampleDTO.builder()
				.name("hong")
				.age(20)
				.build();
		
	}
}
