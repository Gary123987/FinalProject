package com.skilldistillery.journeyjournals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.PlaceImage;

public interface PlaceImageRepository extends JpaRepository<PlaceImage, Integer> {
	PlaceImage findById(int id);
	List<PlaceImage> findByUser_Username(String username);
	PlaceImage findByUser_UsernameAndId(String username, int id);

}
