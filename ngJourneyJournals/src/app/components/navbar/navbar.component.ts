import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit {

  loggedInUser: User | null = null;

  constructor(private auth: AuthService) { }

  ngOnInit() {
    if (this.auth.checkLogin()) {
      this.auth.getLoggedInUser().subscribe(
        user => {
          this.loggedInUser = user;
        },
        error => {
          console.log('Error retrieving logged-in user:', error);
        }
      );
    }
  }

  checkLogin(): boolean {
    return this.auth.checkLogin();
  }



}
