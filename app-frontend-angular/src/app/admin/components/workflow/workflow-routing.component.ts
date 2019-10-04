import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IdentificationtypeComponent } from './catalogue/identificationtype/identificationtype.component';
import { GeographyComponent } from './catalogue/geography/geography.component';
import { PaymentResidentComponent } from './catalogue/payment-resident/payment-resident.component';
import { VoucherTypeComponent } from './catalogue/voucher-type/voucher-type.component';

export const routesWorkflow: Routes = [
    { path: 'identificationtype', component: IdentificationtypeComponent },
    { path: 'geography', component: GeographyComponent },
    { path: 'paymentresident', component: PaymentResidentComponent },
    { path: 'vouchertype', component: VoucherTypeComponent },
];

@NgModule({
    imports: [RouterModule.forChild(routesWorkflow)],
    exports: [RouterModule]
})
export class WorkflowRoutingComponent { }
