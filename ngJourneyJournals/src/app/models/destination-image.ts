export class DestinationImage {
  id: number;
  imageUrl: string;

  constructor(id = 0, imageUrl = '') {
    this.id = id;
    this.imageUrl = imageUrl;
  }

}
