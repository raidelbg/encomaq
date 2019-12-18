import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { from, Observable } from 'rxjs';
import { tap, map, delay } from 'rxjs/operators';
import { ItemService } from 'src/app/admin/services/workflow/workflow/item.service';
import { CategoryItemService } from 'src/app/admin/services/workflow/catalogue/category-item.service';
import { UnitTypeService } from 'src/app/admin/services/workflow/catalogue/unit-type.service';

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

  list: Observable<any[]>;
  listIdentifyType = [];
  listCategory = [];
  listUnitType = [];
  itemSelected = null;
  anything = '';

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

  constructor(private notification: Notification, private itemService: ItemService, private formBuilder: FormBuilder,
              private categoryService: CategoryItemService, private unitTypeService: UnitTypeService) { }

  ngOnInit() {
    this.form = this.formBuilder.group({
      idcategoryitem: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      idunittype: new FormControl('', {validators: [Validators.required, Validators.pattern('^[0-9]*$')], updateOn: 'change'}),
      itemname: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      image: new FormControl(''),
      description: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      price: new FormControl(''),
      state: new FormControl(true),
    });
    this.formFilter = this.formBuilder.group({
      search: new FormControl(''),
      stateFilter: new FormControl('1'),
      column: new FormControl('itemname'),
      order: new FormControl('ASC'),
      idcategoryitem: new FormControl(''),
      idunittype: new FormControl(''),
      numPage: new FormControl(12),
    });

    this.get(1);
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
    this.list =  this.getAction(page, 12).pipe(
      tap(
        (response) => {
          this.getCategory();
          this.getUnitType();
          this.total = response.data.total;
          this.pag = response.data.current_page;
          this.pageDelta = (page - 1) * 12;

        },
        (error) => {
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

  info = (item: any) => {
    this.itemSelected = item;
    $('#infoItem').modal('show');
  }

  edit = (item: any) => {
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
          this.asideIsOpen = true;
        }
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  update = (id: any) => {
    const data = {
      idcategoryitem: this.form.value.idcategoryitem,
      idunittype: this.form.value.idunittype,
      itemname: this.form.value.itemname,
      image: this.form.value.image,
      description: this.form.value.description,
      price: this.form.value.price,
      state: this.form.value.state,
    };
    this.itemService.put(id, data).pipe(takeUntil(this.destroySubscription$)).subscribe(
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

  create = () => {
    this.titleAside = 'Agregar Producto';
    this.form.reset();
    this.form.get('idcategoryitem').setValue('');
    this.form.get('idunittype').setValue('');
    this.form.get('state').setValue(true);

    this.asideIsOpen = true;
  }

  add = () => {
    const state = (this.form.value.state !== null && this.form.value.state !== false) ? true : false;
    const data = {
      idcategoryitem: this.form.value.idcategoryitem,
      idunittype: this.form.value.idunittype,
      itemname: this.form.value.itemname,
      image: this.form.value.image,
      description: this.form.value.description,
      price: this.form.value.price,
      state,
    };
    this.itemService.post(data).pipe(takeUntil(this.destroySubscription$)).subscribe(
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
    this.anything = item.itemname + ' ' + item.description;
    $('#confirmDeleteItem').modal('show');
  }

  delete = () => {
    this.itemService.delete(this.itemSelected.iditem).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        $('#confirmDeleteItem').modal('hide');
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
