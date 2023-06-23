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
  newBlog: Blog = new Blog();
  editBlog: Blog | null = null;


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


  addBlog(newBlog: Blog) {
    this.blogServ.create(newBlog).subscribe({
      next: (createdBlog) => {
       this.newBlog = createdBlog;
      },
      error: (err) => {
        console.error("error HERE!!!!");
        console.error(err);
      },
    });
  }

  updateBlog(id: number, editBlog: Blog) {
    this.blogServ.update(id, editBlog).subscribe({
      next: (updatedBlog) => {
        this.editBlog = updatedBlog;
      },
      error: (err) => {
        console.error("ERROR HERE!!!!!!!");
        console.error(err);
      },
    });
  }

  deleteTodo(id: number) {
    this.blogServ.destroy(id).subscribe({
      next: () => {

      },
      error: (err) => {
        console.error("ERROR!!!!");
        console.error(err);
      },
    });
  }
}




