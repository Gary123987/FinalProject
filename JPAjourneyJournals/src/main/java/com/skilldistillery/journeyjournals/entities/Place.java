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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Place {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String street;
	
	private String zipcode;
	
	private String description;
	
	@Column(name="image_url")
	private String imageUrl;
	
	private boolean enabled;
	
	@JsonIgnore
	@OneToOne(mappedBy = "place")
	private Blog blog;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="destination_id")
	private Destination destination;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name= "user_id")
	private User user;
	
	@JsonIgnoreProperties({"place", "user"})
	@OneToMany(mappedBy="place")
	private List<PlaceImage> images;
	
	@JsonIgnore
	@OneToMany(mappedBy="place")
	private List<PlaceRating> ratings;
	

	public List<PlaceRating> getRatings() {
		return ratings;
	}

	public void setRatings(List<PlaceRating> ratings) {
		this.ratings = ratings;
	}
	
	public void addPlaceRating(PlaceRating rating) {
		if (ratings == null) {
			ratings = new ArrayList<>();
		}
		if (!ratings.contains(rating)) {
			ratings.add(rating);
			if (rating.getPlace() != null) {
				rating.getPlace().removePlaceRating(rating);
			}
			rating.setPlace(this);
		}

	}

	public void removePlaceRating(PlaceRating rating) {
		if (ratings != null && ratings.contains(rating)) {
			ratings.remove(rating);
			rating.setPlace(this);
		}

	}

	public List<PlaceImage> getImages() {
		return images;
	}

	public void setImages(List<PlaceImage> images) {
		this.images = images;
	}
	
	public void addPlaceImage(PlaceImage image) {
		if (images == null) {
			images = new ArrayList<>();
		}
		if (!images.contains(image)) {
			images.add(image);
			if (image.getPlace() != null) {
				image.getPlace().removePlaceImage(image);
			}
			image.setPlace(this);
		}

	}

	public void removePlaceImage(PlaceImage image) {
		if (images != null && images.contains(image)) {
			images.remove(image);
			image.setPlace(this);
		}

	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Destination getDestination() {
		return destination;
	}

	public void setDestination(Destination destination) {
		this.destination = destination;
	}

	public Blog getBlog() {
		return blog;
	}

	public void setBlog(Blog blog) {
		this.blog = blog;
	}

	public Place() {
		super();
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

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	@Override
	public String toString() {
		return "Place [id=" + id + ", name=" + name + ", street=" + street + ", zipcode=" + zipcode + ", description="
				+ description + ", imageUrl=" + imageUrl + ", enabled=" + enabled + "]";
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
		Place other = (Place) obj;
		return id == other.id;
	}
	
	

}
