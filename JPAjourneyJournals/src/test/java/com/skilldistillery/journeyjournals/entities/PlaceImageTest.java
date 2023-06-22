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

class PlaceImageTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private PlaceImage placeImage;

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
		placeImage = em.find(PlaceImage.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		placeImage = null;
	}

	@Test
	void test() {
		assertNotNull(placeImage);
		assertEquals(placeImage.getPlace(), em.find(Place.class, 1));
		assertEquals(placeImage.getUser().getFirstName(), "Chip");
	}

}
