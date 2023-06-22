package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.Continent;

public interface ContinentRepositoy extends JpaRepository<Continent, Integer> {
	Continent findById(int id);
}
