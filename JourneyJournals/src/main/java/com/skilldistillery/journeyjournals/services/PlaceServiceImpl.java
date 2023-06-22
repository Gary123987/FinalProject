package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Place;
import com.skilldistillery.journeyjournals.repositories.PlaceRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class PlaceServiceImpl implements PlaceService {
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private PlaceRepository repo;

	@Override
	public List<Place> index(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Place show(String username, int tid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Place create(String username, Place todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Place update(String username, int tid, Place todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int tid) {
		// TODO Auto-generated method stub
		return false;
	}

}
