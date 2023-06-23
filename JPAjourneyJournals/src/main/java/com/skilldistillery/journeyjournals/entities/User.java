package com.skilldistillery.journeyjournals.entities;

import java.time.LocalDateTime;
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
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	private String password;

	private String about;

	@Column(name = "image_url")
	private String imageUrl;

	@Column(name = "created_at")
	@CreationTimestamp
	private LocalDateTime createdAt;

	@Column(name = "updated_at")
	@UpdateTimestamp
	private LocalDateTime updatedAt;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<Blog> blogs;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<Comment> comments;
	
	@JsonIgnore
	@OneToMany(mappedBy = "userCreated")
	private List<Destination> destinationsCreated;
	
	@JsonIgnore
	@ManyToMany(mappedBy = "usersFavorited")
	private List<Destination> favoriteDestinations;


	@ManyToMany
	@JoinTable(name = "user_follower", joinColumns = @JoinColumn(name = "followed_id"), inverseJoinColumns = @JoinColumn(name = "follower_id"))
	private List<User> following;
	
	@JsonIgnore
	@ManyToMany(mappedBy = "following")
	private List<User> followers;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<Place> placesCreated;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<DestinationImage> destinationImages;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<PlaceImage> placeImages;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<BlogRating> blogRatings;
	
	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<PlaceRating> placeRatings;

	private String role;

	private boolean enabled;

	public User() {
		super();
	}

	public List<BlogRating> getBlogRatings() {
		return blogRatings;
	}

	public void setBlogRatings(List<BlogRating> blogRatings) {
		this.blogRatings = blogRatings;
	}

	public void addBlogRating(BlogRating rating) {
		if (blogRatings == null) {
			blogRatings = new ArrayList<>();
		}
		if (!blogRatings.contains(rating)) {
			blogRatings.add(rating);
			if (rating.getUser() != null) {
				rating.getUser().removeBlogRating(rating);
			}
			rating.setUser(this);
		}

	}

	public void removeBlogRating(BlogRating rating) {
		if (blogRatings != null && blogRatings.contains(rating)) {
			blogRatings.remove(rating);
			rating.setUser(this);
		}

	}

	public List<PlaceRating> getPlaceRatings() {
		return placeRatings;
	}

	public void setPlaceRatings(List<PlaceRating> placeRatings) {
		this.placeRatings = placeRatings;
	}

	public void addPlaceRating(PlaceRating rating) {
		if (placeRatings == null) {
			placeRatings = new ArrayList<>();
		}
		if (!placeRatings.contains(rating)) {
			placeRatings.add(rating);
			if (rating.getUser() != null) {
				rating.getUser().removePlaceRating(rating);
			}
			rating.setUser(this);
		}

	}

	public void removePlaceRating(PlaceRating rating) {
		if (placeRatings != null && placeRatings.contains(rating)) {
			placeRatings.remove(rating);
			rating.setUser(this);
		}

	}

	public List<PlaceImage> getPlaceImages() {
		return placeImages;
	}

	public void setPlaceImages(List<PlaceImage> placeImages) {
		this.placeImages = placeImages;
	}

	public void addPlaceImage(PlaceImage image) {
		if (placeImages == null) {
			placeImages = new ArrayList<>();
		}
		if (!placeImages.contains(image)) {
			placeImages.add(image);
			if (image.getUser() != null) {
				image.getUser().removePlaceImage(image);
			}
			image.setUser(this);
		}

	}

	public void removePlaceImage(PlaceImage image) {
		if (placeImages != null && placeImages.contains(image)) {
			placeImages.remove(image);
			image.setUser(this);
		}

	}

	public List<DestinationImage> getDestinationImages() {
		return destinationImages;
	}

	public void setDestinationImages(List<DestinationImage> destinationImages) {
		this.destinationImages = destinationImages;
	}

	public void addDestinationImage(DestinationImage image) {
		if (destinationImages == null) {
			destinationImages = new ArrayList<>();
		}
		if (!destinationImages.contains(image)) {
			destinationImages.add(image);
			if (image.getUser() != null) {
				image.getUser().removeDestinationImage(image);
			}
			image.setUser(this);
		}

	}

	public void removeDestinationImage(DestinationImage image) {
		if (destinationImages != null && destinationImages.contains(image)) {
			destinationImages.remove(image);
			image.setUser(this);
		}

	}

	public List<Place> getPlacesCreated() {
		return placesCreated;
	}

	public void setPlacesCreated(List<Place> placesCreated) {
		this.placesCreated = placesCreated;
	}

	public void addPlace(Place place) {
		if (placesCreated == null) {
			placesCreated = new ArrayList<>();
		}
		if (!placesCreated.contains(place)) {
			placesCreated.add(place);
			if (place.getUser() != null) {
				place.getUser().removePlace(place);
			}
			place.setUser(this);
		}

	}

	public void removePlace(Place place) {
		if (placesCreated != null && placesCreated.contains(place)) {
			placesCreated.remove(place);
			place.setUser(this);
		}

	}

	public List<User> getFollowing() {
		return following;
	}

	public void setFollowing(List<User> following) {
		this.following = following;
	}

	public void addFollowing(User user) {
		if (following == null) {
			following = new ArrayList<>();
		}
		if (!following.contains(user)) {
			following.add(user);
			user.addFollowers(this);
		}

	}

	public void removeFollowing(User user) {
		if (following != null && following.contains(user)) {
			following.remove(user);
			user.removeFollowers(this);
		}

	}

	public List<User> getFollowers() {
		return followers;
	}

	public void setFollowers(List<User> followers) {
		this.followers = followers;
	}

	public void addFollowers(User user) {
		if (followers == null) {
			followers = new ArrayList<>();
		}
		if (!followers.contains(user)) {
			followers.add(user);
			user.addFollowing(this);
		}

	}

	public void removeFollowers(User user) {
		if (followers != null && followers.contains(user)) {
			followers.remove(user);
			user.removeFollowing(this);
		}

	}

	public List<Destination> getFavoriteDestinations() {
		return favoriteDestinations;
	}

	public void setFavoriteDestinations(List<Destination> favoriteDestinations) {
		this.favoriteDestinations = favoriteDestinations;
	}

	public void addDestination(Destination des) {
		if (favoriteDestinations == null) {
			favoriteDestinations = new ArrayList<>();
		}
		if (!favoriteDestinations.contains(des)) {
			favoriteDestinations.add(des);
			des.addUser(this);
		}

	}

	public void removeDestination(Destination des) {
		if (favoriteDestinations != null && favoriteDestinations.contains(des)) {
			favoriteDestinations.remove(des);
			des.removeUser(this);
		}

	}

	public List<Destination> getDestinationsCreated() {
		return destinationsCreated;
	}

	public void setDestinationsCreated(List<Destination> destinationsCreated) {
		this.destinationsCreated = destinationsCreated;
	}

	public void addDesstinationsCreated(Destination des) {
		if (destinationsCreated == null) {
			destinationsCreated = new ArrayList<>();
		}
		if (!destinationsCreated.contains(des)) {
			destinationsCreated.add(des);
			if (des.getUserCreated() != null) {
				des.getUserCreated().removeDestinaionCreated(des);
			}
			des.setUserCreated(this);
		}

	}

	public void removeDestinaionCreated(Destination des) {
		if (destinationsCreated != null && destinationsCreated.contains(des)) {
			destinationsCreated.remove(des);
			des.setUserCreated(this);
		}

	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public void addComment(Comment comment) {
		if (comments == null) {
			comments = new ArrayList<>();
		}
		if (!comments.contains(comment)) {
			comments.add(comment);
			if (comment.getUser() != null) {
				comment.getUser().removeComment(comment);
			}
			comment.setUser(this);
		}

	}

	public void removeComment(Comment comment) {
		if (comments != null && comments.contains(comment)) {
			comments.remove(comment);
			comment.setUser(this);
		}

	}

	public List<Blog> getBlogs() {
		return blogs;
	}

	public void setBlogs(List<Blog> blogs) {
		this.blogs = blogs;
	}

	public void addBlog(Blog blog) {
		if (blogs == null) {
			blogs = new ArrayList<>();
		}
		if (!blogs.contains(blog)) {
			blogs.add(blog);
			if (blog.getUser() != null) {
				blog.getUser().removeBlog(blog);
			}
			blog.setUser(this);
		}

	}

	public void removeBlog(Blog blog) {
		if (blogs != null && blogs.contains(blog)) {
			blogs.remove(blog);
			blog.setUser(this);
		}

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
