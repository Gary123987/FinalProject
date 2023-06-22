package com.skilldistillery.journeyjournals.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class BlogRatingTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private BlogRating blogRating;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAjourneyJournals");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		blogRating = em.find(BlogRating.class, new BlogRatingId(1, 1));
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		blogRating = null;
	}

	@Test
	void test() {
		assertNotNull(blogRating);
		assertEquals(blogRating.getBlog(), em.find(Blog.class, 1));
		assertEquals(blogRating.getRatingValue(), 5);
		assertEquals(blogRating.getUser(), em.find(User.class, 1));
	}

}
