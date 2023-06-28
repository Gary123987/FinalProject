import { Destination } from './destination';
import { Blog } from "./blog";
import { Place } from './place';

export class User {

  id: number;
  firstName: string;
  lastName: string;
  about: string;
  imageUrl: string;
  username: string;
  password: string;
  enabled: boolean;
  role: string;
  blogs: Blog[];
  places: Place[];
  destinationCreated: Destination[];
  destinationFavored: Destination[];
  user: User[]
  placesCreated: Place[];

  constructor(
    id: number = 0,
    firstName: string = '',
    lastName: string = '',
    about: string = '',
    imageUrl: string = '',
    username: string = '',
    password: string = '',
    enabled: boolean = true,
    role: string = '',
    blogs = [],
    places = [],
    destinationCreated = [],
    destinationFavored = [],
    user = [],
    placesCreated = []
  ) {
    this.id = id,
      this.firstName = firstName,
      this.lastName = lastName,
      this.about = about,
      this.imageUrl = imageUrl,
      this.username = username,
      this.password = password,
      this.enabled = enabled,
      this.role = role,
      this.blogs = blogs,
      this.places = places,
      this.destinationCreated = destinationCreated;
    this.destinationFavored = destinationFavored;
    this.user = user;
    this.placesCreated = placesCreated;
  }

}
