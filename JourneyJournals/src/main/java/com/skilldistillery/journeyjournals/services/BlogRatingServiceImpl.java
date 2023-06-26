package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Blog;
import com.skilldistillery.journeyjournals.entities.BlogRating;
import com.skilldistillery.journeyjournals.entities.BlogRatingId;
import com.skilldistillery.journeyjournals.repositories.BlogRatingRepository;
import com.skilldistillery.journeyjournals.repositories.BlogRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;

@Service
public class BlogRatingServiceImpl implements BlogRatingService {

	@Autowired
	private BlogRatingRepository repo;

	@Autowired
	private BlogRepository blogRepo;

	@Override
	public List<BlogRating> ratingByBlogId(int blogId) {
		Blog blog = blogRepo.findById(blogId);
		return blog.getRatings();
	}

	@Override
	public List<BlogRating> index(String username) {
		return repo.findByUser_Username(username);
	}

	@Override
	public List<BlogRating> index() {
		return repo.findAll();
	}

	@Override
	public BlogRating findById(int id) {
		return repo.findById(id);
	}

	@Override
	public BlogRating create(int blogId, int userId, BlogRating blogRating) {
		BlogRatingId ratingId = new BlogRatingId(blogId, userId);
		blogRating.setId(ratingId);
		return repo.saveAndFlush(blogRating);

	}

	@Override
	public double averageRatingByBlogId(int blogId) {
		Blog blog = blogRepo.findById(blogId);
		double averageRating = 0.0;

		if (blog != null) {
			List<BlogRating> ratings = blog.getRatings();
			int sum = 0;

			for (BlogRating blogRating : ratings) {
				int value = blogRating.getRatingValue();
				sum += value;
			}

			if (!ratings.isEmpty()) {
				averageRating = sum / ratings.size();
			}
		}

		return averageRating;
	}

	@Override
	public BlogRating update(String username, int id, BlogRating rating) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int id) {
		// TODO Auto-generated method stub
		return false;
	}

}
