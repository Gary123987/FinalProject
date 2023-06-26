package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Destination;
import com.skilldistillery.journeyjournals.entities.User;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public List<User> index() {
		return userRepo.findAll();
	}

	@Override
	public User show(String username, int id) {
		User user = userRepo.findByUsernameAndId(username, id);
		if (user == null) {
			return null;
		}
		return user;
	}

	@Override
	public User create(String username, User user) {
		return null;
	}

	@Override
	public User update(String username, int id, User user) {
		if (userRepo.existsById(id)) {
			User updated = userRepo.findByUsernameAndId(username, id);
			if (updated != null) {
				updated.setUsername(user.getUsername());
				updated.setFirstName(user.getFirstName());
				updated.setLastName(user.getLastName());	
				updated.setAbout(user.getAbout());
				updated.setImageUrl(user.getImageUrl());
				return userRepo.saveAndFlush(updated);
			}
		}
		return null;
	}

	@Override
	public boolean destroy(String username, int id) {
	User user = userRepo.findByUsernameAndId(username, id);
		user.setEnabled(false);
		return !userRepo.existsById(id);
	}

}
