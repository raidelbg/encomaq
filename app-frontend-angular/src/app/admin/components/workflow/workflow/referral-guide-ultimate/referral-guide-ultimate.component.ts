import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators, FormArray } from '@angular/forms';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { from, Observable } from 'rxjs';
import { tap, map, delay } from 'rxjs/operators';
import { NgxUiLoaderService } from 'ngx-ui-loader';
import * as XLSX from 'xlsx';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ICONS_ALERT, CONFIG_LOADING_UI } from 'src/app/shared/classes/ConstantsEnums';
import { ContractService } from 'src/app/admin/services/workflow/workflow/contract.service';
import { TransferReasonService } from 'src/app/admin/services/workflow/workflow/transfer-reason.service';
import { ReferralGuideService } from 'src/app/admin/services/workflow/workflow/referral-guide.service';
import { CarrierService } from 'src/app/admin/services/workflow/workflow/carrier.service';
import { WarehouseService } from 'src/app/admin/services/workflow/workflow/warehouse.service';
import { ItemService } from 'src/app/admin/services/workflow/workflow/item.service';
import { ItemPriceService } from 'src/app/admin/services/workflow/workflow/item-price.service';

declare var $: any;

@Component({
  selector: 'app-referral-guide-ultimate',
  templateUrl: './referral-guide-ultimate.component.html',
  styleUrls: ['./referral-guide-ultimate.component.scss']
})
export class ReferralGuideUltimateComponent implements OnInit, OnDestroy {

  private destroySubscription$ = new Subject();

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;
  formFilter: FormGroup;
  formArrayItem: FormArray;

  list: Observable<any[]>;
  listContracts: Observable<any[]>;

  listItem = [];
  listItemPrice = [];
  listTransferReason = [];
  listProjects = [];
  listWarehouses = [];
  listCarriers = [];

  contractSelected: any;

  itemSelected = null;
  anything = '';

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

  pagContract = 1;
  pageDeltaContract = 1;
  totalContract = 0;

  typeSpinnerLoading = CONFIG_LOADING_UI.typeSpinnerLoading;
  overlayColorLoading = CONFIG_LOADING_UI.overlayColorLoading;
  colorAnimation = CONFIG_LOADING_UI.colorAnimation;

  constructor(private notification: Notification, private formBuilder: FormBuilder, private ngxService: NgxUiLoaderService,
              private contractService: ContractService, private transferReasonService: TransferReasonService,
              private referralGuideService: ReferralGuideService, private carrierService: CarrierService,
              private warehouseService: WarehouseService, private itemService: ItemService, private itemPriceService: ItemPriceService) { }

  ngOnInit(): void {
    this.initFormBuiler();
    this.getCarriers();
    this.getWarehouses();
    this.getItem();
    this.getTypeTransferReason();
    this.get(1);
  }

  initFormBuiler = () => {
    this.formFilter = this.formBuilder.group({
      search: new FormControl(''),
      stateFilter: new FormControl('1'),
      column: new FormControl('biz_contract.nocontract'),
      order: new FormControl('ASC'),
      numPage: new FormControl(5),
      transferreason: new FormControl(''),
    });
    this.form = this.formBuilder.group({
      nocontract: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      idclient: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      idproject: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      idwarehouse: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      establec: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      ptoventa: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      secuencial: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      datetimereferral: new FormControl(''),
      sequential: new FormControl(''),
      logisticservicecost: new FormControl(''),
      idtransferreason: new FormControl(''),
      idcarrier: new FormControl(''),
      state: new FormControl(true),
      items: this.formBuilder.array([]),
    });
  }

  getAction(page: number, perPage: number): Observable<any> {
    const filters = {
      search: this.formFilter.value.search,
      state: this.formFilter.value.stateFilter,
      column: this.formFilter.value.column,
      order: this.formFilter.value.order,
      num_page: this.formFilter.value.numPage,
      transferreason: this.formFilter.value.transferreason
    };
    return from(this.referralGuideService.get(filters, null, page)).pipe(delay(200));
  }

  getActionContract = (page: number, perPage: number): Observable<any> => {
    const filters = {
      search: '',
      state: 1,
      column: 'biz_contract.nocontract',
      order: 'DESC',
      num_page: perPage
    };
    return from(this.contractService.get(filters, null, page)).pipe(delay(200));
  }

  get = (page: number) => {
    this.ngxService.startLoader('loading-component');
    this.list = this.getAction(page, 5).pipe(
      tap(
        (response) => {
          this.total = response.data.total;
          this.pag = response.data.current_page;
          this.pageDelta = (page - 1) * 5;
          this.ngxService.stopLoader('loading-component');
        },
        (error) => {
          this.ngxService.stopLoader('loading-component');
        }
      ),
      map(response => response.data.data)
    );
  }

  getListContract = (page: number) => {
    this.listContracts = this.getActionContract(page, 5).pipe(
      tap(
        (response) => {
          this.totalContract = response.data.total;
          this.pagContract = response.data.current_page;
          this.pageDeltaContract = (page - 1) * 5;
          $('#listContractModalSearch').modal('show');
        },
        (error) => {
          console.log(error);
        }
      ),
      map(response => response.data.data)
    );
  }

