import { CountryService } from 'src/app/services/country.service';
import { ContinentService } from './../../services/continent.service';
import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { Country } from 'src/app/models/country';
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

  newDes: Destination = new Destination();
  editDes: Destination | null = null;
  countries: Country[] = [];
  continents: Continent[] = [];
  destinations: Destination[] = [];
  places: Place[] = [];
  countryId: any;
  selected: Destination | null = null;
  showingForm: boolean = false;

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

  checkedLogin() {
    return this.auth.checkLogin();
  }

  loadContinents() {
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

  showAddForm(id: number) {
    this.countryId = id;
    this.showingForm = !this.showingForm;
  }

  addDestination(destination: Destination) {
    return this.destinationServ.create(destination, this.countryId).subscribe({
      next: (createdDes) => {
        this.newDes = new Destination();
        this.loadDestinations();
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  updateDestination() {

  }
}
