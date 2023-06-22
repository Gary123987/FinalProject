package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.PlaceRating;

public interface PlaceRatingRepository extends JpaRepository<PlaceRating, Integer> {
		PlaceRating findById(int id);
}
