package com.skilldistillery.journeyjournals.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Continent {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String description;
	
	@OneToMany(mappedBy = "continent")
	private List<Country> countries;

	public Continent() {
		super();
	}

	public List<Country> getCountries() {
		return countries;
	}

	public void setCountries(List<Country> countries) {
		this.countries = countries;
	}

	
	public void addCountry(Country country) {
		if (countries == null) {
			countries  = new ArrayList<>();
		}
		if (!countries.contains(country)) {
			countries.add(country);
			if (country.getContinent()!= null) {
				country.getContinent().removeCountry(country);
			}
			country.setContinent(this);
		}

	}

	public void removeCountry(Country country) {
		if (countries != null && countries.contains(country)) {
			countries.remove(country);
			country.setContinent(this);
		}

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Override
	public String toString() {
		return "Continent [id=" + id + ", name=" + name + ", description=" + description + "]";
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
		Continent other = (Continent) obj;
		return id == other.id;
	}
	
	
	
	

}
