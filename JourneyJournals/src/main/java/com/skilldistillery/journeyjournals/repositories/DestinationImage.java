package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

public interface DestinationImage extends JpaRepository<DestinationImage, Integer> {
	DestinationImage findById(int id);
}
