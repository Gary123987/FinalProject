package com.skilldistillery.journeyjournals.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.LocalDateTime;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class DestinationImageTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private DestinationImage destinationImage;

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
		destinationImage = em.find(DestinationImage.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		destinationImage = null;
	}

	@Test
	void test() {
		assertNotNull(destinationImage);
		assertEquals(destinationImage.getCreatedAt().getYear(), 2023);
		assertEquals(destinationImage.getDestination(), em.find(Destination.class, 1));
		assertEquals(destinationImage.getUser(), em.find(User.class, 1));
	}
	


}
