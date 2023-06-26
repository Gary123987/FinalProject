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

import com.skilldistillery.journeyjournals.entities.Blog;
import com.skilldistillery.journeyjournals.services.BlogService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class BlogController {
	
	@Autowired
	private BlogService blogServ;
	
	@GetMapping("blogsUser")
	private List<Blog> findBlogsByUser(HttpServletResponse res, Principal principal) {
		List<Blog> blogs = blogServ.indexByUser(principal.getName());
		
		if (blogs == null) {
			res.setStatus(404);
			return null;
		}
		return blogs;
	}
	
	@GetMapping("blogsAll")
	private List<Blog> findAllBlogs() {
		return blogServ.index();
	}
	
	@GetMapping("blogs/{id}")
	private Blog findBlogById(@PathVariable int id, HttpServletResponse res) {
		Blog blog = blogServ.show(id);
		if(blog == null) {
			res.setStatus(404);
			return null;
		}
		return blog;
	}
	
	@PostMapping("blogsCreate/{id}/place")
	private Blog createBlogs(@RequestBody Blog blog, Principal principal, HttpServletResponse res, @PathVariable("id") int placeId) {
		try {
			Blog blogCreated = blogServ.create(principal.getName(), blog, placeId);
			return blogCreated;
		} catch (Exception e) {
			e.printStackTrace(); 
			res.setStatus(400);
			return null;
		}	
	}
	
	@PutMapping("blogsUpdate/{id}")
	private Blog updateBlogs(@RequestBody Blog blog, Principal principal, HttpServletResponse res, @PathVariable int id) {
		 Blog newBlog = blogServ.update(principal.getName(), id, blog);
		 if (newBlog == null) {
			 res.setStatus(401);
			 return newBlog;
		 }
		 return newBlog;
	}
	
	@DeleteMapping("blogsDelete/{id}")
	private void deleteBlogs(@PathVariable int id, Principal principal, HttpServletResponse res) {
		boolean worked = blogServ.destroy(principal.getName(), id);
		if (worked) {
			res.setStatus(200);
		} else {
			res.setStatus(400);
		}
	}
	
	
	
	
	
	
	
	
}
