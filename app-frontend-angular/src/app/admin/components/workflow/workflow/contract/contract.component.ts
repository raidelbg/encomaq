import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators, FormArray } from '@angular/forms';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { from, Observable } from 'rxjs';
import { tap, map, delay } from 'rxjs/operators';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';
import { ContractService } from 'src/app/admin/services/workflow/workflow/contract.service';
import { ClientService } from 'src/app/admin/services/workflow/workflow/client.service';
import { PeriodService } from 'src/app/admin/services/workflow/catalogue/period.service';
import { CategoryItemService } from 'src/app/admin/services/workflow/catalogue/category-item.service';
import { PaymentFormService } from 'src/app/admin/services/workflow/workflow/payment-form.service';
import { ItemService } from 'src/app/admin/services/workflow/workflow/item.service';

declare var $: any;

@Component({
  selector: 'app-contract',
  templateUrl: './contract.component.html',
  styleUrls: ['./contract.component.scss']
})
export class ContractComponent implements OnInit, OnDestroy {

  private destroySubscription$ = new Subject();

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;
  formFilter: FormGroup;
  formArrayPaymentForm: FormArray;
  formArrayItem: FormArray;

  list: Observable<any[]>;
  listClient = [];
  listPeriod = [];
  listCategoryItem = [];
  listPaymentForm = [];
  listItem = [];
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

  constructor(private notification: Notification, private formBuilder: FormBuilder,
              private contractService: ContractService, private clientService: ClientService,
              private periodService: PeriodService, private categoryItemService: CategoryItemService,
              private paymentFormService: PaymentFormService, private itemService: ItemService) { }

