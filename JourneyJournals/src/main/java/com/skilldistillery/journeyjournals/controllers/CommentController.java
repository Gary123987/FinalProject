package com.skilldistillery.journeyjournals.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.journeyjournals.entities.Comment;
import com.skilldistillery.journeyjournals.entities.User;
import com.skilldistillery.journeyjournals.services.BlogService;
import com.skilldistillery.journeyjournals.services.CommentService;
import com.skilldistillery.journeyjournals.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class CommentController {
	
	@Autowired
	private UserService userServ;
	
	@Autowired
	private CommentService commentServ;
	
	@Autowired BlogService blogServ;
	
	@GetMapping("commentUser/{username}")
	private List<Comment> getCommentsByUser (@PathVariable String username) {
		User user = userServ.findByUsername(username);
		return user.getComments();
	}

}
