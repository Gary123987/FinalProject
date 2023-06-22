package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.Continent;

public interface ContinentService {
	public List<Continent> index(String username);

	public Continent show(String username, int tid);

	public Continent create(String username, Continent todo);

	public Continent update(String username, int tid, Continent todo);

	public boolean destroy(String username, int tid);

}
