import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private url = environment.baseUrl + 'api/users';


  constructor(private auth: AuthService,
    private http: HttpClient,) { }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  public index(): Observable<User[]> {
    return this.http.get<User[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error fetching user list');
        return throwError(
          () =>
            new Error(
              "error retrieving user: " + err
            )
        )
      })
    );

  }


  public show(id: number): Observable<User> {
    return this.http.get<User>(this.url + '/' + id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error fetching user');
        return throwError(
          () =>
            new Error(
              "error showing user" + err
            )
        )
      })
    );
  }
}
