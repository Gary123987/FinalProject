package com.skilldistillery.journeyjournals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

}
