import { Comment } from './../../models/comment';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Route } from '@angular/router';
import { Blog } from 'src/app/models/blog';
import { Place } from 'src/app/models/place';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { BlogService } from 'src/app/services/blog.service';
import { CommentService } from 'src/app/services/comment.service';
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
  showCommentForm: boolean = false;
  showCommentUpdateForm: boolean = false;
  newCommentTitle: string = '';
  newCommentBody: string = '';
  comment: Comment = new Comment();
  selectedComment: Comment | null = null
  updatedComment: Comment = new Comment()
  showFirstDiv: boolean = true;


  constructor(
    private auth: AuthService,
    private placeServ: PlaceService,
    private blogServ: BlogService,
    private commentServ: CommentService,
    private route: ActivatedRoute,

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
    // this.loadBlogs();
    this.getUserName();
    this.route.paramMap.subscribe({
      next: (params) => {
        let placeString = params.get('placeId');
        if (placeString) {
          let placeId = parseInt(placeString);
          if (!isNaN(placeId)) {
            // this.findBlogByPlaceId(placeId)
            this.loadBlogsByPlaceId(placeId);
          }
        } else (
          this.loadBlogs()
        )
      }
    })

  }
  checkedLogin() {
    return this.auth.checkLogin();
  }

  findBlogByPlaceId(placeId: number) {
    this.blogServ.show(placeId).subscribe({
      next: (blog) => {

      },
      error: (err) => {
        console.log(err);
      }
    })
  }

  loadPlaces() {
    this.placeServ.indexAll().subscribe({
      next: (placeList) => {
        this.places = placeList;
      },
      error: (err) => {
        console.log(err);
      }
    })

  }

  hasBlogs(): boolean {
    return this.blogs.length != 0;
  }

  loadBlogsByPlaceId(placeId: number) {
    this.blogServ.indexAll().subscribe({
      next: (blogList) => {
        blogList.forEach(blog => {
          if (blog.place?.id === placeId) {
            console.log(placeId);
            console.log(blog);
            this.blogs.push(blog);
          }
        });
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
    this.showFirstDiv = false;

    console.log('Mmmmmmmmmmmmmmmmm')
  }

  opactiyGetter() {
    if (this.selected) {
      return 'low'
    }
    else {
      return 'full'
    }
  }

  addComment(title: string, body: string, blog: Blog) {
    this.comment.body = body
    this.comment.title = title
    this.comment.enabled = true
    this.comment.blog = blog
    this.comment.user = this.user
    return this.commentServ.addNewCommentToBlog(this.comment).subscribe({
      next: (comment) => {
        this.newCommentBody = ''
        this.newCommentBody = ''
        this.showCommentForm = false
        this.ngOnInit()//reload method
      }
    })
  }

  updateComment(comment: Comment) {
    let id = comment.id
    console.log(id)
    console.log(comment)
    this.commentServ.updateCommentToBlog(comment, id).subscribe({
      next: (comment) => {
        this.selectedComment = null
        this.ngOnInit()
      },
      error: (err) => {
        console.log(err)
      }
    })
  }

  deleteComment(comment: Comment) {
    let id = comment.id
    return this.commentServ.deleteComment(comment, id).subscribe({
      next: () => {
        this.selectedComment = null;
        this.ngOnInit();
      },
      error: (err) => {
        console.log(err);
      }
    });
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

  commentCreatedByUser(comment: Comment) {
    return this.user?.role === 'admin' || comment.user == this.user;

  }
}
