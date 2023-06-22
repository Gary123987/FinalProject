package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.PlaceRating;
import com.skilldistillery.journeyjournals.repositories.PlaceRatingRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class PlaceRatingServiceImpl implements PlaceRatingService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private PlaceRatingRepository repo;

	@Override
	public List<PlaceRating> index(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PlaceRating show(String username, int tid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PlaceRating create(String username, PlaceRating todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PlaceRating update(String username, int tid, PlaceRating todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int tid) {
		// TODO Auto-generated method stub
		return false;
	}

}
