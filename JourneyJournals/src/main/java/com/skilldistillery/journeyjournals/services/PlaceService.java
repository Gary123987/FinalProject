package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.Place;


public interface PlaceService {
	public List<Place> index(String username);

	public Place show(String username, int tid);

	public Place create(String username, Place todo);

	public Place update(String username, int tid, Place todo);

	public boolean destroy(String username, int tid);

}
