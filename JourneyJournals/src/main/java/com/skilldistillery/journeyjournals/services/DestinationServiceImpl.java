package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Destination;
import com.skilldistillery.journeyjournals.repositories.DestinationRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class DestinationServiceImpl implements DestinationService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private DestinationRepository repo;

	@Override
	public List<Destination> index(String username) {
		return repo.findByUserCreated_Username(username);
	}

	@Override
	public Destination show(String username, int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Destination create(String username, Destination des) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Destination update(String username, int id, Destination des) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int id) {
		// TODO Auto-generated method stub
		return false;
	}

}
