package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Country;
import com.skilldistillery.journeyjournals.repositories.CountryRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class CountryServiceImpl implements CountryService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private CountryRepository repo;

	@Override
	public List<Country> index(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Country show(String username, int tid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Country create(String username, Country todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Country update(String username, int tid, Country todo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int tid) {
		// TODO Auto-generated method stub
		return false;
	}

}
