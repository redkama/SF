package org.zerock.mapper;

import java.util.List;

import org.zerock.dto.TodoDTO;

public interface TodoMapper {

	void insert(TodoDTO dto);
	
	List<TodoDTO> getList();
	
	TodoDTO todoById(int id);
	
	void update(TodoDTO dto);
	
	void delete(int id);
}
