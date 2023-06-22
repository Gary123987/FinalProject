package com.skilldistillery.journeyjournals.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class PlaceRatingId implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Column(name="place_id")
	private int placeId;

	@Column(name="user_id")
	private int userId;

	public PlaceRatingId() {
		super();
	}

	public PlaceRatingId(int placeId, int userId) {
		super();
		this.placeId = placeId;
		this.userId = userId;
	}

	public int getPlaceId() {
		return placeId;
	}

	public void setPlaceId(int placeId) {
		this.placeId = placeId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "PlaceRatingId [placeId=" + placeId + ", userId=" + userId + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(placeId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PlaceRatingId other = (PlaceRatingId) obj;
		return placeId == other.placeId && userId == other.userId;
	}
	
	
	
	
	
}
