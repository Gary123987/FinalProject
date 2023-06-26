import { Component, OnInit } from '@angular/core';
import { Blog } from 'src/app/models/blog';
import { BlogRating } from 'src/app/models/blog-rating';
import { User } from 'src/app/models/user';
import { BlogServiceService } from 'src/app/services/blog-service.service';

@Component({
  selector: 'app-blog-list',
  templateUrl: './blog-list.component.html',
  styleUrls: ['./blog-list.component.css']
})
export class BlogListComponent implements OnInit {

  blogs: Blog[] = [];
  user: User | null = null;
  selected: Blog | null = null;

  constructor(private blogServ: BlogServiceService,
  ) { }

  ngOnInit(): void {
    this.reload();
  }

  reload() {
    this.blogServ.indexAll().subscribe({
      next: (bloglist) => {
        this.blogs = bloglist;
      },
      error: (err) => {
        console.error(err);
      }
    })
  }

  displayBlog(blog: Blog): void {
    this.selected = blog;
  }

  displayTable(): void {
    this.selected = null;
  }

}
