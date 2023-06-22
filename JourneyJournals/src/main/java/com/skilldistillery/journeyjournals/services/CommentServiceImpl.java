package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Comment;
import com.skilldistillery.journeyjournals.repositories.CommentRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private CommentRepository repo;


	@Override
	public List<Comment> index(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Comment show(String username, int tid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Comment create(String username, Comment todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Comment update(String username, int tid, Comment todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int tid) {
		// TODO Auto-generated method stub
		return false;
	}

}
