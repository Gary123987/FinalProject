package com.skilldistillery.journeyjournals.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.journeyjournals.entities.Destination;
import com.skilldistillery.journeyjournals.entities.User;
import com.skilldistillery.journeyjournals.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class UserController {

	@Autowired
	private UserService service;
	
	@GetMapping("users")
	private List<User> listOfUser(HttpServletResponse res) {
		List<User> user = service.index();
		if(user == null) {
			res.setStatus(404);
			return null;
		}
		return user;
	}
	
	@GetMapping("users/{id}")
	private User ShowById(HttpServletResponse res, @PathVariable int id, Principal principal) {
		User u = service.show(principal.getName(), id);
		if(u == null) {
			res.setStatus(404);
		}
		return u;
	}
}
