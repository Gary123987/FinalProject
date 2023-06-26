import { PlaceImage } from "./place-image";

export class Place {
  id: number;
  name: string;
  street: string;
  zipcode: string;
  description: string;
  imageUrl: string;
  enabled: boolean;
  images: PlaceImage[];

  constructor(id = 0, name = '', street = '', zipcode = '', description = '', imageUrl = '', enabled = false, images = []) {
    this.id = id;
    this.name = name;
    this.street = street;
    this.zipcode = zipcode;
    this.description = description;
    this.imageUrl = imageUrl;
    this.enabled = enabled;
    this.images = images
  }
}
