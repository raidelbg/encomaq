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
  listItem = [];
  listTransferReason = [];
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

  typeSpinnerLoading = CONFIG_LOADING_UI.typeSpinnerLoading;
  overlayColorLoading = CONFIG_LOADING_UI.overlayColorLoading;
  colorAnimation = CONFIG_LOADING_UI.colorAnimation;

  constructor(private notification: Notification, private formBuilder: FormBuilder, private ngxService: NgxUiLoaderService,
              private contractService: ContractService, private transferReasonService: TransferReasonService,
              private referralGuideService: ReferralGuideService) { }

  ngOnInit(): void {
    this.initFormBuiler();
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
  }

  getAction(page: number, perPage: number): Observable<any> {
    const filters = {
      search: this.formFilter.value.search,
      state: this.formFilter.value.stateFilter,
      column: this.formFilter.value.column,
      order: this.formFilter.value.order,
      num_page: this.formFilter.value.numPage
    };
    return from(this.referralGuideService.get(filters, null, page)).pipe(delay(200));
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

  create = () => {

  }

  edit = (item: any) => {

  }

  delete = () => {

  }

  confirmDelete = (item: any) => {

  }

  getResumeContract = () => {

  }

  exportExcel = (idTable: string, nameFile: string) => {

  }

  calculateDay = (enddate: string) => {

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
