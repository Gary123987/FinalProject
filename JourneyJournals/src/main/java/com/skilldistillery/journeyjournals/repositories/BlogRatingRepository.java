package com.skilldistillery.journeyjournals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.BlogRating;

public interface BlogRatingRepository extends JpaRepository<BlogRating, Integer> {
	BlogRating findById(int id);
	
	List<BlogRating> findByUser_Username(String username);
	
	BlogRating findByUser_UsernameAndId(String username, int id);
}
