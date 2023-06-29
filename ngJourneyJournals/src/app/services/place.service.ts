import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Blog } from '../models/blog';
import { Place } from '../models/place';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class PlaceService {
  private url = environment.baseUrl + 'api/places';

  constructor(
    private auth: AuthService,
    private http: HttpClient,

  ) { }

  public indexByUser(): Observable<Place[]> {
    return this.http.get<Place[]>(this.url + 'User', this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error fetching places list');
        return throwError(
          () =>
            new Error(
              "error retrieving places: " + err
            )
        )
      })
    );
  }


  public indexAll(): Observable<Place[]> {
    return this.http.get<Place[]>(this.url).pipe(
      catchError((err: any) => {
        console.error('Error fetching place list');
        return throwError(
          () =>
            new Error(
              "error retrieving places: " + err
            )
        )
      })
    );

  }


  public show(id: number): Observable<Place> {
    return this.http.get<Place>(this.url + '/' + id, this.getHttpOptions()).pipe(
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


  create(newPlace: Place, id: number): Observable<Place> {
    return this.http.post<Place>(this.url + '/' + id + '/destination', newPlace, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('creating place');
        return throwError(
          () => new Error(
            "error creating: " + err
          )
        )
      })
    )
  }

  update(id: number, place: Place): Observable<Place> {
    return this.http.put<Place>(this.url + '/' + id, Place, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.error('Error editing place');
      return throwError(
        () =>
          new Error(
            "error editing place: " + err
          )
      )
    }));
  }
  destroy(id: number): Observable<void> {
    return this.http.delete<void>(this.url + '/' + id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('Error deleting place');
        return throwError(
          () =>
            new Error(
              "error deleting place " + err
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

