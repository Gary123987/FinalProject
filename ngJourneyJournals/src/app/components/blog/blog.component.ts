import { Component, OnInit } from '@angular/core';
import { Blog } from 'src/app/models/blog';
import { Country } from 'src/app/models/country';
import { BlogServiceService } from 'src/app/services/blog-service.service';
import { CountryService } from 'src/app/services/country.service';

@Component({
  selector: 'app-blog',
  templateUrl: './blog.component.html',
  styleUrls: ['./blog.component.css']
})
export class BlogComponent implements OnInit {
  newBlog: Blog = new Blog();
  editBlog: Blog | null = null;
  selected: Blog | null = null;
  countries: Country [] = [];


  constructor(
    private blogServ: BlogServiceService,
    private countryServ: CountryService,
    ) {

  }
  ngOnInit(): void {
  this.loadCountries();
  }

  addBlog(newBlog: Blog) {
    this.blogServ.create(newBlog).subscribe({
      next: (createdBlog) => {
        this.newBlog = createdBlog;
      },
      error: (err) => {
        console.error("error HERE!!!!");
        console.error(err);
      },
    });
  }

  updateBlog(id: number, editBlog: Blog) {
    this.blogServ.update(id, editBlog).subscribe({
      next: (updatedBlog) => {
        this.editBlog = updatedBlog;
      },
      error: (err) => {
        console.error("ERROR HERE!!!!!!!");
        console.error(err);
      },
    });
  }

  deleteBlog(id: number) {
    this.blogServ.destroy(id).subscribe({
      next: () => {

      },
      error: (err) => {
        console.error("ERROR!!!!");
        console.error(err);
      },
    });
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



}
