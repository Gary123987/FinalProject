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
    private http: HttpClient,
    private authServ: AuthService
  ) { }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.authServ.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  index(): Observable<Blog[]> {
    return this.http.get<Blog[]>(this.url + 'User', this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('index failed' + err)
        );
      })
    );
  }
  indexAll(): Observable<Blog[]> {
    return this.http.get<Blog[]>(this.url + 'All').pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('index failed' + err)
        );
      })
    );
  }

  public show(id: number): Observable<Blog> {
    return this.http.get<Blog>(this.url + '/' + id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error fetching blog');
        return throwError(
          () =>
            new Error(
              "error showing blog " + err
            )
        )
      })
    );
  }

  create(newBlog: Blog, id: number): Observable<Blog> {
    return this.http.post<Blog>(this.url + 'Create' + '/' + id + '/place', newBlog, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('creating blog')
        return throwError(
          () => new Error(
            "error creating: " + err
          )
        )
      })
    )
  }

  update(id: number, blog: Blog): Observable<Blog> {
    return this.http.put<Blog>(this.url + 'Update' + '/' + id, blog, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.error('Error editing blog');
      return throwError(
        () =>
          new Error(
            "error editing blog: " + err
          )
      )
    }));
  }
  destroy(id: number): Observable<void> {
    return this.http.delete<void>(this.url + 'Delete' + '/' + id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error deleting blog');
        return throwError(
          () =>
            new Error(
              "error deleting blog " + err
            )
        );
      }))
  }

}
