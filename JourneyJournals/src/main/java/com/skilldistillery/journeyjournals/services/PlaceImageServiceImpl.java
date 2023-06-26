package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Place;
import com.skilldistillery.journeyjournals.entities.PlaceImage;
import com.skilldistillery.journeyjournals.entities.User;
import com.skilldistillery.journeyjournals.repositories.PlaceImageRepository;
import com.skilldistillery.journeyjournals.repositories.PlaceRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class PlaceImageServiceImpl implements PlaceImageService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private PlaceImageRepository repo;
	
	@Autowired
	private PlaceRepository placeRepo;

	@Override
	public List<PlaceImage> index(String username) {
		return repo.findByUser_Username(username);
	}
	
	@Override
	public List<PlaceImage> index() {
		return repo.findAll();
	}

	@Override
	public PlaceImage show(String username, int id) {
		PlaceImage image = repo.findByUser_UsernameAndId(username, id);
		if(image == null) {
			return null;
		}
		return image;
	}

	@Override
	public PlaceImage create(String username, PlaceImage placeImage, int id) {
		User user = userRepo.findByUsername(username);
		if(user != null) {
			Place place = placeRepo.findById(id);
			placeImage.setPlace(place);
			placeImage.setUser(user);
			return repo.saveAndFlush(placeImage);
		}
		return null;
	}

	@Override
	public PlaceImage update(String username, int id, PlaceImage placeImage) {
		if(repo.existsById(id)) {
			PlaceImage image = repo.findByUser_UsernameAndId(username, id);
			if (image != null) {
				image.setImageUrl(placeImage.getImageUrl());
				return repo.saveAndFlush(image);
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
