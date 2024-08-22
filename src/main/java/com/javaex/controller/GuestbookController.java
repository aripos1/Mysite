package com.javaex.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class GuestbookController {

	   //필드
	   
	   //생성자
	   
	   //메서드 gs
	   
	   //메서드 일반
	   
		//메인
	   @RequestMapping(value="/addlist", method= {RequestMethod.GET, RequestMethod.POST})
	   public String addlist() {
	      
	      System.out.println("addlist");
	      
	      return "guestbook/addList";
	   }
	   
	   @RequestMapping(value="/deleteform", method= {RequestMethod.GET, RequestMethod.POST})
	   public String deleteform() {
	      
	      System.out.println("deleteform");
	      
	      return "guestbook/deleteForm";
	   }
}
