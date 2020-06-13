import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ICONS_ALERT, CONFIG_LOADING_UI } from 'src/app/shared/classes/ConstantsEnums';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { from, Observable } from 'rxjs';
import { tap, map, delay } from 'rxjs/operators';
import { NgxUiLoaderService } from 'ngx-ui-loader';
import { ItemService } from 'src/app/admin/services/workflow/workflow/item.service';
import { CategoryItemService } from 'src/app/admin/services/workflow/catalogue/category-item.service';
import { UnitTypeService } from 'src/app/admin/services/workflow/catalogue/unit-type.service';
import { environment } from 'src/environments/environment';
import { ItemPriceService } from 'src/app/admin/services/workflow/workflow/item-price.service';
import { customValidatorHandler } from 'src/app/shared/classes/CustomValidators';

declare var $: any;

interface FilterServerResponse {
  data: any;
  total: number;
}
@Component({
  selector: 'app-item',
  templateUrl: './item.component.html',
  styleUrls: ['./item.component.scss']
})
export class ItemComponent implements OnInit, OnDestroy {

  private destroySubscription$ = new Subject();

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;
  formFilter: FormGroup;
  formView: boolean;
  formTableView: boolean;

  list: Observable<any[]>;
  listIdentifyType = [];
  listCategory = [];
  listUnitType = [];
  listItemPrice = [];
  itemSelected = null;
  itemAddToEdit = null;
  anything = '';

  fileToUpload: File = null;
  urlBasic: string;
  itemNameSelected: string;
  error: any;

  urlImageDefault = './assets/image/no_image_available.jpg';

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
  itemsPerPage = 20;

  typeSpinnerLoading = CONFIG_LOADING_UI.typeSpinnerLoading;
  overlayColorLoading = CONFIG_LOADING_UI.overlayColorLoading;
  colorAnimation = CONFIG_LOADING_UI.colorAnimation;

  constructor(private notification: Notification, private itemService: ItemService, private formBuilder: FormBuilder,
              private categoryService: CategoryItemService, private unitTypeService: UnitTypeService,
              private itemPriceService: ItemPriceService, private ngxService: NgxUiLoaderService) { }

  ngOnInit() {
    this.form = this.formBuilder.group({
      idcategoryitem: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      idunittype: new FormControl('', {validators: [Validators.required, Validators.pattern('^[0-9]*$')], updateOn: 'change'}),
      itemname: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      image: new FormControl(''),
      description: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      price: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      state: new FormControl(true),
    });
    this.formFilter = this.formBuilder.group({
      search: new FormControl(''),
      stateFilter: new FormControl('1'),
      column: new FormControl('itemname'),
      order: new FormControl('ASC'),
      idcategoryitem: new FormControl(''),
      idunittype: new FormControl(''),
      numPage: new FormControl(this.itemsPerPage),
    });

    const partUrl = environment.baseUrl.replace('api/', '');
    this.urlBasic =  partUrl;

    this.get(1);
  }

  validInput(id: string) {
    if (this.form.get(id).errors) {
      this.error[id].error = true;
      this.error[id].msg = customValidatorHandler(this.form, id);
    } else {
      this.error[id].error = false;
      this.error[id].msg = '';
    }
  }

  errorInit = () => {
    this.error = {
      idcategoryitem: { error: false, msg: ''},
      idunittype: { error: false, msg: ''},
      itemname: { error: false, msg: ''},
      description: { error: false, msg: ''},
      price: { error: false, msg: ''},
    };
  }

  handleFileInput(files: FileList, fieldName: string) {
    this.fileToUpload = files.item(0);
    // this.form.get(fieldName).setValue(files.item(0));
  }

  getAction(page: number, perPage: number): Observable<FilterServerResponse> {
    const filters = {
      search: this.formFilter.value.search,
      state: this.formFilter.value.stateFilter,
      column: this.formFilter.value.column,
      order: this.formFilter.value.order,
      idcategoryitem: this.formFilter.value.idcategoryitem,
      idunittype: this.formFilter.value.idunittype,
      num_page: this.formFilter.value.numPage
    };
    return from(this.itemService.get(filters, null, page)).pipe(delay(200));
  }

