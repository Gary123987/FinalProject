import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home.component';
import { NotfoundComponent } from './components/notfound/notfound.component';
import { UserHomeComponent } from './components/user-home/user-home.component';
import { CreateAccountComponent } from './components/create-account/create-account.component';
import { Blog } from './models/blog';
import { BlogComponent } from './components/blog/blog.component';
import { DestinationComponent } from './components/destination/destination.component';
import { GalleryComponent } from './components/gallery/gallery.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: HomeComponent },
  { path: 'userhome', component: UserHomeComponent },
  { path: 'register', component: CreateAccountComponent },
  { path: 'blog', component: BlogComponent },
  { path: 'destination', component: DestinationComponent },
  { path: 'gallery', component: GalleryComponent },
  { path: '**', component: NotfoundComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, { useHash: true })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
