import { User } from 'src/app/models/user';
import { Component, OnInit } from '@angular/core';
import { Blog } from 'src/app/models/blog';
import { BlogServiceService } from 'src/app/services/blog-service.service';
import { Destination } from 'src/app/models/destination';
import { UserService } from 'src/app/services/user.service';
import { AuthService } from 'src/app/services/auth.service';
import { Router, ActivatedRoute } from '@angular/router';
import { Place } from 'src/app/models/place';
import { PlaceService } from 'src/app/services/place.service';

@Component({
  selector: 'app-user-home',
  templateUrl: './user-home.component.html',
  styleUrls: ['./user-home.component.css']
})
export class UserHomeComponent implements OnInit {

  blogs: Blog[] = [];
  places: Place[] = [];
  destinations: Destination[] = [];
  user: User | null = null;
  userId: any = 0;

  diffUser = this.getUserName();


  constructor(
    private placeServ: PlaceService,
    private userService: UserService,
    private auth: AuthService,
    private route: ActivatedRoute

  ) { }

  ngOnInit(): void {
    this.userId = this.route.snapshot.queryParamMap.get('id');
    this.reload();
    this.show(this.userId);
  }

  getUserName() {
    return this.auth.getLoggedInUserName();
  }

  reload() {
    this.placeServ.indexByUser().subscribe({
      next: (placeList) => {
        this.places = placeList;
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




