import { BlogRating } from "./blog-rating";
import { Category } from "./category";
import { Comment } from "./comment";
import { Place } from "./place";
import { User } from "./user";

export class Blog {

  id: number;
  title: string;
  description: string;
  tripStart: string;
  tripEnd: string;
  imageUrl: string;
  createdAt: string;
  updatedAt: string;
  enabled: boolean;
  comments: Comment[];
  categories: Category[];
  ratings: BlogRating[];
  user: User | null;
  place: Place | null;

  constructor(
    id = 0,
    title = '',
    description = '',
    tripStart = '',
    tripEnd = '',
    imageUrl = '',
    createdAt = '',
    updatedAt = '',
    enabled = false,
    comments = [],
    categories = [],
    ratings = [],
    user = null,
    place = null
  ) {
    this.id = id
    this.title = title
    this.description = description
    this.tripStart = tripStart
    this.tripEnd = tripEnd
    this.imageUrl = imageUrl
    this.createdAt = createdAt
    this.updatedAt = updatedAt
    this.enabled = enabled
    this.comments = comments
    this.categories = categories
    this.ratings = ratings
    this.user = user
    this.place = place
  }
}
