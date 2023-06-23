export class User {

  id : number;
  firstName: string;
  lastName: string;
  about :string;
  imageUrl: string;
  username:string;
  password:string;
  enabled: boolean;
  role: string;


  constructor(
    id : number = 0,
    firstName: string = '',
    lastName: string = '',
    about :string = '',
    imageUrl: string = '',
    username:string = '',
    password:string = '',
    enabled: boolean = true,
    role: string = ''
  ){
    this.id = id,
    this.firstName = firstName,
    this.lastName = lastName,
    this.about = about,
    this.imageUrl = imageUrl,
    this.username = username,
    this.password = password,
    this.enabled = enabled,
    this.role = role
  }

}
