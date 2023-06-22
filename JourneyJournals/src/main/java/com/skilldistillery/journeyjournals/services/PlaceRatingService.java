package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.PlaceRating;


public interface PlaceRatingService {
	public List<PlaceRating> index(String username);

	public PlaceRating show(String username, int tid);

	public PlaceRating create(String username, PlaceRating todo);

	public PlaceRating update(String username, int tid, PlaceRating todo);

	public boolean destroy(String username, int tid);


}
