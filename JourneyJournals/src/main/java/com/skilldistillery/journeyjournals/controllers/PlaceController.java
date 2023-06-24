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
	
	@GetMapping("placesUser")
	private List<Place> findPlacesByUser(Principal principal, HttpServletResponse res) {
		List<Place> places = placeServ.indexByUser(principal.getName());
		
		if(places == null) {
			res.setStatus(404);
			return null;
		}
		return places;
	}
	
	@PostMapping("places")
	private Place createPlace(@RequestBody Place place, Principal principal, HttpServletResponse res) {
		
		try {
			place = placeServ.create(principal.getName(), place);
			res.setStatus(201);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
		return place;
	}
	
	@PutMapping("places/{id}")
	private Place updatePlace(@RequestBody Place place, @PathVariable int id, Principal principal, HttpServletResponse res) {
		
		Place updatedPlace = null;
		
		try {
			updatedPlace = placeServ.update(principal.getName(), id, place);
			if (updatedPlace == null) {
				res.setStatus(404);
			}
		} catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return updatedPlace;
	}
	
	@DeleteMapping("places/{id}")
	public void deletePlace(@PathVariable int id, Principal principal, HttpServletResponse res) {
		
		if (placeServ.destroy(principal.getName(), id)) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}

}
