package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.Destination;

public interface DestinationRepository extends JpaRepository<Destination, Integer> {
	Destination findById(int id);
}
