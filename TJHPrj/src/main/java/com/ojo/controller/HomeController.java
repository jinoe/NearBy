package com.ojo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ojo.entity.Member;
import com.ojo.entity.Product;
import com.ojo.service.IndexService;
import com.ojo.service.MainService;

@Controller
public class HomeController {
	
	@Autowired
	MainService service;
	
	@RequestMapping({"/", "/{gu}"})
	public String main(Model model, HttpSession session, @PathVariable(required = false) String gu) {
		List<String> guList = service.getGuList();
		model.addAttribute("guList",guList);
		
		String userId = (String) session.getAttribute("userId");
		List<Product> productList = null;
		if(userId != null) {
			Member member = service.getMember(userId);
			model.addAttribute("member", member);
			productList = service.getProducts((gu==null)?member.getGu():gu);
			model.addAttribute("selectedGu", (gu==null)?member.getGu():gu);
		}
		else {
			productList = service.getProducts("전체");
			model.addAttribute("selectedGu", (gu==null)?"전체":gu);
		}
		model.addAttribute("productList", productList);
		
		return "main";
	}
}
