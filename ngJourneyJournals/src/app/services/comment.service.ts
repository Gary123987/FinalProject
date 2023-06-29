import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { Observable, catchError, throwError } from 'rxjs';
import { Comment } from './../models/comment';

@Injectable({
  providedIn: 'root'
})
export class CommentService {

  private url = environment.baseUrl + 'api/comment'

  constructor(
    private http: HttpClient,
    private authServ: AuthService
  ) { }


  public addNewCommentToBlog(comment : any): Observable<Comment> {
    return this.http.post<Comment>(this.url + '/create', comment, this.getHttpOptions()).pipe(
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

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.authServ.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  public updateCommentToBlog(comment : Comment, id: number): Observable<Comment> {
    return this.http.put<Comment>(this.url + '/update/' + id, comment, this.getHttpOptions()).pipe(
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

  public deleteComment(comment : Comment, id: number){
    return this.http.delete(this.url + '/delete/' + id, this.getHttpOptions()).pipe(
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




}
