import { Place } from "./place";
import { User } from "./user";

export class PlaceImage {
  id: number;
  imageUrl: string;
  place: Place | null;
  user: User | null;
  enabled: boolean;

  constructor(id = 0, imageUrl = '', place = null, user = null, enabled = false) {
    this.id = id;
    this.imageUrl = imageUrl;
    this.place = place;
    this.user = user;
    this.enabled = enabled;
  }
}
