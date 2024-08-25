package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.BoardVo;

@Repository
public class BoardDao {

	@Autowired
	private SqlSession sqlSession;

	// 리스트 불러오기

	public List<BoardVo> getBoardList() {

		List<BoardVo> boardList = sqlSession.selectList("board.selectList");
		System.out.println(boardList);
		return boardList;

	}
	
	public BoardVo getBoardOne(BoardVo boardVo ) {

		BoardVo boardOne = sqlSession.selectOne("board.selectOne",boardVo);
		System.out.println(boardOne);
		return boardOne;

	}

}
