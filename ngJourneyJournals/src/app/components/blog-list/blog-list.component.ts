import { Component } from '@angular/core';
import { Blog } from 'src/app/models/blog';
import { BlogRating } from 'src/app/models/blog-rating';
import { User } from 'src/app/models/user';
import { BlogServiceService } from 'src/app/services/blog-service.service';

@Component({
  selector: 'app-blog-list',
  templateUrl: './blog-list.component.html',
  styleUrls: ['./blog-list.component.css']
})
export class BlogListComponent {

  blogs: Blog[] = [];
  user: User | null = null;


  constructor(private blogServ: BlogServiceService,
  ) { }

  ngOnInit(): void {
    this.blogServ.indexAll().subscribe({
      next: (blogList) => {
        this.blogs = blogList;
        console.log(this.blogs[0])
      },
      error: (err) => {
        console.error(err);
      },
    })
  }

}
