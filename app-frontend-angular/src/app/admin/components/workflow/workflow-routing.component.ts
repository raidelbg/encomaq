import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IdentificationtypeComponent } from './catalogue/identificationtype/identificationtype.component';
import { CategoryItemComponent } from './catalogue/category-item/category-item.component';
import { UnitTypeComponent } from './catalogue/unit-type/unit-type.component';
import { PaymentFormComponent } from './workflow/payment-form/payment-form.component';

export const routesWorkflow: Routes = [
    { path: 'identificationtype', component: IdentificationtypeComponent },
    { path: 'category-item', component: CategoryItemComponent },
    { path: 'unit-type', component: UnitTypeComponent },
    { path: 'payment-form', component: PaymentFormComponent },
];

@NgModule({
    imports: [RouterModule.forChild(routesWorkflow)],
    exports: [RouterModule]
})
export class WorkflowRoutingComponent { }
