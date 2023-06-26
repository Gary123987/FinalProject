import { Blog } from "./blog";

export class Category {
  id: number;
  name: string;
  blogs: Blog[];

  constructor(id = 0, name = '', blogs = []) {
    this.id = id;
    this.name = name;
    this.blogs = blogs;
  }

}
