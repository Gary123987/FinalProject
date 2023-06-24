package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.DestinationImage;

public interface DestinationImageService {
	
	public List<DestinationImage> index(String username);

	public DestinationImage show(String username, int id);

	public DestinationImage create(String username, DestinationImage image);

	public DestinationImage update(String username, int id, DestinationImage image);

	public boolean destroy(String username, int id);


}
