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
	private CountryRepository repo;

	@Override
	public List<Country> index() {
		return repo.findAll();
	}

}
