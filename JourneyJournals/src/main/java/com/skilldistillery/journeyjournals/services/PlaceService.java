package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.Place;


public interface PlaceService {
	public List<Place> index();
	
	public List<Place> indexByUser(String username);

	public Place show(String username, int id);

	public Place create(String username, Place place, int destinationId);

	public Place update(String username, int id, Place palce);

	public boolean destroy(String username, int id);

}
