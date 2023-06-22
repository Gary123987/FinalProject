package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Category;
import com.skilldistillery.journeyjournals.repositories.CategoryRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class CategoryServiceImpl implements CategoryService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private CategoryRepository repo;


	@Override
	public List<Category> index(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Category show(String username, int tid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Category create(String username, Category todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Category update(String username, int tid, Category todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int tid) {
		// TODO Auto-generated method stub
		return false;
	}

}
