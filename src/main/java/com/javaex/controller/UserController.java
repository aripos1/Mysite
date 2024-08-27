package com.javaex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.UserService;
import com.javaex.vo.UserVo;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	// 회원가입폼
	@RequestMapping(value = "user/joinform", method = { RequestMethod.GET, RequestMethod.POST })
	public String joinform() {

		System.out.println("joinform");

		return "user/joinForm";
	}

	@RequestMapping(value = "user/join", method = { RequestMethod.GET, RequestMethod.POST })
	public String join(@ModelAttribute UserVo uservo) {

		System.out.println("join");

		userService.exeInsert(uservo);

		return "user/joinOk";
	}

	@RequestMapping(value = "user/joinok", method = { RequestMethod.GET, RequestMethod.POST })
	public String joinok() {

		System.out.println("joinok");

		return "user/joinOk";
	}

	/* 로그인폼 */
	@RequestMapping(value = "/user/loginform", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginform() {

		return "user/loginForm";
	}

	/* 로그인 */
	@RequestMapping(value = "/user/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(@ModelAttribute UserVo userVo, HttpSession session) {
		System.out.println("UserController.login()");

		UserVo authUser = userService.exeLogin(userVo);
		System.out.println("세션에서 'no'와 '이름'을 잘 가져왔나" + authUser);

		// 로그인
		session.setAttribute("authUser", authUser);

		// 메인페이지로 리다이렉트
		return "redirect:/main";
	}

	/* 로그아웃 */
	@RequestMapping(value = "/user/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session) {
		System.out.println("UserController.logout()");

//		session.removeAttribute("authUser");
		session.invalidate();

		return "redirect:/main";
	}

	@RequestMapping(value = "/user/modifyform", method = { RequestMethod.GET, RequestMethod.POST })
	public String modifyform(@ModelAttribute UserVo userVo, HttpSession session, Model model) {
		System.out.println("modifyform");
		UserVo authUser = (UserVo) session.getAttribute("authUser");
		
		int no = authUser.getNo();
		
		UserVo modifyUser = userService.exeModifyForm(no);
		
		model.addAttribute("ModifyUser", modifyUser);
		/*
		System.out.println(authUser);
		session.setAttribute("ModifyUser", authUser);
		UserVo modifyUser = userService.exeModifyForm(authUser);
		System.out.println("ModifyUser " + modifyUser);
		model.addAttribute("ModifyUser", modifyUser);
		*/
		return "user/modifyForm";
	}

	@RequestMapping(value = "user/modify", method = { RequestMethod.GET, RequestMethod.POST })
	public String update(@ModelAttribute UserVo userVo, HttpSession session) {
		System.out.println("modify,update");

		// DS
		// userVo name pw gender no(X)

		// 세션의 no 가져오기
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		int no = authUser.getNo();
		System.out.println(no);
		// userVo + no
		userVo.setNo(no);
		System.out.println(userVo);
		// vo를 서비스에 넘겨서 ㅂ수정 반영
		userService.exeModify(userVo);

		// 세션의 이름만 변경 (해더의 이름이 변경안됨 현상)

		authUser.setName(userVo.getName());

		return "redirect:/main";
	}

}
