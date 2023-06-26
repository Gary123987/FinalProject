package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Destination;
import com.skilldistillery.journeyjournals.entities.Place;
import com.skilldistillery.journeyjournals.entities.User;
import com.skilldistillery.journeyjournals.repositories.DestinationRepository;
import com.skilldistillery.journeyjournals.repositories.PlaceRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class PlaceServiceImpl implements PlaceService {
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private PlaceRepository repo;
	
	@Autowired
	private DestinationRepository destRepo;
	
	@Override
	public List<Place> index() {
		return repo.findAll();
	}

	@Override
	public List<Place> indexByUser(String username) {
		User user = userRepo.findByUsername(username);
		return user.getPlacesCreated();
	}

	@Override
	public Place show(String username, int placeId) {
		Place place = repo.findByUser_UsernameAndId(username, placeId);
		return place;
	}

	@Override
	public Place create(String username, Place place, int id) {
		User user = userRepo.findByUsername(username);
		if (user != null) {
			Destination destination = destRepo.findById(id);
			place.setDestination(destination);
			place.setUser(user);
			return repo.saveAndFlush(place);
		}
		return null;
	}

	@Override
	public Place update(String username, int placeId, Place place) {
		User user = userRepo.findByUsername(username);
		Place updatePlace = repo.findById(placeId);
		
		if (user != null) {
			place.setUser(user);
		}
		if (updatePlace != null) {
			updatePlace.setName(place.getName());
			updatePlace.setStreet(place.getStreet());
			updatePlace.setZipcode(place.getZipcode());
			updatePlace.setDescription(place.getDescription());
			updatePlace.setImageUrl(place.getImageUrl());
			
			return repo.saveAndFlush(updatePlace);
		}
		return null;
	}

	@Override
	public boolean destroy(String username, int placeId) {
		boolean deleted = false;
		
		Place toDelete = repo.findByUser_UsernameAndId(username, placeId);
		if (toDelete != null) {
			repo.deleteById(placeId);
			deleted = true;
		}
		return deleted;
	}

}
