package com.skilldistillery.journeyjournals.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.journeyjournals.entities.Place;
import com.skilldistillery.journeyjournals.services.PlaceService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class PlaceController {
	
	@Autowired
	private PlaceService placeServ;
	
	@GetMapping("places/{id}")
	private Place findPlaceById(@PathVariable int id, Principal principal, HttpServletResponse res) {
		Place place = placeServ.show(principal.getName(), id);
		if (place == null) {
			res.setStatus(404);
		}
		
		return place;
	}
	
	@GetMapping("places")
	private List<Place> indexAll(){
		return placeServ.index();
	}

}
