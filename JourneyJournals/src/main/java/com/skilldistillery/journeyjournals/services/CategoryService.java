package com.skilldistillery.journeyjournals.services;

import java.util.List;

import com.skilldistillery.journeyjournals.entities.Category;

public interface CategoryService {
	public List<Category> index(String username);

	public Category show(String username, int tid);

	public Category create(String username, Category todo);

	public Category update(String username, int tid, Category todo);

	public boolean destroy(String username, int tid);

}
