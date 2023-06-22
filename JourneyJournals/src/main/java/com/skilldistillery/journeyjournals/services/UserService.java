package com.skilldistillery.journeyjournals.services;

import java.util.Set;

import com.skilldistillery.journeyjournals.entities.User;

public interface UserService {
	public Set<User> index(String username);

	public User show(String username, int tid);

	public User create(String username, User todo);

	public User update(String username, int tid, User todo);

	public boolean destroy(String username, int tid);

}
