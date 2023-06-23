package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Blog;
import com.skilldistillery.journeyjournals.entities.User;
import com.skilldistillery.journeyjournals.repositories.BlogRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class BlogServiceImpl implements BlogService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private BlogRepository blogRepo;


	@Override
	public List<Blog> indexByUser(String username) {
		User user =userRepo.findByUsername(username);
		return user.getBlogs();
	}

	@Override
	public Blog show(int tid) {
		return blogRepo.findById(tid);
	}

	@Override
	public Blog create(String username, Blog blog) {
		User user = userRepo.findByUsername(username);
		if (user != null) {
			blog.setUser(user);
			user.addBlog(blog);
			userRepo.saveAndFlush(user);
			return blogRepo.saveAndFlush(blog);
		}
		return null;
	}

	@Override
	public Blog update(String username, int tid, Blog blog) {
		if (blogRepo.existsById(tid)) {
		User user = userRepo.findByUsername(username);
		Blog b = blogRepo.findById(tid);
		List<Blog> blogs = user.getBlogs();
		if (blogs.contains(b)) {
			b.setCategories(blog.getCategories());
			b.setDescription(blog.getDescription());
			b.setImageUrl(blog.getImageUrl());
			b.setTitle(blog.getTitle());
			b.setTripEnd(blog.getTripEnd());
			b.setTripStart(blog.getTripStart());
			return blogRepo.saveAndFlush(b);
		} 
		}
		return null;
	}

	@Override
	public boolean destroy(String username, int tid) {
		User user = userRepo.findByUsername(username);
		Blog blog = blogRepo.findById(tid);
		List<Blog> blogs = user.getBlogs();
		if (blogs.contains(blog)) {
			blogRepo.delete(blog);
			return true;
		}
		return false;
	}

	@Override
	public List<Blog> index() {
		return blogRepo.findAll();
	}

}
