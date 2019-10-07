import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IdentificationtypeComponent } from './catalogue/identificationtype/identificationtype.component';
import { CategoryItemComponent } from './catalogue/category-item/category-item.component';

export const routesWorkflow: Routes = [
    { path: 'identificationtype', component: IdentificationtypeComponent },
    { path: 'category-item', component: CategoryItemComponent },
];

@NgModule({
    imports: [RouterModule.forChild(routesWorkflow)],
    exports: [RouterModule]
})
export class WorkflowRoutingComponent { }
