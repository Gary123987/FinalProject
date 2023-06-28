import { Component, OnInit } from '@angular/core';
import { Blog } from 'src/app/models/blog';
import { Place } from 'src/app/models/place';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { BlogService } from 'src/app/services/blog.service';
import { PlaceService } from 'src/app/services/place.service';

@Component({
  selector: 'app-blog',
  templateUrl: './blog.component.html',
  styleUrls: ['./blog.component.css']
})
export class BlogComponent implements OnInit {

  newBlog: Blog = new Blog();
  editBlog: Blog | null = null;
  blogs: Blog[] = [];
  places: Place[] = []
  selected: Blog | null = null;
  selectedBlog: Blog | null = null;
  showingForm: boolean = false;
  user: User | null = null;
  placeId: any;
  opacity: number = 1;
  filterdBlogs: Blog[] = [];

  constructor(
    private auth: AuthService,
    private placeServ: PlaceService,
    private blogServ: BlogService
  ) { }

  getUserName() {
    this.auth.getLoggedInUser().subscribe({
      next: (user) => {
        this.user = user;
      },
      error: (err) => {
        console.error(err);
      },
    });
  }

  ngOnInit() {
    this.loadPlaces();
    this.loadBlogs();
    this.getUserName();
  }
  checkedLogin() {
    return this.auth.checkLogin();
  }

  loadPlaces() {
    this.placeServ.indexByUser().subscribe({
      next: (placeList) => {
        this.places = placeList;
      },
      error: (err) => {
        console.log(err);
      }
    })

  }



  loadBlogs() {
    this.blogServ.indexAll().subscribe({
      next: (blogList) => {
        this.blogs = blogList;
      },
      error: (err) => {
        console.log(err);
      }
    })

  }

  showAddForm(id: number) {
    this.placeId = id;
    this.showingForm = !this.showingForm;
  }

  displayUpdateForm(Blog: Blog): void {
    this.selected = Blog;
  }

  displayDetails(blog: Blog | null): void {
    this.selectedBlog = blog;
  }

  opactiyGetter() {
    if (this.selected) {
      return 'low'
    }
    else {
      return 'full'
    }
  }


  addBlog(blog: Blog) {
    return this.blogServ.create(blog, this.placeId).subscribe({
      next: () => {
        this.newBlog = new Blog();
        this.ngOnInit();
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  updateBlog(id: number, editedBlog: Blog) {
    return this.blogServ.update(id, editedBlog).subscribe({
      next: (updatedBlog) => {
        this.editBlog = updatedBlog;
        this.ngOnInit();
      },
      error: (err) => {
        console.error(err);
      }
    })

  }

  deleteBlog(id: number) {
    return this.blogServ.destroy(id).subscribe({
      next: () => {
        this.ngOnInit();
      },
      error: (err) => {
        console.log(err);
      }
    })
  }

  blogCreatedByUser(blog: Blog) {
    return this.user?.role === 'admin' || this.user?.blogs.includes(blog);

  }



}
