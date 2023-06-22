package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.Category;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
	Category findById(int id);
}
