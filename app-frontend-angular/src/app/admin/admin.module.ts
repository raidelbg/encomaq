import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';

import { NgxPaginationModule } from 'ngx-pagination';
import { NgxUiLoaderModule } from 'ngx-ui-loader';

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
import { WarehouseComponent } from './components/workflow/workflow/warehouse/warehouse.component';
import { WarehouseService } from './services/workflow/workflow/warehouse.service';
import { TransferReasonComponent } from './components/workflow/workflow/transfer-reason/transfer-reason.component';
import { TransferReasonService } from './services/workflow/workflow/transfer-reason.service';
import { RoleComponent } from './components/workflow/catalogue/role/role.component';
import { RoleService } from './services/workflow/catalogue/role.service';
import { ConfigEmailComponent } from './components/workflow/catalogue/config-email/config-email.component';
import { ConfigEmailService } from './services/workflow/catalogue/config-email.service';
import { UserComponent } from './components/workflow/catalogue/user/user.component';
import { UserService } from './services/workflow/catalogue/user.service';
import { CarrierComponent } from './components/workflow/workflow/carrier/carrier.component';
import { CarrierService } from './services/workflow/workflow/carrier.service';
import { ClientComponent } from './components/workflow/workflow/client/client.component';
import { ClientService } from './services/workflow/workflow/client.service';
import { ProjectComponent } from './components/workflow/workflow/project/project.component';
import { ProjectService } from './services/workflow/workflow/project.service';
import { ItemComponent } from './components/workflow/workflow/item/item.component';
import { ItemService } from './services/workflow/workflow/item.service';
import { ItemPriceService } from './services/workflow/workflow/item-price.service';
import { CompanyComponent } from './components/workflow/workflow/company/company.component';
import { CompanyService } from './services/workflow/workflow/company.service';
import { ContractComponent } from './components/workflow/workflow/contract/contract.component';
import { ContractService } from './services/workflow/workflow/contract.service';
import { PeriodService } from './services/workflow/catalogue/period.service';
import { DashboardComponent } from './components/workflow/workflow/dashboard/dashboard.component';
import { ReferralGuideComponent } from './components/workflow/workflow/referral-guide/referral-guide.component';
import { ProfileComponent } from './components/workflow/workflow/profile/profile.component';
import { LiquidationComponent } from './components/workflow/workflow/liquidation/liquidation.component';
import { LiquidationService } from './services/workflow/workflow/liquidation.service';
import { ReferralGuideUltimateComponent } from './components/workflow/workflow/referral-guide-ultimate/referral-guide-ultimate.component';

@NgModule({
  declarations: [AdminComponent, AuthComponent, SigninComponent, SignupComponent, PasswordRenewComponent,
                PasswordResetComponent, WorkflowComponent, IdentificationtypeComponent, CategoryItemComponent,
                UnitTypeComponent, PaymentFormComponent, WarehouseComponent, TransferReasonComponent, RoleComponent, ConfigEmailComponent,
                UserComponent, CarrierComponent, ClientComponent, ProjectComponent, ItemComponent, CompanyComponent, ContractComponent,
                DashboardComponent, ReferralGuideComponent, ProfileComponent, LiquidationComponent, ReferralGuideUltimateComponent],
  imports: [
    CommonModule,
    HttpClientModule,
    FormsModule, ReactiveFormsModule,
    SharedModule,
    AdminRoutingModule,
    NgxPaginationModule,
    NgxUiLoaderModule
  ],
  providers: [
    { provide: HTTP_INTERCEPTORS, useClass: HttpConfigInterceptor, multi: true },
    SigninService, IdentificationtypeService, CategoryItemService, UnitTypeService, PaymentFormService, WarehouseService,
    TransferReasonService, RoleService, ConfigEmailService, UserService, CarrierService, ClientService, ProjectService, ItemService,
    ItemPriceService, CompanyService, ContractService, PeriodService, LiquidationService
  ]
})
export class AdminModule { }
