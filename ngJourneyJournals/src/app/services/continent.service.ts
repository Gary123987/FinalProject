import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { Continent } from '../models/continent';
import { Observable, catchError, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ContinentService {
  private url = environment.baseUrl + 'api/continents';

  constructor(
    private auth: AuthService,
    private http: HttpClient,

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


  public indexAll(): Observable<Continent[]> {
    return this.http.get<Continent[]>(this.url).pipe(
      catchError((err: any) => {
        console.error('Error fetching continent list');
        return throwError(
          () =>
            new Error(
              "error retrieving continents: " + err
            )
        )
      })
    );

  }

}
