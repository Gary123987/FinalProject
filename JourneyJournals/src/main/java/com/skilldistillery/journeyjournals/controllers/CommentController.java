package com.skilldistillery.journeyjournals.controllers;

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
	
	@GetMapping("commentUser/{username}")
	private List<Comment> getCommentsByUser (@PathVariable String username) {
		User user = userServ.findByUsername(username);
		return user.getComments();
	}
	
	@GetMapping("commentBlog/{bid}")
	private List<Comment> getCommentsByBlog (@PathVariable int bid) {
		return commentServ.indexByBlog(bid);
	}
	
	@PostMapping("comment/create/{username}")
	private Comment createComment (@RequestBody Comment comment, @PathVariable String username) {
		return commentServ.create(username, comment);
	}
	
	@PutMapping("comment/update/{username}/{id}") 
	private Comment updateComment(@PathVariable String username, @PathVariable int id, @RequestBody Comment comment) {
		return commentServ.update(username, id, comment);
	}
	
	@DeleteMapping("comment/delete/{username}/{id}")
	private void deleteComment(@PathVariable String username, @PathVariable int id, HttpServletResponse res) {
		boolean b = commentServ.destroy(username, id);
		if (!b) {
			res.setStatus(400);
		}
	}

}
