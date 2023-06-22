package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.Country;

public interface CountryRepository extends JpaRepository<Country, Integer> {
	Country findById(int id);
}
