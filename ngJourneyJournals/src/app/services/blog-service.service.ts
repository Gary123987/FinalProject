import { HttpClient } from '@angular/common/http';
import { AuthService } from './auth.service';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Blog } from '../models/blog';
import { Observable, catchError, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BlogServiceService {

private url = environment.baseUrl + 'api/blogs';

  constructor(
    private auth: AuthService,
    private http: HttpClient,

  ) { }

  public indexByUser(): Observable<Blog[]> {
    return this.http.get<Blog[]>(this.url + 'User', this.getHttpOptions()).pipe(
      catchError( (err: any) => {
        console.error('Error fetching blogs list');
        return throwError(
          () =>
          new Error(
            "error retrieving todos: " + err
          )
        )
      })
    );

  }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }
}
