import { Injectable } from '@angular/core';
import { Destination } from '../models/destination';
import { HttpClient } from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class DestinationService {

  private url = environment.baseUrl + 'api/destinations';

  constructor(
    private auth: AuthService,
    private http: HttpClient,

  ) { }

  public indexByUser(): Observable<Destination[]> {
    return this.http.get<Destination[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error fetching destinations list');
        return throwError(
          () =>
            new Error(
              "error retrieving destinations: " + err
            )
        )
      })
    );
  }


  public show(id: number): Observable<Destination> {
    return this.http.get<Destination>(this.url + '/' + id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error fetching place');
        return throwError(
          () =>
            new Error(
              "error showing place " + err
            )
        )
      })
    );
  }


  create(newDestination: Destination, id: number): Observable<Destination> {
    return this.http.post<Destination>(this.url + '/' + id + '/country', newDestination, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('creating destination');
        return throwError(
          () => new Error(
            "error creating: " + err
          )
        )
      })
    )
  }

  update(id: number, destination: Destination): Observable<Destination> {
    return this.http.put<Destination>(this.url + '/' + id, Destination, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.error('Error editing destination');
      return throwError(
        () =>
          new Error(
            "error editing destination: " + err
          )
      )
    }));
  }
  destroy(id: number): Observable<void> {
    return this.http.delete<void>(this.url + '/' + id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error deleting destination');
        return throwError(
          () =>
            new Error(
              "error deleting destination " + err
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
