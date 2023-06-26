package com.skilldistillery.journeyjournals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.DestinationImage;

public interface DestinationImageRepository extends JpaRepository<DestinationImage, Integer> {
	DestinationImage findById(int id);
	
	List<DestinationImage> findByUser_Username(String username);
	
	DestinationImage findByUser_UsernameAndId(String username, int id);

}
