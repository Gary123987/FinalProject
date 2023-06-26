import { User } from 'src/app/models/user';
import { Component, OnInit } from '@angular/core';
import { Blog } from 'src/app/models/blog';
import { BlogServiceService } from 'src/app/services/blog-service.service';
import { Destination } from 'src/app/models/destination';
import { UserService } from 'src/app/services/user.service';
import { AuthService } from 'src/app/services/auth.service';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-user-home',
  templateUrl: './user-home.component.html',
  styleUrls: ['./user-home.component.css']
})
export class UserHomeComponent implements OnInit {

  blogs: Blog[] = [];
  destinations: Destination[] = [];
  user: User | null = null;
  userId: any = 0;


  constructor(
    private blogServ: BlogServiceService,
    private userService: UserService,
    private auth: AuthService,
    private route: ActivatedRoute

  ) { }

  ngOnInit(): void {
    this.userId = this.route.snapshot.queryParamMap.get('id');
    this.reload();
    this.show(this.userId);
  }

  reload() {
    this.blogServ.indexByUser().subscribe({
      next: (blogList) => {
        this.blogs = blogList;
      },
      error: (err) => {
        console.error(err);
      },
    })
  }
  show(userId: number) {
    this.userService.show(userId).subscribe({
      next: (data) => {
        this.user = data;
      },
      error: (err) => {
        console.error(err);
      }
    })
  }

}




