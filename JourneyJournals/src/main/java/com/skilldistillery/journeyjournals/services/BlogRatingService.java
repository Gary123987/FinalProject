package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.BlogRating;

public interface BlogRatingService {
	
	public List<BlogRating> ratingByBlogId(int blogId);
	
	public List<BlogRating> index(String username);
	
	public List<BlogRating> index();

	public BlogRating findById(int id);

	public double averageRatingByBlogId(int blogId);

	public BlogRating create(int blogId, int userId, BlogRating blogRating);

	public BlogRating update(String username, int id, BlogRating rating);

	public boolean destroy(String username, int id);


}
