import { Country } from "./country";

export class Continent {
  id: number;
  name: string;
  description: string;
  countries: Country[];

  constructor(id = 0, name = '', description = '', countries = []) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.countries = countries;
  }
}
