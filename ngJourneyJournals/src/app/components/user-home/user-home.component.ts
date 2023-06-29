import { DestinationService } from 'src/app/services/destination.service';
import { User } from 'src/app/models/user';
import { Component, OnInit } from '@angular/core';
import { Blog } from 'src/app/models/blog';
import { Destination } from 'src/app/models/destination';
import { AuthService } from 'src/app/services/auth.service';
import { Router, ActivatedRoute } from '@angular/router';
import { Place } from 'src/app/models/place';
import { PlaceService } from 'src/app/services/place.service';
import { BlogService } from 'src/app/services/blog.service';
import { UserService } from 'src/app/services/user.service';

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

  constructor(
    private userService : UserService,
    private placeServ: PlaceService,
    private destinationServ: DestinationService,
    private blogServ: BlogService,
    private auth: AuthService,
    private route: ActivatedRoute

  ) { }

  ngOnInit(): void {

     let userIdString: string | null = this.route.snapshot.paramMap.get('id');
     if (userIdString){
     let userId: number = parseInt(userIdString);
     this.loadOtherUser(userId);
      } else {
        this.reload();
        this.getUserName();
      }

    this.loadDestinations();
    this.loadBlogs();

  }

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


  loadOtherUser(userId: number) {
    this.userService.show(userId).subscribe({
      next: (user) => {
        this.user = user;
        this.places = user.placesCreated;
      },
      error: (err) => {
        console.error(err);
      },
    });


  }

  loadDestinations() {
    this.destinationServ.indexByUser().subscribe({
      next: (destinationList) => {
        this.destinations = destinationList;
      },
      error: (err) => {
        console.log(err);
      }
    })

  }

  loadBlogs() {
    this.blogServ.index().subscribe({
      next: (blogList) => {
        this.blogs = blogList;
      },
      error: (err) => {
        console.log(err);
      }
    })

  }



}




