package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.javaex.service.BoardService;
import com.javaex.vo.BoardVo;

import jakarta.servlet.http.HttpSession;

@Controller
public class BoardController {

    @Autowired
    private BoardService boardService;
	// 필드

	// 생성자

	// 메서드 gs

	// 메서드 일반

	// 메인
	@RequestMapping(value = "/board/list", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardList(Model model) {

		System.out.println("boardList");

		List<BoardVo> exeBoardList = boardService.exeBoardList();
		model.addAttribute("boardList", exeBoardList);
		boardService.exeBoardList();

		return "board/list";
	}

	@RequestMapping(value = "/board/read", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardRead(@ModelAttribute BoardVo boardVo, HttpSession session) {
		System.out.println("UserController.login()");

		BoardVo boardOne = boardService.exeBoardOne(boardVo);
		System.out.println(boardOne);

		// 로그인
		session.setAttribute("boardOne", boardOne);

		return "board/read";
	}
}
