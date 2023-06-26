package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.Blog;

public interface BlogService {
	public List<Blog> index();

	public Blog show(int id);

	public Blog create(String username, Blog blog, int placeId);

	public Blog update(String username, int id, Blog blog);

	public boolean destroy(String username, int id);

	List<Blog> indexByUser(String username);

}
