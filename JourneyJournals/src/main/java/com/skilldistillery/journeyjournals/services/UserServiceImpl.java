package com.skilldistillery.journeyjournals.services;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.User;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public Set<User> index(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User show(String username, int tid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User create(String username, User todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User update(String username, int tid, User todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int tid) {
		// TODO Auto-generated method stub
		return false;
	}

}
