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

class PlaceTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Place place;

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
		place = em.find(Place.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		place = null;
	}

	@Test
	void test() {
		assertNotNull(place);
		assertEquals(place.getName(), "Los Angeles");
		assertEquals(place.getDestination(), em.find(Destination.class, 1));
		assertEquals(place.getUser(), em.find(User.class, 1));
		assertTrue(place.getImages().contains(em.find(PlaceImage.class, 1)));
		assertEquals(5, place.getRatings().get(0).getRatingValue());
	}
	
	@Test
	void test_one_to_many() {
		assertNotNull(place);
		assertNotNull(place.getBlogs());
		assertTrue(place.getBlogs().size() > 0);
		
		
	}

}
