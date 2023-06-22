package com.skilldistillery.journeyjournals.entities;

import java.time.LocalDateTime;
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
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
public class User {
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String username;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	private String password;
	
	private String about;
	
	@Column(name="image_url")
	private String imageUrl;
	
	@Column(name="created_at")
	@CreationTimestamp
	private LocalDateTime createdAt;
	
	@Column(name="updated_at")
	@UpdateTimestamp
	private LocalDateTime updatedAt;
	
	@OneToMany(mappedBy = "user")
	private List<Blog> blogs;
	
	@OneToMany(mappedBy = "user")
	private List<Comment> comments;
	
	@OneToMany(mappedBy="userCreated")
	private List<Destination> destinationsCreated;
	
	@ManyToMany(mappedBy="usersFavorited")
	private List<Destination> favoriteDestinations;
	
	@ManyToMany
	@JoinTable(name = "user_follower", joinColumns = @JoinColumn(name="followed_id"), inverseJoinColumns = @JoinColumn(name="follower_id"))
	private List<User> following;
	
	@ManyToMany(mappedBy="following")
	private List<User> followers;
	
	@OneToMany(mappedBy="user")
	private List<Place> placesCreated;
	
	@OneToMany(mappedBy="user")
	private List<DestinationImage> destinationImages;
	
	@OneToMany(mappedBy="user")
	private List<PlaceImage> placeImages;
	
	public List<PlaceImage> getPlaceImages() {
		return placeImages;
	}
	
	@OneToMany(mappedBy="user")
	private List<BlogRating> blogRatings;
	
	@OneToMany(mappedBy="user")
	private List<PlaceRating> placeRatings;
	
	public List<BlogRating> getBlogRatings() {
		return blogRatings;
	}

	public void setBlogRatings(List<BlogRating> blogRatings) {
		this.blogRatings = blogRatings;
	}

	public List<PlaceRating> getPlaceRatings() {
		return placeRatings;
	}

	public void setPlaceRatings(List<PlaceRating> placeRatings) {
		this.placeRatings = placeRatings;
	}

	public void setPlaceImages(List<PlaceImage> placeImages) {
		this.placeImages = placeImages;
	}
	
	public List<DestinationImage> getDestinationImages() {
		return destinationImages;
	}

	public void setDestinationImages(List<DestinationImage> destinationImages) {
		this.destinationImages = destinationImages;
	}

	public List<Place> getPlacesCreated() {
		return placesCreated;
	}

	public void setPlacesCreated(List<Place> placesCreated) {
		this.placesCreated = placesCreated;
	}

	public List<User> getFollowing() {
		return following;
	}

	public void setFollowing(List<User> following) {
		this.following = following;
	}

	public List<User> getFollowers() {
		return followers;
	}

	public void setFollowers(List<User> followers) {
		this.followers = followers;
	}

	public List<Destination> getFavoriteDestinations() {
		return favoriteDestinations;
	}

	public void setFavoriteDestinations(List<Destination> favoriteDestinations) {
		this.favoriteDestinations = favoriteDestinations;
	}

	public List<Destination> getDestinationsCreated() {
		return destinationsCreated;
	}

	public void setDestinationsCreated(List<Destination> destinationsCreated) {
		this.destinationsCreated = destinationsCreated;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<Blog> getBlogs() {
		return blogs;
	}

	public void setBlogs(List<Blog> blogs) {
		this.blogs = blogs;
	}

	private String role;
	
	private boolean enabled;

	public User() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAbout() {
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}


	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}



	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", firstName=" + firstName + ", lastName=" + lastName
				+ ", password=" + password + ", about=" + about + ", imageUrl=" + imageUrl + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + ", role=" + role + ", enabled=" + enabled + "]";
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
		User other = (User) obj;
		return id == other.id;
	}
	
	

}
