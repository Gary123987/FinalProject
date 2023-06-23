import { Component, OnInit } from '@angular/core';
import { Blog } from 'src/app/models/blog';
import { BlogServiceService } from 'src/app/services/blog-service.service';

@Component({
  selector: 'app-user-home',
  templateUrl: './user-home.component.html',
  styleUrls: ['./user-home.component.css']
})
export class UserHomeComponent implements OnInit{

  blogs: Blog [] = [];

  constructor(
    private blogServ: BlogServiceService,

  ) {}


  ngOnInit():void {

      this.blogServ.indexByUser().subscribe({
        next: (blogList) => {
          this.blogs = blogList;
        },
        error: (err) => {
          console.error(err);
        },
      })
    }

}
