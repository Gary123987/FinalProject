import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-create-account',
  templateUrl: './create-account.component.html',
  styleUrls: ['./create-account.component.css']
})
export class CreateAccountComponent {
  newUser = new User();

  constructor(
    private auth: AuthService,
    private route: ActivatedRoute,
    private router: Router,
  ){}

  register(user: User): void {
    this.auth.register(user).subscribe({
      next: (registeredUser) => {
        this.auth.login(user.username,user.password).subscribe({
          next: (loggedInUser) => {
            this.router.navigateByUrl('/userhome');
          },
          error: (err) => {
            console.error('Error registering user' + err);
          }
        })
      }
    })
  }

}