  getTypeTransferReason = () => {
    this.transferReasonService.get({}).subscribe(
      (response) => {
        if (response.success) {
          this.listTransferReason = response.data;
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getItem = () => {
    const filter = {
      search: '',
      state: 1,
      column: 'itemname',
      order: 'ASC'
    };
    this.listItem.push({iditem: '', itemname: '-- Seleccione --'});
    this.itemService.get(filter).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          response.data.forEach(element => {
            this.listItem.push({
              iditem: element.iditem,
              itemname: element.itemname + '. ' + element.description
            });
          });
          this.createRowItem();
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getListItemPrice = (pos: any) => {
    const item = this.formArrayItem.value[pos];
    this.itemSelected = item;
    const data = {
      iditem: item.iditem
    };
    this.itemPriceService.get(data).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.formArrayItem.value[pos].listPrice = response.data;

          this.formArrayItem.at(pos).get('itsInContract').setValue(true);
          let flag = false;
          this.contractSelected.biz_contractitem.forEach(element => {
            if (parseInt(element.iditem, 0) === parseInt(item.iditem, 0)) {
              flag = true;
            }
          });

          if (!flag) {
            this.formArrayItem.at(pos).get('itsInContract').setValue(false);
            $('#infoNoContractItem').modal('show');
          }

          if ( response.data.length > 0 ) {
            this.formArrayItem.at(pos).get('price').setValue(response.data[0].price);
            this.formArrayItem.at(pos).get('iditemprice').setValue(response.data[0].iditemprice);
            this.formArrayItem.at(pos).get('listPrice').setValue(response.data);
          }
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getIDItemPrice(pos: number) {
    console.log(this.formArrayItem.value);
    /*const price = item.price;
    item.listPrice.forEach(function(e) {
      if (parseFloat(price) === parseFloat(e.price)) {
        item.iditemprice = e.iditemprice;
      }
    });*/
  }

  create = () => {
    this.titleAside = 'Agregar Guía de Remisión';
    this.form.reset();
    this.form.get('idtransferreason').setValue('');
    this.form.get('idwarehouse').setValue('');
    this.form.get('idcarrier').setValue('');
    this.form.get('idproject').setValue('');
    this.getListContract(1);
    this.form.get('state').setValue(true);
    this.formArrayItem = this.form.get('items') as FormArray;
    this.formArrayItem.clear();
    this.asideIsOpen = true;
  }

  edit = (item: any) => {
    this.itemSelected = item;
    console.log(item);
  }

  delete = () => {

  }

  action = () => {
    this.add();
  }

  add = () => {
    this.ngxService.startLoader('loading-component');
    const state = (this.form.value.state !== null && this.form.value.state !== false) ? true : false;
    const guidenumber = this.form.value.establec + '-' + this.form.value.ptoventa + '-' + this.form.value.secuencial;

    const data = {
      idcontract: this.contractSelected.idcontract,
      idproject: this.form.value.idproject,
      idtransferreason: this.form.value.idtransferreason,
      idcarrier: this.form.value.idcarrier,
      idwarehouse: this.form.value.idwarehouse,

      datetimereferral: this.form.value.datetimereferral,
      logisticservicecost: this.form.value.logisticservicecost,
      sequential: this.form.value.sequential,
      guidenumber,
      state,
      items: this.form.value.items,
    };

    console.log(data);

    this.referralGuideService.post(data).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside();
          this.get(1);
        } else {
          this.showNotification('¡Atención!', ICONS_ALERT.warning, response.message, 'warning');
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  confirmDelete = (item: any) => {

  }

  getResumeContract = () => {

  }

  exportExcel = (idTable: string, nameFile: string) => {

  }

  createRowItem = () => {
    const item = this.formBuilder.group({
      iditem: '',
      iditemprice: 0,
      listPrice: [],
      price: 0,
      count: 0,
      observation: '',
      itsInContract: true
    });
    this.formArrayItem = this.form.get('items') as FormArray;
    this.formArrayItem.push(item);
  }

  deleteItem = (pos) => {
    console.log(pos);
    // this.formArrayItem.removeAt(pos);
    console.log(this.formArrayItem.value);
  }

  getCarriers = () => {
    this.carrierService.get({}).subscribe(
      (response) => {
        if (response.success) {
          this.listCarriers = response.data;
          this.form.get('idcarrier').setValue('');
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getWarehouses = () => {
    this.warehouseService.get({}).subscribe(
      (response) => {
        if (response.success) {
          this.listWarehouses = response.data;
          this.form.get('idwarehouse').setValue('');
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  selectedContract = (item: any) => {
    this.contractSelected = item;
    this.form.get('nocontract').setValue(item.nocontract);
    this.form.get('idclient').setValue(item.biz_client.businessname);
    this.listProjects = item.biz_client.biz_project;
    this.form.get('idproject').setValue(this.listProjects[0].idproject);
    $('#listContractModalSearch').modal('hide');

    this.formArrayItem = this.form.get('items') as FormArray;
    this.formArrayItem.clear();

    let pos = 0;
    item.biz_contractitem.forEach(element => {
      const itemC = this.formBuilder.group({
        iditem: element.iditem,
        iditemprice: 0,
        listPrice: [],
        price: 0,
        count: element.quantity,
        observation: element.observation,
        itsInContract: true
      });

      this.formArrayItem.push(itemC);
      this.getListItemPrice(pos);
      pos++;
    });
  }

  getContractPaginate = (page: number) => {

  }

  trackByFn(index: any, item: any) {
    return index;
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