  ngOnInit() {
    this.formFilter = this.formBuilder.group({
      search: new FormControl(''),
      stateFilter: new FormControl('1'),
      column: new FormControl('biz_contract.nocontract'),
      order: new FormControl('ASC'),
      numPage: new FormControl(5),
    });
    this.form = this.formBuilder.group({
      idclient: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      nocontract: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      startdate: new FormControl(''),
      enddate: new FormControl(''),
      area: new FormControl(''),
      idperiod: new FormControl(''),
      period: new FormControl(''),
      cost: new FormControl(''),
      receipt: new FormControl(''),
      invoice: new FormControl(''),
      idcategoryitem: new FormControl(''),
      observation: new FormControl(''),
      state: new FormControl(true),
      paymentform: this.formBuilder.array([]),
      items: this.formBuilder.array([]),
    });
    this.getClient();
    this.getPeriod();
    this.getCategoryItem();
    // this.getPaymentForm();
    this.getItem();
    this.get(1);
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

  getPeriod = () => {
    this.listPeriod.push({idperiod: '', periodname: '-- Seleccione Periodo --'});
    this.periodService.get({}).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          response.data.forEach(element => {
            this.listPeriod.push({idperiod: element.idperiod, periodname: element.periodname});
          });
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getCategoryItem = () => {
    this.listCategoryItem.push({idcategoryitem: '', categoryitemname: '-- Seleccione Categoría Item --'});
    this.categoryItemService.get({}).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          response.data.forEach(element => {
            this.listCategoryItem.push({idcategoryitem: element.idcategoryitem, categoryitemname: element.categoryitemname});
          });
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
            this.listItem.push({iditem: element.iditem, itemname: element.itemname + '. ' + element.description});
          });
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getPaymentForm = () => {
    this.paymentFormService.get({}).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          response.data.forEach(element => {
            const paymentform = this.formBuilder.group({
              idpaymentform: element.idpaymentform,
              paymentformname: element.paymentformname,
              value: 0
            });
            this.formArrayPaymentForm = this.form.get('paymentform') as FormArray;
            this.formArrayPaymentForm.push(paymentform);
          });
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getAction(page: number, perPage: number): Observable<any> {
    const filters = {
      search: this.formFilter.value.search,
      state: this.formFilter.value.stateFilter,
      column: this.formFilter.value.column,
      order: this.formFilter.value.order,
      num_page: this.formFilter.value.numPage
    };

    return from(this.contractService.get(filters, null, page)).pipe(delay(200));
  }

  get = (page: number) => {
    this.list =  this.getAction(page, 5).pipe(
      tap(
        (response) => {

          this.total = response.data.total;
          this.pag = response.data.current_page;
          this.pageDelta = (page - 1) * 5;

        },
        (error) => {
          console.error(error);
        }
      ),
      map(response => response.data.data)
    );
  }

  create = () => {
    this.titleAside = 'Agregar Contrato';
    this.form.reset();

    this.form.get('idclient').setValue('');
    this.form.get('idperiod').setValue('');
    this.form.get('idcategoryitem').setValue('');
    this.form.get('state').setValue(true);

    this.formArrayItem = this.form.get('items') as FormArray;
    this.createRowItem();
    this.formArrayPaymentForm = this.form.get('paymentform') as FormArray;
    this.getPaymentForm();

    this.asideIsOpen = true;
  }

  edit = (item: any) => {
    this.itemSelected = item;

    this.form.get('idclient').setValue(item.idclient);
    this.form.get('nocontract').setValue(item.nocontract);
    this.form.get('startdate').setValue(item.startdate);
    this.form.get('enddate').setValue(item.enddate);

    this.form.get('area').setValue(item.area);
    this.form.get('idperiod').setValue(item.idperiod);
    this.form.get('period').setValue(item.period);
    this.form.get('cost').setValue(item.cost);

    this.titleAside = 'Editar Contrato';
    this.asideIsOpen = true;
  }

  closeAside = () => {
    this.asideIsOpen = false;
    // this.form.reset();
    this.itemSelected = null;
  }

  createRowItem = () => {
    const item = this.formBuilder.group({
      iditem: '',
      count: 0,
      observation: ''
    });
    this.formArrayItem = this.form.get('items') as FormArray;
    this.formArrayItem.push(item);
  }

  deleteItem = (pos) => {
    this.formArrayItem.removeAt(pos);
  }

  action = () => {
    if (this.itemSelected === null) {
      this.add();
    } else {
      // this.update(this.itemSelected.iditem);
    }
  }

  add = () => {

    const state = (this.form.value.state !== null && this.form.value.state !== false) ? true : false;
    const data = {
      idclient: this.form.value.idclient,
      nocontract: this.form.value.nocontract,
      startdate: this.form.value.startdate,
      enddate: this.form.value.enddate,
      area: this.form.value.area,

      idperiod: this.form.value.idperiod,
      period: this.form.value.period,
      cost: this.form.value.cost,
      receipt: this.form.value.receipt,
      invoice: this.form.value.invoice,
      idcategoryitem: this.form.value.idcategoryitem,
      observation: this.form.value.observation,
      paymentform: this.form.value.paymentform,
      items: this.form.value.items,
      state,
    };

    this.contractService.post(data).pipe(takeUntil(this.destroySubscription$)).subscribe(
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
    this.itemSelected = item;
    this.anything = item.nocontract;
    $('#confirmDeleteContract').modal('show');
  }

  delete = () => {
    this.contractService.delete(this.itemSelected.idcontract).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        $('#confirmDeleteContract').modal('hide');
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
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

  calculateDay = (enddate: string): boolean => {
    if (enddate !== null) {
      const Fecha: any = new Date();
      const fechaInicial: string = Fecha.getDate() + '-' + (Fecha.getMonth() + 1) + '-' + Fecha.getFullYear();
      const fechaFinal: string = enddate;
      const inicial: Array<string> = fechaInicial.split('-');
      const final: Array<string> = fechaFinal.split('-');
      const dateStart: any = new Date(parseInt(inicial[2], 0), ( parseInt(inicial[1], 0) - 1 ), parseInt(inicial[0], 0));
      const dateEnd: any = new Date(parseInt(final[0], 0), (parseInt(final[1], 0) - 1), parseInt(final[2], 0));
      const result = ( ( ( dateEnd - dateStart ) / 86400 ) / 1000 );
      return (result >= 0) ? false : true;
    } else {
      return false;
    }
  }

  ngOnDestroy(): void {
    this.destroySubscription$.next();     // trigger the unsubscribe
    this.destroySubscription$.complete(); // finalize & clean up the subject stream
  }

}
