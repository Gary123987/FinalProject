package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.PlaceImage;

public interface PlaceImageRepository extends JpaRepository<PlaceImage, Integer> {
	PlaceImage findById(int id);

}
