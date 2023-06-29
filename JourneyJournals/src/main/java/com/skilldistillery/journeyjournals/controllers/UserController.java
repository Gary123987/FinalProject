package com.skilldistillery.journeyjournals.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	@GetMapping("usersName")
	private User findByUsername(HttpServletResponse res, Principal principal) {
		User u = service.findByUsername(principal.getName());
		if(u == null) {
			res.setStatus(404);
		}
		return u;
	}
	
	@GetMapping("users/{id}")
	private User ShowById(HttpServletResponse res, @PathVariable int id) {
		User u = service.show(id);
		if(u == null) {
			res.setStatus(404);
		}
		return u;
	}
	
	@PutMapping("users/{id}")
	private User updateUser( HttpServletResponse res, @PathVariable int id, @RequestBody User user, Principal principal) {
		try {
			user = service.update(id, user);
			res.setStatus(202);
			return user;
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			return null;
		}
	}
	@PutMapping("users/{id}/toggle")
	private User toggleUser( HttpServletResponse res, @PathVariable int id) {
		try {
		User user = service.toggleUserEnabled(id);
			res.setStatus(202);
			return user;
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			return null;
		}
	}
	
}
