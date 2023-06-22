package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.Comment;

public interface CommentService {
	public List<Comment> index(String username);

	public Comment show(String username, int tid);

	public Comment create(String username, Comment todo);

	public Comment update(String username, int tid, Comment todo);

	public boolean destroy(String username, int tid);

}
