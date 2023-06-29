import { ActivatedRoute } from '@angular/router';
import { UserProfileService } from './../services/user-profile.service';
import { Component, OnInit } from '@angular/core';
import { User } from '../models/user';

@Component({
  selector: 'app-user-profile',
  templateUrl: './user-profile.component.html',
  styleUrls: ['./user-profile.component.css']
})
export class UserProfileComponent implements OnInit{

  userId: any;
  userProfile: User | null = null;

  constructor(
    private route: ActivatedRoute,
    private userProfileServ: UserProfileService
  ){}


  ngOnInit(): void {
    this.loadUserProfile();
  }

  loadUserProfile() {
    this.userProfileServ.getUserProfile(this.userId).subscribe({
      next: (userProfile) => {
        this.userProfile = userProfile;
      },
      error: (err) => {
        console.error(err);
      }
  })

  }

}
