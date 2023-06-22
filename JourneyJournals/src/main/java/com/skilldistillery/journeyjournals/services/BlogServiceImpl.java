package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Blog;
import com.skilldistillery.journeyjournals.repositories.BlogRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class BlogServiceImpl implements BlogService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private BlogRepository repo;


	@Override
	public List<Blog> index(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Blog show(String username, int tid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Blog create(String username, Blog todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Blog update(String username, int tid, Blog todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int tid) {
		// TODO Auto-generated method stub
		return false;
	}

}
