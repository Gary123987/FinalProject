package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.User;

public interface UserService {
	public List<User> index();

	public User show(int id);

	public User create(String username, User user);

	public User update( int id, User user);
	
	public User toggleUserEnabled(int id);

	public boolean destroy(String username, int id);
	User findByUsername(String username);

}