  get = (page: number) => {
    this.errorInit();
    this.ngxService.startLoader('loading-component');
    this.list =  this.getAction(page, this.itemsPerPage).pipe(
      tap(
        (response) => {
          this.getCategory();
          this.getUnitType();
          this.total = response.data.total;
          this.pag = response.data.current_page;
          this.pageDelta = (page - 1) * this.itemsPerPage;
          this.verifyItemToEdit(response.data.data);
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

  getCategory = () => {
    this.listCategory.push({idcategoryitem: '', categoryitemname: '-- Seleccione Categoría --'});
    this.categoryService.get({}).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          response.data.forEach(element => {
            this.listCategory.push({idcategoryitem: element.idcategoryitem, categoryitemname: element.categoryitemname});
          });
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getUnitType = () => {
    this.listUnitType.push({idunittype: '', unittypename: '-- Selecc. Tipo Unidad --'});
    this.unitTypeService.get({}).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          response.data.forEach(element => {
            this.listUnitType.push({idunittype: element.idunittype, unittypename: element.unittypename});
          });
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  action = () => {
    if (this.itemSelected === null) {
      this.add();
    } else {
      this.update(this.itemSelected.iditem);
    }
  }

  edit = (item: any) => {
    this.itemSelected = item;
    this.itemService.get(item.iditem).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.itemSelected = response.data;

          this.form.get('idcategoryitem').setValue(response.data.idcategoryitem);
          this.form.get('idunittype').setValue(response.data.idunittype);
          this.form.get('itemname').setValue(response.data.itemname);
          this.form.get('image').setValue(response.data.image);
          this.form.get('description').setValue(response.data.description);
          this.form.get('price').setValue(response.data.price);
          this.form.get('state').setValue(response.data.state);

          this.titleAside = 'Editar Producto';
          this.formTableView = false;
          this.formView = true;
          this.asideIsOpen = true;
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  verifyItemToEdit = (data) => {
    if (this.itemAddToEdit !== null) {
      data.forEach(element => {
        if (parseInt(this.itemAddToEdit, 0) === parseInt(element.iditem, 0)) {
          this.edit(element);
        }
      });
    }
  }

  update = (id: any) => {
    this.ngxService.startLoader('loading-component');
    const data = {
      idcategoryitem: this.form.value.idcategoryitem,
      idunittype: this.form.value.idunittype,
      itemname: this.form.value.itemname,
      description: this.form.value.description,
      price: this.form.value.price,
      state: this.form.value.state,
      iditem: id
    };
    this.itemService.postFile(data, this.fileToUpload).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.get(1);
        } else {
          this.showNotification('¡Atención!', ICONS_ALERT.warning, response.message, 'warning');
        }
        this.ngxService.stopLoader('loading-component');
      },
      (error) => {
        this.ngxService.stopLoader('loading-component');
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  create = () => {
    this.titleAside = 'Agregar Producto';
    this.form.reset();
    this.form.get('idcategoryitem').setValue('');
    this.form.get('idunittype').setValue('');
    this.form.get('state').setValue(true);
    this.formTableView = false;
    this.formView = true;
    this.asideIsOpen = true;
  }

  add = () => {
    this.ngxService.startLoader('loading-component');
    const state = (this.form.value.state !== null && this.form.value.state !== false) ? true : false;
    const data = {
      idcategoryitem: this.form.value.idcategoryitem,
      idunittype: this.form.value.idunittype,
      itemname: this.form.value.itemname,
      description: this.form.value.description,
      price: this.form.value.price,
      state,
    };
    this.itemService.postFile(data, this.fileToUpload).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside(false, response.id);
          this.get(1);
        } else {
          this.showNotification('¡Atención!', ICONS_ALERT.warning, response.message, 'warning');
        }
        this.ngxService.stopLoader('loading-component');
      },
      (error) => {
        this.ngxService.stopLoader('loading-component');
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  listPrice = () => {
    const data = {
      iditem: this.itemSelected.iditem
    };
    this.itemPriceService.get(data).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.listItemPrice = response.data;
          this.titleAside = 'Lista de Precio';
          this.itemNameSelected = this.itemSelected.itemname + '. ' + this.itemSelected.description;
          this.formView = false;
          this.formTableView = true;
          this.asideIsOpen = true;
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  createPrice = () => {
    const data = {
      iditemprice: 0,
      price: 0.00
    };
    this.listItemPrice.push(data);
  }

  deletePrice = (item: any, pos: number) => {
    if (item.iditemprice === 0) {
      this.listItemPrice.splice(pos, 1);
    } else {
      item.deleted = true;
    }
  }

  cancelConfirmActionListPrice = () => {
    $('#confirmCancel').modal('show');
  }

  cancelActionListPrice = () => {
    this.listPrice();
    $('#confirmCancel').modal('hide');
  }

  actionListPrice = () => {
    this.ngxService.startLoader('loading-component');
    const data = {
      iditem: this.itemSelected.iditem,
      list: this.listItemPrice
    };
    this.itemPriceService.post(data).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.listPrice();
        } else {
          this.showNotification('¡Atención!', ICONS_ALERT.warning, response.message, 'warning');
        }
        this.ngxService.stopLoader('loading-component');
      },
      (error) => {
        this.ngxService.stopLoader('loading-component');
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  confirmDelete = () => {
    this.anything = this.itemSelected.itemname + ' ' + this.itemSelected.description;
    $('#confirmDeleteItem').modal('show');
  }

  delete = () => {
    $('#confirmDeleteItem').modal('hide');
    this.ngxService.startLoader('loading-component');
    this.itemService.delete(this.itemSelected.iditem).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.itemAddToEdit = null;
          this.itemSelected = null;
          this.closeAside();
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.get(1);
        } else {
          this.showNotification('¡Atención!', ICONS_ALERT.warning, response.message, 'warning');
        }
        this.ngxService.stopLoader('loading-component');
      },
      (error) => {
        this.ngxService.stopLoader('loading-component');
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  closeAside = (noClose: boolean = true, id: number = null) => {
    if (noClose) {
      this.asideIsOpen = false;
    }
    this.form.reset();
    this.itemSelected = null;
    this.errorInit();
    this.itemAddToEdit = id;
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
