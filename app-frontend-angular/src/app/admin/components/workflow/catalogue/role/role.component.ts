import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { RoleService } from 'src/app/admin/services/workflow/catalogue/role.service';
import { ICONS_ALERT, CONFIG_LOADING_UI } from 'src/app/shared/classes/ConstantsEnums';
import { NgxUiLoaderService } from 'ngx-ui-loader';

declare var $: any;

@Component({
  selector: 'app-role',
  templateUrl: './role.component.html',
  styleUrls: ['./role.component.scss']
})
export class RoleComponent implements OnInit {

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;

  list = [];
  itemSelected = null;

  typeSpinnerLoading = CONFIG_LOADING_UI.typeSpinnerLoading;
  overlayColorLoading = CONFIG_LOADING_UI.overlayColorLoading;
  colorAnimation = CONFIG_LOADING_UI.colorAnimation;

  constructor(private notification: Notification, private roleService: RoleService,
              private formBuilder: FormBuilder, private ngxService: NgxUiLoaderService) { }

  ngOnInit() {
    this.get();
    this.form = this.formBuilder.group({
      rolename: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
    });
  }

  get = () => {
    this.ngxService.startLoader('loading-component');
    this.roleService.get({}).subscribe(
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
      this.update(this.itemSelected.idrole);
    }
  }

  edit = (item: any) => {
    this.itemSelected = item;
    this.form.get('rolename').setValue(item.rolename);
    this.titleAside = 'Editar Rol';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    this.ngxService.startLoader('loading-component');
    const data = {
      rolename: this.form.value.rolename,
    };
    this.roleService.put(id, data).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside();
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
    this.titleAside = 'Agregar Rol';
    this.form.reset();
    this.asideIsOpen = true;
  }

  add = () => {
    this.ngxService.startLoader('loading-component');
    const data = {
      rolename: this.form.value.rolename
    };
    this.roleService.post(data).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside();
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
    $('#confirmDeleteRole').modal('show');
  }

  delete = () => {
    $('#confirmDeleteRole').modal('hide');
    this.ngxService.startLoader('loading-component');
    this.roleService.delete(this.itemSelected.idrole).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
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
    this.get();
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
