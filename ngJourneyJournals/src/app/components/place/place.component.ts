import { Component, OnInit } from '@angular/core';
import { Destination } from 'src/app/models/destination';
import { Place } from 'src/app/models/place';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { DestinationService } from 'src/app/services/destination.service';
import { PlaceService } from 'src/app/services/place.service';

@Component({
  selector: 'app-place',
  templateUrl: './place.component.html',
  styleUrls: ['./place.component.css']
})
export class PlaceComponent implements OnInit {

  newPlace: Place = new Place();
  editPlace: Place | null = null;
  places: Place[] = [];
  selected: Place | null = null;
  selectedPlace: Place | null = null;
  showingForm: boolean = false;
  user: User | null = null;
  destinationId: any;
  destinations: Destination[] = [];
  opacity: number = 1;

  constructor(
    private auth: AuthService,
    private placeServ: PlaceService,
    private destinationServ: DestinationService,
  ) { }

  getUserName() {
    this.auth.getLoggedInUser().subscribe({
      next: (user) => {
        this.user = user;
      },
      error: (err) => {
        console.error(err);
      },
    });
  }

  ngOnInit() {
    this.loadDestinations();
    this.loadPlaces();
    this.getUserName();
  }
  checkedLogin() {
    return this.auth.checkLogin();
  }

  loadPlaces() {
    this.placeServ.indexAll().subscribe({
      next: (placeList) => {
        this.places = placeList;
      },
      error: (err) => {
        console.log(err);
      }
    })

  }

  loadDestinations() {
    this.destinationServ.indexAll().subscribe({
      next: (destinationList) => {
        this.destinations = destinationList;
      },
      error: (err) => {
        console.log(err);
      }
    })

  }

  showAddForm(id: number) {
    this.destinationId = id;
    this.showingForm = !this.showingForm;
  }

  displayUpdateForm(place: Place): void {
    this.selected = place;
  }

  displayDetails(place: Place | null): void {
    this.selectedPlace = place;
  }

  opactiyGetter() {
    if (this.selected) {
      return 'low'
    }
    else {
      return 'full'
    }
  }


  addPlace(place: Place) {
    return this.placeServ.create(place, this.destinationId).subscribe({
      next: (createdPlace) => {
        this.newPlace = new Place();
        this.ngOnInit();
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  updatePlace(id: number, editedPlace: Place) {
    return this.placeServ.update(id, editedPlace).subscribe({
      next: (updatedPlace) => {
        this.editPlace = updatedPlace;
      },
      error: (err) => {
        console.error(err);
      }
    })

  }

  deletePlace(id: number) {
    return this.placeServ.destroy(id).subscribe({
      next: () => {
        this.ngOnInit();
      },
      error: (err) => {
        console.log(err);
      }
    })
  }

  placesCreatedByUser(place: Place) {
    return this.user?.role === 'admin' || this.user?.placesCreated.includes(place);

  }

}
