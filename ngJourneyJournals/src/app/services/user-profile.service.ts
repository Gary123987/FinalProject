import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class UserProfileService {

  private url = environment.baseUrl + 'api/user-profile';

  constructor(
    private http: HttpClient,
    private auth: AuthService,
  ) { }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

    getUserProfile(userId: number): Observable<User> {
      return this.http.get<User>(this.url + '/' + userId, this.getHttpOptions());
    }


}
