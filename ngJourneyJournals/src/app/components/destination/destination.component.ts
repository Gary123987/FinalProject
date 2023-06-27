import { CountryService } from 'src/app/services/country.service';
import { ContinentService } from './../../services/continent.service';
import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { Country } from 'src/app/models/country';
import { Continent } from 'src/app/models/continent';
import { Destination } from 'src/app/models/destination';
import { DestinationService } from 'src/app/services/destination.service';

@Component({
  selector: 'app-destination',
  templateUrl: './destination.component.html',
  styleUrls: ['./destination.component.css']
})
export class DestinationComponent implements OnInit{

  countries: Country[] = [];
  continents: Continent[] = [];
  destinations: Destination [] = [];

  constructor(
  private continentServ: ContinentService,
  private countryServ: CountryService,
  private auth: AuthService,
  private destinationServ: DestinationService,
  ){}

  ngOnInit(){
  this.loadContinents();
  this.loadCountries();
  this.loadDestinations();
  }

  checkedLogin(){
  return this.auth.checkLogin();
  }

  loadContinents(){
  this.continentServ.indexAll().subscribe({
    next: (continentList) => {
      console.log(this.continents)
      this.continents = continentList;
    },
    error: (err) => {
      console.log(err);
    }
  })
  }

  loadCountries(){
    this.countryServ.indexAll().subscribe({
      next: (countryList) => {
        this.countries = countryList;
      },
      error: (err) => {
        console.log(err);
      }
    })

  }

  loadDestinations(){
    this.destinationServ.indexByUser().subscribe({
      next: (destinationList) => {
        this.destinations = destinationList;
      },
      error: (err) => {
        console.log(err);
      }
    })

  }

}
