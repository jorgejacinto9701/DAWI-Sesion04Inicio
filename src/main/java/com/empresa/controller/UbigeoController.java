package com.empresa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

// @ResponseBody permite que un arraylit se convierta aformato JSON

@Controller
public class UbigeoController {

	@RequestMapping("/")
	public String ver() {
		return "ubigeoJquery";
	}
	
	
	
}




