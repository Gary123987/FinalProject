package com.skilldistillery.journeyjournals.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	@Autowired
	private BlogService blogServ;
	
	@GetMapping("commentUser")
	private List<Comment> getCommentsByUser (Principal principal) {
		User user = userServ.findByUsername(principal.getName());
		return user.getComments();
	}
	
	@GetMapping("commentBlog/{bid}")
	private List<Comment> getCommentsByBlog (@PathVariable int bid) {
		return commentServ.indexByBlog(bid);
	}
	
	@PostMapping("comment/create")
	private Comment createComment (@RequestBody Comment comment, Principal principal) {
		return commentServ.create(principal.getName(), comment);
	}
	
	@PutMapping("comment/update/{id}") 
	private Comment updateComment(@PathVariable int id, @RequestBody Comment comment) {
		return commentServ.update(id, comment);
	}
	
	@DeleteMapping("comment/delete/{id}")
	private void deleteComment(@PathVariable int id, HttpServletResponse res, Principal principal) {
		boolean b = commentServ.destroy(principal.getName(), id);
		if (!b) {
			res.setStatus(400);
		}
	}

}
