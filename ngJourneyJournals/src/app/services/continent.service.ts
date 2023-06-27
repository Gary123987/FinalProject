import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class ContinentService {
  private url = environment.baseUrl + 'api/continents';

  constructor(
    private auth: AuthService,
    private http: HttpClient,

  ) { }
}
