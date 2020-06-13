import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { from, Observable } from 'rxjs';
import { tap, map, delay } from 'rxjs/operators';
import { NgxUiLoaderService } from 'ngx-ui-loader';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ICONS_ALERT, CONFIG_LOADING_UI } from 'src/app/shared/classes/ConstantsEnums';
import { DashboardService } from 'src/app/admin/services/workflow/report/dashboard.service';

declare var $: any;

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit, OnDestroy {

  private destroySubscription$ = new Subject();

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  countClients = 0;
  countContract = 0;
  countGuide = 0;
  countLiquidation = 0;

  constructor(private notification: Notification, private ngxService: NgxUiLoaderService, private dashboardService: DashboardService) { }

  ngOnInit() {
    this.getCountClients();
    this.getCountContract();
    this.getCountGuide();
    this.getCountLiquidation();
  }

  getCountClients = () => {
    this.dashboardService.get({}, 'count-client').pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.countClients = response.data;
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getCountContract = () => {
    this.dashboardService.get({}, 'count-contract').pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.countContract = response.data;
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getCountGuide = () => {
    this.dashboardService.get({}, 'count-guide').pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.countGuide = response.data;
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getCountLiquidation = () => {
    this.dashboardService.get({}, 'count-liquidation').pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.countLiquidation = response.data;
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  /**
   * Show notifications launched from methods
   * @param string title
   * @param string icon
   * @param string message
   * @param string type
   */
  showNotification = (title: string, icon: string, message: string, type: string): void => {
    this.titleNotification = title;
    this.iconNotification = icon;
    this.messageNotification = message;
    this.typeNotification = type;
    this.notification.open();
  }

  ngOnDestroy(): void {
    this.destroySubscription$.next();     // trigger the unsubscribe
    this.destroySubscription$.complete(); // finalize & clean up the subject stream
  }

}
