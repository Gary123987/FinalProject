package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.Blog;

public interface BlogRepository extends JpaRepository<Blog, Integer> {
	Blog findById(int id);

}
