package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.DestinationImage;

public interface DestinationImageRepository extends JpaRepository<DestinationImage, Integer> {
	DestinationImage findById(int id);
}
