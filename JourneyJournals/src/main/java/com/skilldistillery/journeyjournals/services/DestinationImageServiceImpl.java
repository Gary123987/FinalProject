package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.DestinationImage;
import com.skilldistillery.journeyjournals.repositories.DestinationImageRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class DestinationImageServiceImpl implements DestinationImageService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private DestinationImageRepository repo;

	@Override
	public List<DestinationImage> index(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public DestinationImage show(String username, int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public DestinationImage create(String username, DestinationImage image) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public DestinationImage update(String username, int tid, DestinationImage image) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int id) {
		// TODO Auto-generated method stub
		return false;
	}

}
