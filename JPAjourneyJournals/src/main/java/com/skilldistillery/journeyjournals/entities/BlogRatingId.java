package com.skilldistillery.journeyjournals.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;

@Embeddable
public class BlogRatingId implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Column(name="user_id")
	private int userId;
	
	@Column(name="blog_id")
	private int blogId;
	

	public BlogRatingId() {
		super();
	}

	public BlogRatingId(int userId, int blogId) {
		super();
		this.userId = userId;
		this.blogId = blogId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getBlogId() {
		return blogId;
	}

	public void setBlogId(int blogId) {
		this.blogId = blogId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "BlogRatingId [userId=" + userId + ", blogId=" + blogId + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(blogId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BlogRatingId other = (BlogRatingId) obj;
		return blogId == other.blogId && userId == other.userId;
	}
	
	
	
	
	

}
