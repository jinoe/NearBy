package com.ojo.controller.users;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ojo.entity.CharRoomView;
import com.ojo.entity.Chat;
import com.ojo.entity.ChatRoom;
import com.ojo.entity.Member;
import com.ojo.entity.Product;
import com.ojo.service.UserService;

@Controller
@RequestMapping("/users/")
public class UserController {
	
	@Autowired
	UserService service;
	
	@RequestMapping("{sellerId}")
	public String getUserPage(@PathVariable String sellerId, 
								@RequestParam(required = false, defaultValue = "1") int p,
								String gu, HttpSession session, Model model) {
		List<String> guList = service.getGuList();
		model.addAttribute("guList",guList);
		model.addAttribute("selectedGu", gu);
		
		String userId = (String) session.getAttribute("userId");
		if(userId != null) {
			Member member = service.getMember(userId);
			model.addAttribute("member", member);
		}
		Member seller = service.getMember(sellerId);
		model.addAttribute("seller", seller);
		List<Product> productList = service.getUserProducts(sellerId, p);
		model.addAttribute("productList", productList);
		model.addAttribute("selectedPage",p);
		int count = service.getProductCount(sellerId);
		model.addAttribute("productCount", count);
		
		return "users/detail";
	}
	
	@RequestMapping("login")
	public String getlogin() {
		
		return "users/login";
	}
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.removeAttribute("userId");
		return "main";
	}
	@RequestMapping("login_check")
	public String login_check(@ModelAttribute("member") Member member,Model model, HttpSession session) {
			Member loginMember = service.userCheck(member);
			if(loginMember==null) {
				model.addAttribute("loginFail", true);
				return "users/login";
			}
			session.setAttribute("userId", loginMember.getId());
			return "redirect:/";
	}
	@GetMapping("signup")
	public String signUp(Model model) {
		List<String> guList =  service.getGuList();
		model.addAttribute("guList", guList);
		return "users/signUp";
	}
	@PostMapping("signup")
	public String createUser(@ModelAttribute Member member) {
		int result = service.createUser(member);
		return "users/signUp";
	}
	@ResponseBody
	@PostMapping("duplicatedIdCheck")
	public int duplicatedIdCheck(@RequestBody Member member) {
		int result = service.duplicatedIdCheck(member);
		System.out.println(result);
		return result;
	}
	@ResponseBody
	@PostMapping("duplicatedNickCheck")
	public int duplicateCheck(@RequestBody Member member) {
		int result = service.duplicatedNickCheck(member);
		System.out.println(result);
		return result;
	}
	
	@RequestMapping("chat")
	public String chat(Model model, HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		if(userId != null) {
			Member member = service.getMember(userId);
			model.addAttribute("member", member);
			List<CharRoomView> roomList = service.getRoomList(member.getNickname()); 
			model.addAttribute("roomList", roomList);
		} else {
			return "users/login";
		}
		return "users/chat";
	}
	@ResponseBody
	@GetMapping("chat/chatting")
	public List<Chat> loadChatting(@RequestParam int roomIdx) {
		List<Chat> chatList = service.getChatList(roomIdx);
		return chatList;
	}
	@ResponseBody
	@PostMapping("chat/chatting")
	public int addChatting(@RequestBody HashMap<String, Object> hmap) {
		int result = service.addChatting(hmap);
		return result;
	}
}
