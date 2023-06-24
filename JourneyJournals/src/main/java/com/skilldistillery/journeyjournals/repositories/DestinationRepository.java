package com.skilldistillery.journeyjournals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.Destination;

public interface DestinationRepository extends JpaRepository<Destination, Integer> {
	Destination findById(int id);
	
	List<Destination> findByUserCreated_Username(String Username);
	
	Destination findByUserCreated_UsernameAndId(String username, int id);
}
