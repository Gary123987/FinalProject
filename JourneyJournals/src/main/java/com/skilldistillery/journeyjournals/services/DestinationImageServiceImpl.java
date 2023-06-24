package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Destination;
import com.skilldistillery.journeyjournals.entities.DestinationImage;
import com.skilldistillery.journeyjournals.entities.User;
import com.skilldistillery.journeyjournals.repositories.DestinationImageRepository;
import com.skilldistillery.journeyjournals.repositories.DestinationRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;

@Service
public class DestinationImageServiceImpl implements DestinationImageService {

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private DestinationRepository desRepo;

	@Autowired
	private DestinationImageRepository repo;

	@Override
	public List<DestinationImage> index(String username) {
		return repo.findByUser_Username(username);
	}

	@Override
	public List<DestinationImage> index() {
		return repo.findAll();
	}

	@Override
	public DestinationImage show(String username, int id) {
		DestinationImage image = repo.findByUser_UsernameAndId(username, id);
		if (image == null) {
			return null;
		}
		return image;
	}

	@Override
	public DestinationImage create(String username, DestinationImage image, int id) {
		User user = userRepo.findByUsername(username);
		if (user != null) {
			Destination des = desRepo.findById(id);
			image.setDestination(des);
			image.setUser(user);
			return repo.saveAndFlush(image);
		}
		return null;
	}

	@Override
	public DestinationImage update(String username, int id, DestinationImage image) {
		if (repo.existsById(id)) {
			DestinationImage update = repo.findByUser_UsernameAndId(username, id);
			if (update != null) {
				update.setImageUrl(image.getImageUrl());
				return repo.saveAndFlush(update);
			}
		}
		return null;
	}

	@Override
	public boolean destroy(String username, int id) {
		repo.deleteById(id);
		return !repo.existsById(id);
	}

}
