import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AuthComponent } from './components/auth/auth.component';
import { routesAuth } from './components/auth/auth-routing.component';
import { WorkflowComponent } from './components/workflow/workflow.component';
import { routesWorkflow } from './components/workflow/workflow-routing.component';

export const routesAdmin: Routes = [
    { path: 'auth', component: AuthComponent, children: routesAuth },
    { path: '', component: WorkflowComponent, children: routesWorkflow },
    { path: 'workflow', component: WorkflowComponent, children: routesWorkflow }
];

@NgModule({
    imports: [RouterModule.forChild(routesAdmin)],
    exports: [RouterModule]
})
export class AdminRoutingModule { }
