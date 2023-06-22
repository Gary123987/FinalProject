package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.PlaceImage;
import com.skilldistillery.journeyjournals.repositories.PlaceImageRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class PlaceImageServiceImpl implements PlaceImageService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private PlaceImageRepository repo;

	@Override
	public List<PlaceImage> index(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PlaceImage show(String username, int tid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PlaceImage create(String username, PlaceImage todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PlaceImage update(String username, int tid, PlaceImage todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int tid) {
		// TODO Auto-generated method stub
		return false;
	}

}
