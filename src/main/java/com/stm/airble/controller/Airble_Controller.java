package com.stm.airble.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.stm.airble.service.Airble_Service;

@Controller
public class Airble_Controller {
	
	@Autowired
	private Airble_Service service;
	
	
	@RequestMapping(value = "/airble_test")
	public String airble_test() throws Exception {
		
		return "airble_test";
	}
	
	
	@RequestMapping(value = "/airble")
	public String airble() throws Exception {
		
		return "airble";
	}

}
