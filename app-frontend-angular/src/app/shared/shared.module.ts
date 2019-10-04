import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HTTP_INTERCEPTORS } from '@angular/common/http';

import { SharedRoutingModule } from './shared-routing.module';
import { SharedComponent } from './shared.component';
import { HttpConfigInterceptor } from './interceptors/httpconfig.interceptor';
import { NotificationComponent } from './components/components/notification/notification.component';
import { AsideComponent } from './components/components/aside/aside.component';

@NgModule({
  declarations: [SharedComponent, NotificationComponent, AsideComponent],
  imports: [
    CommonModule,
    FormsModule,
    SharedRoutingModule
  ],
  providers: [
    { provide: HTTP_INTERCEPTORS, useClass: HttpConfigInterceptor, multi: true }
  ],
  exports: [NotificationComponent, AsideComponent]
})
export class SharedModule { }
