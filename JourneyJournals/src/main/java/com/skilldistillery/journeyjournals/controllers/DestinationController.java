package com.skilldistillery.journeyjournals.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
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
	

}
