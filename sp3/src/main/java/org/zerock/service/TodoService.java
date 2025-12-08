package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.dto.TodoDTO;
import org.zerock.mapper.TodoMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TodoService {

	private final TodoMapper mapper;
	
	
	public void insert(TodoDTO dto) {
		mapper.insert(dto);
	}
	
	public List<TodoDTO> getList() {
		return mapper.getList();
	}
	
	
	public TodoDTO todoById(int id) {
		return mapper.todoById(id);
	}
	
	public void update(TodoDTO dto) {
		mapper.update(dto);
	}
		
	public void delete(int id) {
		mapper.delete(id);
	}
	
	
	
}
