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

class DestinationTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Destination destination;

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
		destination = em.find(Destination.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		destination = null;
	}

	@Test
	void test() {
		assertNotNull(destination);
		assertEquals(destination.getName(), "Los Angeles");
		assertEquals(destination.getCountry(), em.find(Country.class, 1));
		assertEquals(destination.getUserCreated(), em.find(User.class, 1));
		assertTrue(destination.getUsersFavorited().contains(em.find(User.class, 1)));
		assertTrue(destination.getImages().contains(em.find(DestinationImage.class, 1)));
		assertTrue(destination.getPlaces().contains(em.find(Place.class, 1)));
	}

}
