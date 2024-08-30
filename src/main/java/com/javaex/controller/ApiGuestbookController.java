package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.GuestbookService;
import com.javaex.vo.GuestVo;

@Controller
public class ApiGuestbookController {
	
	@Autowired
	private GuestbookService guestbookService;
	
	@ResponseBody
	@RequestMapping(value ="/api/guestbook/list",  method = { RequestMethod.GET, RequestMethod.POST })
	public List<GuestVo> list() {
		
		List<GuestVo> guestList = guestbookService.exeGuestList();
		System.out.println(guestList);
		
		return guestList;
	}	
	
	
	@RequestMapping(value ="/api/guestbook/write",  method = { RequestMethod.GET, RequestMethod.POST })
	public String write(@ModelAttribute GuestVo guestVo) {
		System.out.println(guestVo);
		int count = guestbookService.exeWrite(guestVo);
		
		System.out.println(count);
		
		return "";
	}
	

}
