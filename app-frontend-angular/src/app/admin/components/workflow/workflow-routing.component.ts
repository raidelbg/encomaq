import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IdentificationtypeComponent } from './catalogue/identificationtype/identificationtype.component';
import { CategoryItemComponent } from './catalogue/category-item/category-item.component';
import { UnitTypeComponent } from './catalogue/unit-type/unit-type.component';
import { PaymentFormComponent } from './workflow/payment-form/payment-form.component';
import { WarehouseComponent } from './workflow/warehouse/warehouse.component';
import { TransferReasonComponent } from './workflow/transfer-reason/transfer-reason.component';
import { RoleComponent } from './catalogue/role/role.component';
import { ConfigEmailComponent } from './catalogue/config-email/config-email.component';
import { UserComponent } from './catalogue/user/user.component';
import { CarrierComponent } from './workflow/carrier/carrier.component';

export const routesWorkflow: Routes = [
    { path: 'identificationtype', component: IdentificationtypeComponent },
    { path: 'category-item', component: CategoryItemComponent },
    { path: 'unit-type', component: UnitTypeComponent },
    { path: 'payment-form', component: PaymentFormComponent },
    { path: 'warehouse', component: WarehouseComponent },
    { path: 'transfer-reason', component: TransferReasonComponent },
    { path: 'role', component: RoleComponent },
    { path: 'config-email', component: ConfigEmailComponent },
    { path: 'user', component: UserComponent },
    { path: 'carrier', component: CarrierComponent },
];

@NgModule({
    imports: [RouterModule.forChild(routesWorkflow)],
    exports: [RouterModule]
})
export class WorkflowRoutingComponent { }
