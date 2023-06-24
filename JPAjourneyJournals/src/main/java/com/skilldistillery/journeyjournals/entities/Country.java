package com.skilldistillery.journeyjournals.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Country {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="continent_id")
	private Continent continent;

	public Country() {
		super();
	}
	
	@JsonIgnoreProperties("country")
	@OneToMany(mappedBy="country")
	private List<Destination> destinations;

	public List<Destination> getDestinations() {
		return destinations;
	}

	public void setDestinations(List<Destination> destinations) {
		this.destinations = destinations;
	}
	public void addDestination(Destination destination) {
		if (destinations == null) {
			destinations = new ArrayList<>();
		}
		if (!destinations.contains(destination)) {
			destinations.add(destination);
			if (destination.getCountry()!= null) {
				destination.getCountry().removeDestination(destination);
			}
			destination.setCountry(this);
		}

	}

	public void removeDestination(Destination destination) {
		if (destinations != null && destinations.contains(destination)) {
			destinations.remove(destination);
			destination.setCountry(this);
		}

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	

	public Continent getContinent() {
		return continent;
	}

	public void setContinent(Continent continent) {
		this.continent = continent;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "Country [id=" + id + ", name=" + name + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Country other = (Country) obj;
		return id == other.id;
	}
	
	

}
