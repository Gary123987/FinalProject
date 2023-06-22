package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.Destination;

public interface DestinationService {
	public List<Destination> index(String username);

	public Destination show(String username, int tid);

	public Destination create(String username, Destination todo);

	public Destination update(String username, int tid, Destination todo);

	public boolean destroy(String username, int tid);

}
