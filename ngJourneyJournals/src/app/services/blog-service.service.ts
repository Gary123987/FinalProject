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
  private commentUrl = environment.baseUrl + 'api/comment/create'

  constructor(
    private auth: AuthService,
    private http: HttpClient,

  ) { }

  public indexByUser(): Observable<Blog[]> {
    return this.http.get<Blog[]>(this.url + 'User', this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error fetching blogs list');
        return throwError(
          () =>
            new Error(
              "error retrieving blogs: " + err
            )
        )
      })
    );
  }

  public addNewCommentToBlog(comment : Comment, username : string): Observable<Comment> {
    return this.http.post<Comment>(this.url + '/' + username, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error creating comment');
        return throwError(
          () =>
            new Error(
              "error creating comment: " + err
            )
        )
      })
    );
  }


  public indexAll(): Observable<Blog[]> {
    return this.http.get<Blog[]>(this.url + 'All', this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error fetching blog list');
        return throwError(
          () =>
            new Error(
              "error retrieving blogs: " + err
            )
        )
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
              "error showing blogs: " + err
            )
        )
      })
    );
  }


  create(newBlog: Blog): Observable<Blog> {
    return this.http.post<Blog>(this.url + 'Create', newBlog, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error fetching blog list');
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
      console.error('Error editing blog list');
      return throwError(
        () =>
          new Error(
            "error editing blogs: " + err
          )
      )
    }));
  }
  destroy(id: number): Observable<void> {
    return this.http.delete<void>(this.url + 'Delete' + '/' + id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error deleting blog list');
        return throwError(
          () =>
            new Error(
              "error deleting blogs: " + err
            )
        );
      }))
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
