import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Continent } from '../models/continent';
import { AuthService } from './auth.service';
import { Country } from '../models/country';

@Injectable({
  providedIn: 'root'
})
export class CountryService {

  private url = environment.baseUrl + 'api/countries';

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


  public indexAll(): Observable<Country[]> {
    return this.http.get<Country[]>(this.url).pipe(
      catchError((err: any) => {
        console.error('Error fetching country list');
        return throwError(
          () =>
            new Error(
              "error retrieving country: " + err
            )
        )
      })
    );

  }

}
