package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.Continent;

public interface ContinentRepository extends JpaRepository<Continent, Integer> {
	Continent findById(int id);
}
