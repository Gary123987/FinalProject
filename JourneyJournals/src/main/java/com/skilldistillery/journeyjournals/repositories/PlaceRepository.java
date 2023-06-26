package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.Place;

public interface PlaceRepository extends JpaRepository<Place, Integer> {
	Place findById(int id);
	Place findByUser_UsernameAndId(String username, int placeId);
}
