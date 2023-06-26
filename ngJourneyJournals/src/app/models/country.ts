import { Continent } from "./continent";
import { Destination } from "./destination";

export class Country {
  id: number;
  name: string;
  continent: Continent | null;
  destinations: Destination[];

  constructor(id = 0, name = '', continent = null, destinations = []) {
    this.id = id;
    this.name = name;
    this.destinations = destinations;
    this.continent = continent;

  }
}
