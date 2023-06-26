package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.PlaceImage;


public interface PlaceImageService {
	public List<PlaceImage> index(String username);

	public List<PlaceImage> index();
	
	public PlaceImage show(String username, int id);

	public PlaceImage create(String username, PlaceImage placeImage, int id);

	public PlaceImage update(String username, int id, PlaceImage placeImage);

	public boolean destroy(String username, int id);


}
