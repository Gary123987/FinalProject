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

class PlaceRatingTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private PlaceRating placeRating;

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
		placeRating = em.find(PlaceRating.class, new PlaceRatingId(1, 1));
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		placeRating = null;
	}

	@Test
	void test() {
		assertNotNull(placeRating);
		assertEquals(placeRating.getPlace(), em.find(Place.class, 1));
		assertEquals(placeRating.getRatingValue(), 5);
		assertEquals(placeRating.getUser(), em.find(User.class, 1));
	}

}
