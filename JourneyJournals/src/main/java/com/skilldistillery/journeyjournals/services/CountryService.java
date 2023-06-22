package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.Country;

public interface CountryService {
	public List<Country> index(String username);

	public Country show(String username, int tid);

	public Country create(String username, Country todo);

	public Country update(String username, int tid, Country todo);

	public boolean destroy(String username, int tid);

}
