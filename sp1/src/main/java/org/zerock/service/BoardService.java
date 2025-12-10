package org.zerock.service;



import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.BoardListPaginDTO;
import org.zerock.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class BoardService {

	private final BoardMapper boardMapper;
	
	public List<BoardDTO> getList() {
		return boardMapper.list();
	}
	
	public BoardListPaginDTO getList(int page, int size) {
		
		page = page <= 0 ? 1 : page;
		
		size = (size <= 10 || page > 100) ? 10 : size;
		
		int skip = (page -1) * size;
		
		List<BoardDTO> list = boardMapper.list2(skip, size);
		
		int total = boardMapper.listCount();
		
		
		return new BoardListPaginDTO(list, total, page, size);
	}

	public Long register(BoardDTO dto) {
		int insertCounter = boardMapper.insert(dto);
		
		log.info("insertCounter : " + insertCounter);
		
		return dto.getBno();
	}

	public BoardDTO read(Long bno) {

		return boardMapper.selectOne(bno);
	}

	public void remove(Long bno) {
		boardMapper.remove(bno);
	}

	public void modify(BoardDTO dto) {

		boardMapper.update(dto);
	}
	
}
