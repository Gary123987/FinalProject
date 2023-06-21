package com.skilldistillery.journeyjournals.services;

import com.skilldistillery.journeyjournals.entities.User;

public interface AuthService {
	public User register(User user);
	public User getUserByUsername(String username);

}
