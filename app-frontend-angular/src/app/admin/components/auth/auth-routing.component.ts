import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SigninComponent } from './signin/signin.component';
import { SignupComponent } from './signup/signup.component';
import { PasswordRenewComponent } from './password-renew/password-renew.component';
import { PasswordResetComponent } from './password-reset/password-reset.component';

export const routesAuth: Routes = [
    { path: '', component: SigninComponent},
    { path: 'signin', component: SigninComponent},
    { path: 'signup', component: SignupComponent},
    { path: 'password-reset', component: PasswordResetComponent},
    { path: 'password-renew', component: PasswordRenewComponent},
];

@NgModule({
    imports: [RouterModule.forChild(routesAuth)],
    exports: [RouterModule]
})
export class AuthRoutingComponent { }
