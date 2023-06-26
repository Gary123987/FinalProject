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
	private ContinentRepository repo;

	@Override
	public List<Continent> index() {
		return repo.findAll();
	}



}
