import { CountryService } from './../../services/country.service';
import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Params, Router } from '@angular/router';
import { Country } from 'src/app/models/country';
import { Destination } from 'src/app/models/destination';
import { DestinationService } from 'src/app/services/destination.service';

@Component({
  selector: 'app-country',
  templateUrl: './country.component.html',
  styleUrls: ['./country.component.css']
})
export class CountryComponent implements OnInit {
  @Input()
  country!: Country;
  selected: Destination | null = null;
  newDes: Destination | null = null;
  editDes: Destination | null = null;
  showNewForm: boolean = false;


  constructor(private countryServ: CountryService, private destinationServ: DestinationService, private router: Router, private route: ActivatedRoute) {

  }
  ngOnInit(): void {
    this.newDes = new Destination();
    console.log(this.country)

  }
  toggleForm() {
    this.showNewForm = !this.showNewForm;
  }
  toggleEditForm() {
    this.editDes = this.selected;
  }

  displayDestination(destination: Destination) {
    this.selected = destination;
  }

  displayDestinationDetails(editDe: Destination) {
    this.selected = editDe;
  }


  addDestination(destination: Destination) {
    this.destinationServ.create(destination, this.country!.id).subscribe({
      next: (createdDestination) => {
        this.router.navigate(['/destination']);
      },
      error: (err) => [
        console.error(err)
      ]
    })
  }
}
