import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { WarehouseService } from 'src/app/admin/services/workflow/workflow/warehouse.service';
import { ICONS_ALERT, CONFIG_LOADING_UI } from 'src/app/shared/classes/ConstantsEnums';
import { customValidatorHandler } from 'src/app/shared/classes/CustomValidators';
import { NgxUiLoaderService } from 'ngx-ui-loader';

declare var $: any;

@Component({
  selector: 'app-warehouse',
  templateUrl: './warehouse.component.html',
  styleUrls: ['./warehouse.component.scss']
})
export class WarehouseComponent implements OnInit {

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;
  error: any;

  list = [];
  itemSelected = null;

  typeSpinnerLoading = CONFIG_LOADING_UI.typeSpinnerLoading;
  overlayColorLoading = CONFIG_LOADING_UI.overlayColorLoading;
  colorAnimation = CONFIG_LOADING_UI.colorAnimation;


  constructor(private notification: Notification, private warehouseService: WarehouseService,
              private formBuilder: FormBuilder, private ngxService: NgxUiLoaderService) { }

  ngOnInit() {
    this.errorInit();
    this.get();
    this.form = this.formBuilder.group({
      warehousename: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      address: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      phone: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      email: new FormControl('', {validators: [Validators.email], updateOn: 'change'}),
      state: new FormControl(true)
    });
  }

  errorInit = () => {
    this.error = {
      warehousename: { error: false, msg: ''},
      address: { error: false, msg: ''},
      phone: { error: false, msg: ''},
      email: { error: false, msg: ''},
    };
  }

  get = () => {
    this.ngxService.startLoader('loading-component');
    this.warehouseService.get({}).subscribe(
      (response) => {
        if (response.success) {
          this.list = response.data;
        }
        this.ngxService.stopLoader('loading-component');
      },
      (error) => {
        this.ngxService.stopLoader('loading-component');
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  action = () => {
    if (this.itemSelected === null) {
      this.add();
    } else {
      this.update(this.itemSelected.idwarehouse);
    }
  }

  edit = (item: any) => {
    this.errorInit();
    this.itemSelected = item;
    this.form.get('warehousename').setValue(item.warehousename);
    this.form.get('address').setValue(item.address);
    this.form.get('phone').setValue(item.phone);
    this.form.get('email').setValue(item.email);
    this.form.get('state').setValue(item.state);
    this.titleAside = 'Editar Bodega';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    this.ngxService.startLoader('loading-component');
    const data = {
      warehousename: this.form.value.warehousename,
      address: this.form.value.address,
      phone: this.form.value.phone,
      email: this.form.value.email,
      state: this.form.value.state
    };
    this.warehouseService.put(id, data).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside();
          this.get();
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
    this.errorInit();
    this.titleAside = 'Agregar Bodega';
    this.form.reset();
    this.form.get('state').setValue(true);
    this.asideIsOpen = true;
  }

  add = () => {
    this.ngxService.startLoader('loading-component');
    const state = (this.form.value.state !== null && this.form.value.state !== false) ? true : false;
    const data = {
      warehousename: this.form.value.warehousename,
      address: this.form.value.address,
      phone: this.form.value.phone,
      email: this.form.value.email,
      state
    };
    this.warehouseService.post(data).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside();
          this.get();
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

  confirmDelete = (item: any) => {
    this.itemSelected = item;
    $('#confirmDeleteWarehouse').modal('show');
  }

  delete = () => {
    $('#confirmDeleteWarehouse').modal('hide');
    this.ngxService.startLoader('loading-component');
    this.warehouseService.delete(this.itemSelected.idwarehouse).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside();
          this.get();
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

  closeAside = () => {
    this.asideIsOpen = false;
    this.form.reset();
    this.itemSelected = null;
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

}
