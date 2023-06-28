package com.skilldistillery.journeyjournals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.journeyjournals.entities.Blog;
import com.skilldistillery.journeyjournals.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {
	
	List<Comment> findByUser(String username);
	
	Comment findById(int id);
	
	List<Comment> findByBlog(Blog blog);

}
