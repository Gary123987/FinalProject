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

class ContinentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Continent continent;

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
		continent = em.find(Continent.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		continent = null;
	}

	@Test
	void test() {
		assertNotNull(continent);
		assertEquals(continent.getName(), "North America");
		assertTrue(continent.getCountries().contains(em.find(Country.class, 1)));
	}

}
