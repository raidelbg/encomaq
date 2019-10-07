import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';

import { HttpConfigInterceptor } from '../shared/interceptors/httpconfig.interceptor';
import { AdminRoutingModule } from './admin-routing.module';
import { AdminComponent } from './admin.component';
import { SharedModule } from '../shared/shared.module';
import { AuthComponent } from './components/auth/auth.component';
import { SigninComponent } from './components/auth/signin/signin.component';
import { SignupComponent } from './components/auth/signup/signup.component';
import { PasswordRenewComponent } from './components/auth/password-renew/password-renew.component';
import { PasswordResetComponent } from './components/auth/password-reset/password-reset.component';
import { WorkflowComponent } from './components/workflow/workflow.component';
import { SigninService } from './services/auth/signin/signin.service';
import { IdentificationtypeComponent } from './components/workflow/catalogue/identificationtype/identificationtype.component';
import { IdentificationtypeService } from './services/workflow/catalogue/identificationtype.service';
import { CategoryItemComponent } from './components/workflow/catalogue/category-item/category-item.component';
import { CategoryItemService } from './services/workflow/catalogue/category-item.service';
import { UnitTypeComponent } from './components/workflow/catalogue/unit-type/unit-type.component';
import { UnitTypeService } from './services/workflow/catalogue/unit-type.service';
import { PaymentFormComponent } from './components/workflow/workflow/payment-form/payment-form.component';
import { PaymentFormService } from './services/workflow/workflow/payment-form.service';

@NgModule({
  declarations: [AdminComponent, AuthComponent, SigninComponent, SignupComponent, PasswordRenewComponent,
                PasswordResetComponent, WorkflowComponent, IdentificationtypeComponent, CategoryItemComponent,
                UnitTypeComponent, PaymentFormComponent],
  imports: [
    CommonModule,
    HttpClientModule,
    FormsModule, ReactiveFormsModule,
    SharedModule,
    AdminRoutingModule
  ],
  providers: [
    { provide: HTTP_INTERCEPTORS, useClass: HttpConfigInterceptor, multi: true },
    SigninService, IdentificationtypeService, CategoryItemService, UnitTypeService, PaymentFormService
  ]
})
export class AdminModule { }
