package com.skilldistillery.journeyjournals.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name="blog_rating")
public class BlogRating {
	
	@EmbeddedId
	private BlogRatingId id;
	
	@Column(name="rating_value")
	private int ratingValue;
	
	@CreationTimestamp
	@Column(name="created_at")
	private LocalDateTime createdAt;

	@UpdateTimestamp
	@Column(name="updated_at")
	private LocalDateTime updatedAt;
	
	private boolean enabled;
	
	@Column(name="rating_comment")
	private String ratingComment;
	
	@JsonIgnoreProperties({"comments", "following", "destinationsCreated", "favoriteDestinations" })
	@ManyToOne
	@JoinColumn(name="user_id")
	@MapsId(value="userId")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="blog_id")
	@MapsId(value="blogId")
	private Blog blog;

	public BlogRating() {
		super();
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Blog getBlog() {
		return blog;
	}

	public void setBlog(Blog blog) {
		this.blog = blog;
	}


	public BlogRatingId getId() {
		return id;
	}

	public void setId(BlogRatingId id) {
		this.id = id;
	}

	public int getRatingValue() {
		return ratingValue;
	}

	public void setRatingValue(int ratingValue) {
		this.ratingValue = ratingValue;
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

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getRatingComment() {
		return ratingComment;
	}

	public void setRatingComment(String ratingComment) {
		this.ratingComment = ratingComment;
	}

	@Override
	public String toString() {
		return "BlogRating [id=" + id + ", ratingValue=" + ratingValue + ", createdAt=" + createdAt + ", updatedAt="
				+ updatedAt + ", enabled=" + enabled + ", ratingComment=" + ratingComment + "]";
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
		BlogRating other = (BlogRating) obj;
		return Objects.equals(id, other.id);
	}
	
	

}
