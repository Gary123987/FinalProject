package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.Blog;

public interface BlogService {
	public List<Blog> index(String username);

	public Blog show(String username, int tid);

	public Blog create(String username, Blog todo);

	public Blog update(String username, int tid, Blog todo);

	public boolean destroy(String username, int tid);

}
