export class Comment {

  id : number;
  title : string;
  body : string;
  createdAt : string;
  updatedAt : string;
  enabled : boolean;


  constructor(
  id = 0,
  title = '',
  body = '',
  createdAt = '',
  updatedAt = '',
  enabled = false,

  ){
    this.id = id
    this.title = title
    this.body = body
    this.createdAt = createdAt
    this.updatedAt = updatedAt
    this.enabled = enabled

  }

}
