package com.javaex.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class GalleryController {
	
	
	@RequestMapping(value = "/gallery/list", method = { RequestMethod.GET, RequestMethod.POST })
	public void list() {
		System.out.println("list");
		
		
	}
	
	
}
