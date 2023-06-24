package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.Destination;

public interface DestinationService {
	public List<Destination> index(String username);

	public Destination show(String username, int id);

	public Destination create(String username, Destination des);

	public Destination update(String username, int id, Destination des);

	public boolean destroy(String username, int id);

}
