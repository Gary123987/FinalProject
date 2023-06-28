package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Country;
import com.skilldistillery.journeyjournals.entities.Destination;
import com.skilldistillery.journeyjournals.entities.User;
import com.skilldistillery.journeyjournals.repositories.CountryRepository;
import com.skilldistillery.journeyjournals.repositories.DestinationRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;

@Service
public class DestinationServiceImpl implements DestinationService {

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private DestinationRepository repo;
	
	@Autowired
	private CountryRepository countryRepo;

	@Override
	public List<Destination> index(String username) {
		return repo.findByUserCreated_Username(username);
	}
	public List<Destination> index() {
		return repo.findAll();
	}

	@Override
	public Destination show(String username, int id) {
		Destination d = repo.findByUserCreated_UsernameAndId(username, id);
		if (d == null) {
			return null;
		}
		return d;
	}

	@Override
	public Destination create(String username, Destination des, int countryId) {
		User user = userRepo.findByUsername(username);
		if (user != null) {
			Country country = countryRepo.findById(countryId);
			des.setCountry(country);
			des.setUserCreated(user);
			return repo.saveAndFlush(des);
		}
		return null;
	}
	

	@Override
	public Destination update(String username, int id, Destination des) {
		if (repo.existsById(id)) {
			Destination updated = repo.findByUserCreated_UsernameAndId(username, id);
			if (updated != null) {
				updated.setCity(des.getCity());
				updated.setState(des.getState());
				updated.setName(des.getName());
				updated.setDescription(des.getDescription());
				updated.setImageUrl(des.getImageUrl());
				return repo.saveAndFlush(updated);
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
