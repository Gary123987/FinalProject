package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.BlogRating;

public interface BlogRatingService {
	public List<BlogRating> index(String username);

	public BlogRating show(String username, int tid);

	public BlogRating create(String username, BlogRating todo);

	public BlogRating update(String username, int tid, BlogRating todo);

	public boolean destroy(String username, int tid);


}
