package com.ojo.controller.product;


import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ojo.entity.Member;
import com.ojo.entity.Product;
import com.ojo.service.IndexService;
import com.ojo.service.ProductService;

@Controller
@RequestMapping("/product/")
public class ProductController {

	@Autowired
	ProductService service;
	
	@GetMapping("{idx}")
	public String getProduct(@PathVariable int idx, @RequestParam(required = false, defaultValue = "") String gu, Model model, HttpSession session) {
		// 헤더
		List<String> guList = service.getGuList();
		model.addAttribute("guList",guList);
		model.addAttribute("selectedGu", gu);
		
		String userId = (String) session.getAttribute("userId");
		if(userId != null) {
			Member member = service.getMember(userId);
			model.addAttribute("member", member);
		}
		
		//  판매상품 정보
		Product product = service.getProduct(idx);
		model.addAttribute("product", product);
		// 판매자 정보
		Member seller = service.getMember(product.getUserId());
		model.addAttribute("seller", seller);
		
		List<Product> sellerProducts = service.getUserProducts(product.getUserId());
		
		if(sellerProducts.size()>4) model.addAttribute("sellerProducts", sellerProducts.subList(0, 4));
		else model.addAttribute("sellerProducts", sellerProducts);
		
		model.addAttribute("sellerProductsCount", sellerProducts.size());
		return "product/detail";
	}
	
	@RequestMapping("search")
	public String search(@RequestParam(required = false, defaultValue = "") String gu,
			@RequestParam(value = "q", required = false, defaultValue = "") String query, 
			@RequestParam(value="c", required = false, defaultValue = "") String category,
			@RequestParam(value="p", required = false, defaultValue = "1") int page,
			Model model, HttpSession session)
	{
		List<String> guList = service.getGuList();
		model.addAttribute("guList",guList);
		String userId = (String) session.getAttribute("userId");
		if(userId != null) {
			Member member = service.getMember(userId);
			model.addAttribute("member", member);
		}
		
		model.addAttribute("selectedGu",(gu.equals(""))?"전체":gu);
		model.addAttribute("selectedQuery",query);
		model.addAttribute("selectedCategory",category);
		model.addAttribute("selectedPage",page);
		
		List<Product> productList =  service.getProducts(gu, query, category, page);
		model.addAttribute("productList", productList);

		int productCount = service.getProductsCount(gu, query, category);
		model.addAttribute("productCount", productCount);
		System.out.printf("total count: %d\n",productCount);
		
		return "product/search";
	}
	
	@GetMapping("upload")
	public String upload(Model model, HttpSession session, String gu) {
		String userId = (String) session.getAttribute("userId");
		if(userId == null) {
			return "redirect:/users/login";
		}
		
		model.addAttribute("selectedGu", (gu==null)?"전체":gu);
		Member member = service.getMember(userId);
		List<String> guList = service.getGuList();

		model.addAttribute("member", member);
		model.addAttribute("guList", guList);
		return "product/upload";
	}
	
	@PostMapping("upload")
	public String createProduct(@ModelAttribute Product product,MultipartHttpServletRequest files, HttpSession session) {
		String uploadFolder = "C:\\Users\\wlsgh\\Desktop\\ZINO\\Spring\\sts-workspace\\TJHPrj\\src\\main\\webapp\\WEB-INF\\static\\uploadImages";
		List<MultipartFile> fileList = files.getFiles("files"); 
		String filenames = "";
		for(int i=0; i<fileList.size(); i++) {
			// 확장자 분리
			MultipartFile file = fileList.get(i);
			String originalFileName = file.getOriginalFilename();
			String fileExtension = originalFileName.substring(originalFileName.indexOf('.'));
			// uuid 이름 생성
			UUID uuid = UUID.randomUUID();
			String storedName = uuid.toString().replaceAll("-", "") + fileExtension;
			// 적재
			File uploadFile = new File(uploadFolder+"\\"+storedName);
			try {
				file.transferTo(uploadFile);
				if(i<fileList.size()-1) 
					filenames += storedName + " ";
				else
					filenames += storedName;
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		product.setFilenames(filenames);
		int result = service.createProduct(product);
		
		return "redirect:/";
	}
}
