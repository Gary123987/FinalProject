package com.skilldistillery.journeyjournals.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.journeyjournals.entities.Continent;
import com.skilldistillery.journeyjournals.entities.Country;
import com.skilldistillery.journeyjournals.entities.Destination;
import com.skilldistillery.journeyjournals.services.ContinentService;
import com.skilldistillery.journeyjournals.services.CountryService;
import com.skilldistillery.journeyjournals.services.DestinationService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class DestinationController {
	
	@Autowired
	private ContinentService continService;
	
	@Autowired
	private CountryService countryService;
	
	@Autowired
	private DestinationService desService;
	
	
	@GetMapping("continents")
	private List<Continent> listOfContinents(HttpServletResponse res) {
		List<Continent> continent = continService.index();
		if(continent == null) {
			res.setStatus(404);
			return null;
		}
		return continent;
	}
	
	@GetMapping("countries")
	private List<Country> listOfCountries(HttpServletResponse res) {
		List<Country> country = countryService.index();
		if(country == null) {
			res.setStatus(404);
			return null;
		}
		return country;
	}
	
	@GetMapping("destinations")
	private List<Destination> listOfDestinations(HttpServletResponse res, Principal principal) {
		List<Destination> des = desService.index(principal.getName());
		if(des == null) {
			res.setStatus(404);
			return null;
		}
		return des;
	}
	@GetMapping("destinationsAll")
	private List<Destination> listOfDestinations(HttpServletResponse res) {
		List<Destination> des = desService.index();
		if(des == null) {
			res.setStatus(404);
			return null;
		}
		return des;
	}
	
	@GetMapping("destinations/{id}")
	private Destination showById(HttpServletResponse res, @PathVariable int id, Principal principal) {
		Destination d = desService.show(principal.getName(), id);
		if(d == null) {
			res.setStatus(404);
		}
		return d;
	}
	
	@PostMapping("destinations/{id}/country")
	private Destination addDestination( HttpServletResponse res, @RequestBody Destination des,  @PathVariable int id, Principal principal) {
		try {
			Destination d = desService.create(principal.getName(), des, id);
			return d;
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			return null;
		}
	}
	
	@PutMapping("destinations/{id}")
	private Destination updateDestination( HttpServletResponse res, @PathVariable int id, @RequestBody Destination des, Principal principal) {
		try {

			des = desService.update(principal.getName(), id, des);
			res.setStatus(201);
			return des;
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			return null;
		}
	}
	
	@DeleteMapping("destinations/{id}")
	private void destory(HttpServletResponse res,@PathVariable int id, Principal principal) {
		if(id != 0) {
			desService.destroy(principal.getName(), id);
			res.setStatus(204);
		}else {
			res.setStatus(404);
		}
		
	}
	

}
