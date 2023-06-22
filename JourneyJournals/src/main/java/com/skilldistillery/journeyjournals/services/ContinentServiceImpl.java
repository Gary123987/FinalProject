package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Continent;
import com.skilldistillery.journeyjournals.repositories.ContinentRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class ContinentServiceImpl implements ContinentService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private ContinentRepository repo;

	@Override
	public List<Continent> index(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Continent show(String username, int tid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Continent create(String username, Continent todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Continent update(String username, int tid, Continent todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int tid) {
		// TODO Auto-generated method stub
		return false;
	}

}
