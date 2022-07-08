import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AgregarComponent } from './componentes/agregar/agregar.component';
import { CatalogoComponent } from './componentes/catalogo/catalogo.component';
import { EditarComponent } from './componentes/editar/editar.component';
import { EliminarComponent } from './componentes/eliminar/eliminar.component';
import { LoginComponent } from './componentes/login/login.component';
import { LoginGuard } from './guardas/login.guard';

const routes: Routes = [
  { path: '', redirectTo: '/catalogo', pathMatch: 'full' },
  { path: 'login', component: LoginComponent },
  { path: 'catalogo', component: CatalogoComponent, canActivate:[LoginGuard] },
  { path: 'nuevo', component: AgregarComponent, canActivate:[LoginGuard] },
  { path: 'editar/:id', component: EditarComponent, canActivate:[LoginGuard] },
  { path: 'eliminar/:id', component: EliminarComponent, canActivate:[LoginGuard] }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
