package com.skilldistillery.journeyjournals.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Destination {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String city;

	@Column(name = "state_province")
	private String state;

	private String name;

	@Column(name = "image_url")
	private String imageUrl;

	private String description;

	private boolean enabled;


	@ManyToOne
	@JoinColumn(name = "country_id")
	private Country country;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User userCreated;


	@ManyToMany
	@JoinTable(name = "favorite_destination", joinColumns = @JoinColumn(name = "destination_id"), inverseJoinColumns = @JoinColumn(name = "user_id"))
	private List<User> usersFavorited;

	@JsonIgnore
	@OneToMany(mappedBy = "destination")
	private List<DestinationImage> images;

	@JsonIgnore
	@OneToMany(mappedBy = "destination")
	private List<Place> places;

	public Destination() {
		super();
	}

	public List<Place> getPlaces() {
		return places;
	}

	public void setPlaces(List<Place> places) {
		this.places = places;
	}

	public void addPlace(Place place) {
		if (places == null) {
			places = new ArrayList<>();
		}
		if (!places.contains(place)) {
			places.add(place);
			if (place.getDestination() != null) {
				place.getDestination().removePlace(place);
			}
			place.setDestination(this);
		}

	}

	public void removePlace(Place place) {
		if (places != null && places.contains(place)) {
			places.remove(place);
			place.setDestination(this);
		}

	}

	public List<DestinationImage> getImages() {
		return images;
	}

	public void setImages(List<DestinationImage> images) {
		this.images = images;
	}
	

	public void addImage(DestinationImage image) {
		if (images == null) {
			images = new ArrayList<>();
		}
		if (!images.contains(image)) {
			images.add(image);
			if (image.getDestination() != null) {
				image.getDestination().removeImage(image);
			}
			image.setDestination(this);
		}

	}

	public void removeImage(DestinationImage image) {
		if (images != null && images.contains(image)) {
			images.remove(image);
			image.setDestination(this);
		}

	}

	public User getUserCreated() {
		return userCreated;
	}

	public void setUserCreated(User userCreated) {
		this.userCreated = userCreated;
	}

	public List<User> getUsersFavorited() {
		return usersFavorited;
	}

	public void setUsersFavorited(List<User> usersFavorited) {
		this.usersFavorited = usersFavorited;
	}
	
	public void addUser(User user) {
		if(usersFavorited == null) {usersFavorited = new ArrayList<>();}
		if(!usersFavorited.contains(user)) {
			usersFavorited.add(user);
			user.addDestination(this);
		}

	}

	public void removeUser(User user) {
		if(usersFavorited != null && usersFavorited.contains(user)) {
			usersFavorited.remove(user);
			user.removeDestination(this);
		}

	}

	public Country getCountry() {
		return country;
	}

	public void setCountry(Country country) {
		this.country = country;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	@Override
	public String toString() {
		return "Destination [id=" + id + ", city=" + city + ", state=" + state + ", name=" + name + ", imageUrl="
				+ imageUrl + ", description=" + description + ", enabled=" + enabled + "]";
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
		Destination other = (Destination) obj;
		return id == other.id;
	}

}
