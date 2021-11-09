package com.knock.taxi.controllers;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(produces = MediaType.APPLICATION_JSON_VALUE)
public class HelloWorldController {
	
	@GetMapping(value = "/public/helloworld")
	public String PublicHello() {

		return "Hello from the public API";
	}
	
	@GetMapping(value = "/private/helloworld")
	public String PrivateHello() {
		return "Hello from the private API";
	}
}
