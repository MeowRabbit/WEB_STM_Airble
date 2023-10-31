package com.stm.airble.controller;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.stm.airble.service.Airble_Service;

@Controller
public class User_Page_Controller {
	
	@Autowired
	private Airble_Service service;
	
	
	/**
	 * Header 관련 페이지 이동
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/product/airble")
	public String product_airble() throws Exception {
		
		return "_2_product/airble";
	}
	
	@RequestMapping(value = "/product/airble_s")
	public String product_airble_s() throws Exception {
		
		return "_2_product/airble_s";
	}
	
	@RequestMapping(value = "/customer/service")
	public String customer_service() throws Exception {
		
		return "_3_customer/service";
	}
	
	@RequestMapping(value = "/customer/notice")
	public String customer_notice() throws Exception {
		
		return "_3_customer/notice";
	}
	
	@RequestMapping(value = "/customer/notice/page")
	public String notice_page(HttpServletRequest request) throws Exception {
		System.out.println("load page_num = " + request.getParameter("num"));
		
		request.setAttribute("title", "공지사항");
		request.setAttribute("item_num", request.getParameter("num"));
		
		return "_0_public/article";
	}
	
	@RequestMapping(value = "/event")
	public String event() throws Exception {
		
		return "_4_event/event";
	}
	
	@RequestMapping(value = "/event/page")
	public String event_page(HttpServletRequest request) throws Exception {
		System.out.println("load page_num = " + request.getParameter("num"));
		
		request.setAttribute("title", "EVENT");
		request.setAttribute("item_num", request.getParameter("num"));
		
		return "_0_public/article";
	}
	
	
	/**
	 * Footer 관련 페이지 이동
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/privacy_policy")
	public String privacy_policy() throws Exception {
		
		return "_0_public/privacy_policy";
	}
	
	@RequestMapping(value = "/terms_of_service")
	public String terms_of_service() throws Exception {

		return "_0_public/terms_of_service";
	}
	
	
	/**
	 * Redirect 관련 페이지 이동
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/re/airble")
	public String re_airble() throws Exception {
		
		return "redirect:/product/airble";
	}

}
