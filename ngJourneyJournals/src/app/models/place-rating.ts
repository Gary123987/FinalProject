import { Place } from "./place";
import { User } from "./user";

export class PlaceRating {
  id: number;
  ratingValue: number;
  enabled: boolean;
  ratingComment: string;
  user: User | null;
  place: Place | null;

  constructor(id = 0, ratingValue = 0, enabled = false, ratingComment = '', user = null, place = null) {
    this.id = id;
    this.ratingValue = ratingValue;
    this.enabled = enabled;
    this.ratingComment = ratingComment;
    this.user = user;
    this.place = place;
  }
}
