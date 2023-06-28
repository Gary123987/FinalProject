package com.skilldistillery.journeyjournals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.journeyjournals.entities.Blog;
import com.skilldistillery.journeyjournals.entities.Comment;
import com.skilldistillery.journeyjournals.entities.User;
import com.skilldistillery.journeyjournals.repositories.BlogRepository;
import com.skilldistillery.journeyjournals.repositories.CommentRepository;
import com.skilldistillery.journeyjournals.repositories.UserRepository;
@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private CommentRepository repo;
	
	@Autowired
	private BlogRepository blogRepo;


	@Override
	public List<Comment> indexByUser(String username) {
		return repo.findByUser(username);
	}
	
	@Override
	public List<Comment> indexByBlog(int bid) {
		Blog blog = blogRepo.findById(bid);
		return repo.findByBlog(blog);
	}

	@Override
	public Comment show(int id) {
		return repo.findById(id);
	}

	@Override
	public Comment create(String username, Comment comment) {
		User user = userRepo.findByUsername(username);
		user.addComment(comment);
		comment.setUser(user);
		return repo.saveAndFlush(comment);
	}

	@Override
	public Comment update(String username, int tid, Comment comment) {
		User user = userRepo.findByUsername(username);
		Comment oldComment = repo.findById(tid);
		if (user != oldComment.getUser()) {
			return null;
		}
		oldComment.setBody(comment.getBody());
		oldComment.setTitle(comment.getTitle());
		return repo.saveAndFlush(oldComment);
	}

	@Override
	public boolean destroy(String username, int tid) {
		User user = userRepo.findByUsername(username);
		Comment comment = repo.findById(tid);
		if (user == comment.getUser()) {
			repo.delete(comment);
			return true;
		}
		return false;
	}

}
