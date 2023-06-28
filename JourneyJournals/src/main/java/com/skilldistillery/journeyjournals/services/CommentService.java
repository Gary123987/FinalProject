package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.Comment;

public interface CommentService {
	public List<Comment> indexByUser(String username);
	
	public List<Comment> indexByBlog(int bid);

	public Comment show(int tid);

	public Comment create(String username, Comment todo);

	public Comment update(String username, int tid, Comment todo);

	public boolean destroy(String username, int tid);

}
