package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.PlaceImage;


public interface PlaceImageService {
	public List<PlaceImage> index(String username);

	public PlaceImage show(String username, int tid);

	public PlaceImage create(String username, PlaceImage todo);

	public PlaceImage update(String username, int tid, PlaceImage todo);

	public boolean destroy(String username, int tid);


}
