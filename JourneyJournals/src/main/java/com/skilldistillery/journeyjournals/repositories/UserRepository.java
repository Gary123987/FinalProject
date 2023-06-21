package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	User findById(int id);

	User findByUsername(String username);

}
