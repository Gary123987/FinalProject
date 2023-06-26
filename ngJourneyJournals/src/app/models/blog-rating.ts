import { Blog } from "./blog";
import { User } from "./user";

export class BlogRating {
  id: number;
  ratingValue: number;
  enabled: boolean;
  ratingComment: string;
  user: User | null;
  blog: Blog | null;

  constructor(id = 0, ratingValue = 0, enabled = false, ratingComment = '', user = null, blog = null) {
    this.id = id;
    this.ratingValue = ratingValue;
    this.enabled = enabled;
    this.ratingComment = ratingComment;
    this.user = user;
    this.blog = blog;
  }

}
