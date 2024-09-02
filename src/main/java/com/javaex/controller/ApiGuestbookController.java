package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.GuestbookService;
import com.javaex.vo.GuestVo;

@Controller
public class ApiGuestbookController {

	@Autowired
	private GuestbookService guestbookService;

	@ResponseBody
	@RequestMapping(value = "/api/guestbook/list", method = { RequestMethod.GET, RequestMethod.POST })
	public List<GuestVo> list() {

		List<GuestVo> guestbooktList = guestbookService.exeGuestList();
		System.out.println(guestbooktList);

		return guestbooktList;
	}

	@ResponseBody
	@RequestMapping(value = "/api/guestbook/write", method = { RequestMethod.GET, RequestMethod.POST })
	public GuestVo write(@ModelAttribute GuestVo guestVo) {
		System.out.println(guestVo);
		// int count = guestbookService.exeWrite(guestVo);

		GuestVo gVo = guestbookService.exeSelectKey(guestVo);
		System.out.println(gVo);
		return gVo;
	}

	@ResponseBody
	@RequestMapping(value = "/api/guestbook/delete", method = { RequestMethod.GET, RequestMethod.POST })
	public boolean delete(@RequestParam("no") int no, @RequestParam("password") String password) {
		System.out.println("delete 요청");
		// 데이터베이스에서 삭제 처리
		boolean isDeleted = guestbookService.exeDelete(no, password);		
		
		if (isDeleted) {
			System.out.println("삭제 성공");
			// 삭제 성공 시 리스트 페이지로 리다이렉트
			return isDeleted;
		} else {
			System.out.println("삭제 실패");
			return isDeleted;
		}

	}
	
}
