import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { Observable, catchError, throwError } from 'rxjs';
import { Blog } from '../models/blog';

@Injectable({
  providedIn: 'root'
})
export class BlogService {

  private url = environment.baseUrl + 'api/blogs'

  constructor(
    private http : HttpClient,
    private authServ : AuthService
  ) { }

  getHttpOptions(){
    let options = {
      headers: {
        Authorization: 'Basic ' + this.authServ.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  index() : Observable<Blog[]> {
    return this.http.get<Blog[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('index failed' + err)
        );
      })
    );
  }


}
