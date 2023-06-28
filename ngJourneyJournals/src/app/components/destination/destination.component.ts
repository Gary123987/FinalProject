import { Country } from './../../models/country';
import { CountryService } from 'src/app/services/country.service';
import { ContinentService } from './../../services/continent.service';
import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { Continent } from 'src/app/models/continent';
import { Destination } from 'src/app/models/destination';
import { DestinationService } from 'src/app/services/destination.service';
import { Place } from 'src/app/models/place';
import { PlaceService } from 'src/app/services/place.service';

@Component({
  selector: 'app-destination',
  templateUrl: './destination.component.html',
  styleUrls: ['./destination.component.css']
})
export class DestinationComponent implements OnInit {

  countries: Country[] = [];
  continents: Continent[] = [];
  destinations: Destination[] = [];
  places: Place[] = [];
  selected: Destination | null = null;
  selectedCountry: Country | null = null;
  countryId: any = null;
  @Output() countrySend: EventEmitter<Country> = new EventEmitter<Country>();

  constructor(
    private continentServ: ContinentService,
    private countryServ: CountryService,
    private auth: AuthService,
    private destinationServ: DestinationService,
    private placeServ: PlaceService,
  ) { }

  ngOnInit() {
    this.loadContinents();
    this.loadCountries();
    this.loadDestinations();
    this.loadPlaces();
  }


  sendCountry(country: Country) {
    this.countrySend.emit(country);
    console.log(country);

  }
  checkedLogin() {
    return this.auth.checkLogin();
  }

  loadContinents() {
    this.continentServ.indexAll().subscribe({
      next: (continentList) => {
        this.continents = continentList;
        console.log(this.continents)
      },
      error: (err) => {
        console.log(err);
      }
    })
  }

  loadCountries() {
    this.countryServ.indexAll().subscribe({
      next: (countryList) => {
        this.countries = countryList;
      },
      error: (err) => {
        console.log(err);
      }
    })

  }

  loadDestinations() {
    this.destinationServ.indexByUser().subscribe({
      next: (destinationList) => {
        this.destinations = destinationList;
      },
      error: (err) => {
        console.log(err);
      }
    })

  }
  loadPlaces() {
    this.placeServ.indexByUser().subscribe({
      next: (placeList) => {
        this.places = placeList;
      },
      error: (err) => {
        console.log(err);
      }
    })

  }

  displayAddForm() { }

  getCountryId(id: number) {
    this.countryId = id;
  }


  showSelected(country: Country) {
    this.selectedCountry = country;
  }



}
