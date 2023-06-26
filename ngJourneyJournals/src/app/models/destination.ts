import { Country } from "./country";
import { DestinationImage } from "./destination-image";
import { Place } from "./place";

export class Destination {
  id: number;
  city: string;
  state: string;
  name: string;
  imageUrl: string;
  description: string;
  enabled: boolean;
  country: Country | null;
  images: DestinationImage[];
  places: Place[];

  constructor(id = 0, city = '', state = '', name = '', imageUrl = '', description = '', enabled = false, country = null, images = [], places = []) {
    this.id = id;
    this.city = city;
    this.state = state;
    this.name = name;
    this.imageUrl = imageUrl;
    this.description = description;
    this.enabled = enabled;
    this.country = country;
    this.images = images;
    this.places = places;
  }
}
