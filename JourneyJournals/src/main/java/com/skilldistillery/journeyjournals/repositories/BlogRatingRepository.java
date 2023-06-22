package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.BlogRating;

public interface BlogRatingRepository extends JpaRepository<BlogRating, Integer> {
	BlogRating findById(int id);
}
