package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.DestinationImage;

public interface DestinationImageService {
	public List<DestinationImage> index(String username);

	public DestinationImage show(String username, int tid);

	public DestinationImage create(String username, DestinationImage todo);

	public DestinationImage update(String username, int tid, DestinationImage todo);

	public boolean destroy(String username, int tid);


}
