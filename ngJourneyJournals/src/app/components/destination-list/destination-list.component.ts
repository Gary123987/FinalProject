import { Component } from '@angular/core';
import { Destination } from 'src/app/models/destination';
import { User } from 'src/app/models/user';
import { DestinationService } from 'src/app/services/destination.service';

@Component({
  selector: 'app-destination-list',
  templateUrl: './destination-list.component.html',
  styleUrls: ['./destination-list.component.css']
})
export class DestinationListComponent {
  destinations: Destination[] = [];
  user: User | null = null;
  selected: Destination | null = null;

  constructor(private desServ: DestinationService,
  ) { }

  ngOnInit(): void {
    this.reload();
  }

  reload() {
    this.desServ.indexByUser().subscribe({
      next: (deslist) => {
        this.destinations = deslist;
      },
      error: (err) => {
        console.error(err);
      }
    })
  }

  displayBlog(des: Destination): void {
    this.selected = des;
  }

  displayTable(): void {
    this.selected = null;
  }

}
