import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent {

  loginUser: User = new User();

  constructor(private auth: AuthService, private router: Router) {

  }

  login(user: User) {
    this.auth.login(user.username, user.password).subscribe({
      next: (loggedUser) => {
        this.router.navigateByUrl('/userhome');
      },
      error: (error) => {
        console.error('register()' + error);
      }

    })

  }

}
