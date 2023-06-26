import { Blog } from 'src/app/models/blog';
import { User } from "./user";

export class Comment {

  id: number;
  title: string;
  body: string;
  createdAt: string;
  updatedAt: string;
  enabled: boolean;
  user: User | null;
  blog: Blog | null;
  parentComment: Comment | null;
  replies: Comment[];


  constructor(
    id = 0,
    title = '',
    body = '',
    createdAt = '',
    updatedAt = '',
    enabled = false,
    user = null,
    blog = null,
    parentComment = null,
    replies = []

  ) {
    this.id = id
    this.title = title
    this.body = body
    this.createdAt = createdAt
    this.updatedAt = updatedAt
    this.enabled = enabled
    this.user = user
    this.blog = blog
    this.parentComment = parentComment
    this.replies = replies
  }

}
