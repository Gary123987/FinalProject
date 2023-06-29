import { Component } from '@angular/core';
import { Place } from 'src/app/models/place';
import { User } from 'src/app/models/user';
import { PlaceService } from 'src/app/services/place.service';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';

@Component({
  selector: 'app-place-list',
  templateUrl: './place-list.component.html',
  styleUrls: ['./place-list.component.css']
})
export class PlaceListComponent {
  places: Place[] = [];
  user: User | null = null;
  selected: Place | null = null;

  constructor(private placeServ: PlaceService, private sanitizer: DomSanitizer
  ) { }

  ngOnInit(): void {
    this.reload();
  }

  sanitizeUrl(url: string): SafeResourceUrl {
    return this.sanitizer.bypassSecurityTrustResourceUrl(url);
  }

  encodeAddress(address: string): string {
    return encodeURIComponent(address);
  }

  reload() {
    this.placeServ.indexByUser().subscribe({
      next: (placelist) => {
        this.places = placelist;
      },
      error: (err) => {
        console.error(err);
      }
    })
  }

  displayBlog(place: Place): void {
    this.selected = place;
  }

  displayTable(): void {
    this.selected = null;
  }

}
