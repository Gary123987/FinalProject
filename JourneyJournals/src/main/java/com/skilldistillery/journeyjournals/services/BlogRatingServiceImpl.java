package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.BlogRating;
import com.skilldistillery.journeyjournals.repositories.BlogRatingRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class BlogRatingServiceImpl implements BlogRatingService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private BlogRatingRepository repo;


	@Override
	public List<BlogRating> index(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BlogRating show(String username, int tid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BlogRating create(String username, BlogRating todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BlogRating update(String username, int tid, BlogRating todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int tid) {
		// TODO Auto-generated method stub
		return false;
	}

}
