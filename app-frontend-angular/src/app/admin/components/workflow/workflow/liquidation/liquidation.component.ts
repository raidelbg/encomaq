import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { from, Observable } from 'rxjs';
import { tap, map, delay } from 'rxjs/operators';

import { NgxUiLoaderService } from 'ngx-ui-loader';
import { FormGroup, FormBuilder, FormControl } from '@angular/forms';
import { CONFIG_LOADING_UI } from 'src/app/shared/classes/ConstantsEnums';
import { LiquidationService } from 'src/app/admin/services/workflow/workflow/liquidation.service';
import { Notification } from 'src/app/shared/components/classes/Notification';

declare var $: any;

@Component({
  selector: 'app-liquidation',
  templateUrl: './liquidation.component.html',
  styleUrls: ['./liquidation.component.scss']
})
export class LiquidationComponent implements OnInit, OnDestroy {

  private destroySubscription$ = new Subject();

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  typeSpinnerLoading = CONFIG_LOADING_UI.typeSpinnerLoading;
  overlayColorLoading = CONFIG_LOADING_UI.overlayColorLoading;
  colorAnimation = CONFIG_LOADING_UI.colorAnimation;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;
  formFilter: FormGroup;

  list: Observable<any[]>;

  public labels: any = {
    previousLabel: 'Anterior',
    nextLabel: 'Siguiente',
    screenReaderPaginationLabel: 'Paginado',
    screenReaderPageLabel: 'página',
    screenReaderCurrentLabel: `Estas en la página`
  };

  // tslint:disable-next-line: no-input-rename
  @Input('data') reportData: any[] = [];
  pag = 1;
  pageDelta = 1;
  total = 0;

  constructor(private notification: Notification, private formBuilder: FormBuilder, private ngxService: NgxUiLoaderService,
              private liquidationService: LiquidationService) { }

  ngOnInit() {
    this.formFilter = this.formBuilder.group({
      search: new FormControl(''),
      stateFilter: new FormControl('1'),
      column: new FormControl('biz_liquidation.number'),
      order: new FormControl('ASC'),
      numPage: new FormControl(5),
    });

    this.get(1);
  }

  getAction(page: number, perPage: number): Observable<any> {
    const filters = {
      search: this.formFilter.value.search,
      state: this.formFilter.value.stateFilter,
      column: this.formFilter.value.column,
      order: this.formFilter.value.order,
      num_page: this.formFilter.value.numPage
    };
    return from(this.liquidationService.get(filters, null, page)).pipe(delay(200));
  }

  get = (page: number) => {
    this.ngxService.startLoader('loading-component');
    this.list =  this.getAction(page, 5).pipe(
      tap(
        (response) => {
          this.total = response.data.total;
          this.pag = response.data.current_page;
          this.pageDelta = (page - 1) * 5;

          this.ngxService.stopLoader('loading-component');
        },
        (error) => {
          this.ngxService.stopLoader('loading-component');
          console.error(error);
        }
      ),
      map(response => response.data.data)
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
