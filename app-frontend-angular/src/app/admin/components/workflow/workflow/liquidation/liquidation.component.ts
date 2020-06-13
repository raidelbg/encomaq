import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { from, Observable } from 'rxjs';
import { tap, map, delay } from 'rxjs/operators';

import { NgxUiLoaderService } from 'ngx-ui-loader';
import { FormGroup, FormBuilder, FormControl, Validators, FormArray } from '@angular/forms';
import { CONFIG_LOADING_UI } from 'src/app/shared/classes/ConstantsEnums';
import { LiquidationService } from 'src/app/admin/services/workflow/workflow/liquidation.service';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ClientService } from 'src/app/admin/services/workflow/workflow/client.service';

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
  itemSelected = null;
  anything = '';

  form: FormGroup;
  formFilter: FormGroup;

  list: Observable<any[]>;
  listClient = [];
  listClientModal: Observable<any[]>;
  listProyects = [];

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

  pagClient = 1;
  pageDeltaClient = 1;
  totalClient = 0;

  constructor(private notification: Notification, private formBuilder: FormBuilder, private ngxService: NgxUiLoaderService,
              private liquidationService: LiquidationService, private clientService: ClientService) { }

  ngOnInit() {
    this.formFilter = this.formBuilder.group({
      search: new FormControl(''),
      stateFilter: new FormControl('1'),
      column: new FormControl('biz_liquidation.number'),
      order: new FormControl('ASC'),
      numPage: new FormControl(5),
    });

    this.form = this.formBuilder.group({
      idclient: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      nocontract: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      dateinit: new FormControl(''),
      dateend: new FormControl(''),
      area: new FormControl(''),
      idprojects: new FormControl(''),
      observation: new FormControl(''),
    });

    this.getClient();
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

  create = () => {
    this.titleAside = 'Agregar Liquidación';
    this.asideIsOpen = true;
  }

  getActionClient(page: number, perPage: number): Observable<any> {
    const filters = {
      search: '',
      state: true,
      column: 'businessname',
      order: 'asc',
      num_page: 5
    };

    return from(this.clientService.get(filters, null, page)).pipe(delay(200));
  }

  getClientPaginate = (page: number) => {
    this.listClientModal = this.getActionClient(page, 5).pipe(
      tap(
        (response) => {

          this.totalClient = response.data.total;
          this.pagClient = response.data.current_page;
          this.pageDeltaClient = (page - 1) * 5;

          $('#listClientModalSearch').modal('show');

        },
        (error) => {
          console.error(error);
        }
      ),
      map(response => response.data.data)
    );
  }

  getClient = () => {
    this.listClient.push({idclient: '', businessname: '-- Seleccione Cliente --'});
    this.clientService.get({}).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          response.data.forEach(element => {
            this.listClient.push({idclient: element.idclient, businessname: element.businessname});
          });
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  selectedClient = (item: any) => {
    this.form.get('idclient').setValue(item.idclient);
    $('#listClientModalSearch').modal('hide');
  }

  closeAside = () => {
    this.asideIsOpen = false;
    this.form.reset();
    this.itemSelected = null;
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
