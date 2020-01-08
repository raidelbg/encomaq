import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ICONS_ALERT, CONFIG_LOADING_UI } from 'src/app/shared/classes/ConstantsEnums';
import { UserService } from 'src/app/admin/services/workflow/catalogue/user.service';
import { RoleService } from 'src/app/admin/services/workflow/catalogue/role.service';
import { NgxUiLoaderService } from 'ngx-ui-loader';

declare var $: any;

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.scss']
})
export class UserComponent implements OnInit {

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;
  formFilter: FormGroup;

  list = [];
  listRole = [];
  itemSelected = null;

  flagActionEdit = false;

  typeSpinnerLoading = CONFIG_LOADING_UI.typeSpinnerLoading;
  overlayColorLoading = CONFIG_LOADING_UI.overlayColorLoading;
  colorAnimation = CONFIG_LOADING_UI.colorAnimation;

  constructor(private notification: Notification, private userService: UserService, private roleService: RoleService,
              private formBuilder: FormBuilder, private ngxService: NgxUiLoaderService) { }

  ngOnInit() {
    this.form = this.formBuilder.group({
      idrole: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      personname: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      lastnameperson: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      email: new FormControl('', {validators: [Validators.required, Validators.email], updateOn: 'change'}),
      password: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      passwordEdit: new FormControl(''),
      state: new FormControl(true),
    });
    this.formFilter = this.formBuilder.group({
      search: new FormControl(''),
      idrole: new FormControl(''),
      stateFilter: new FormControl('1'),
      column: new FormControl('personname'),
      order: new FormControl('ASC'),
      numPage: new FormControl(5),
    });

    this.getRole();
  }

  get = () => {
    this.ngxService.startLoader('loading-component');
    const filters = {
      search: this.formFilter.value.search,
      idrole: this.formFilter.value.idrole,
      state: this.formFilter.value.stateFilter,
      column: this.formFilter.value.column,
      order: this.formFilter.value.order,
      num_page: this.formFilter.value.num_page
    };
    this.userService.get(filters).subscribe(
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

  getRole = () => {
    this.listRole.push({idrole: '', rolename: '-- Seleccione Rol --'});
    this.roleService.get({}).subscribe(
      (response) => {
        if (response.success) {
          response.data.forEach(element => {
            this.listRole.push({idrole: element.idrole, rolename: element.rolename});
          });
          this.get();
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
      this.update(this.itemSelected.iduser);
    }
  }

  edit = (item: any) => {
    this.itemSelected = item;
    this.form.get('idrole').setValue(item.idrole);
    this.form.get('personname').setValue(item.personname);
    this.form.get('lastnameperson').setValue(item.lastnameperson);
    this.form.get('email').setValue(item.email);
    this.form.get('state').setValue(item.state);

    this.form.get('password').setValue(true);

    this.titleAside = 'Editar Usuario';
    this.flagActionEdit = true;
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    this.ngxService.startLoader('loading-component');
    const password = (this.form.value.passwordEdit !== null && this.form.value.passwordEdit !== '') ? this.form.value.passwordEdit : false;
    const data = {
      idrole: this.form.value.idrole,
      personname: this.form.value.personname,
      lastnameperson: this.form.value.lastnameperson,
      email: this.form.value.email,
      password,
      state: this.form.value.state,
    };
    this.userService.put(id, data).subscribe(
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
    this.titleAside = 'Agregar Usuario';
    this.form.reset();
    this.form.get('idrole').setValue('');
    this.form.get('state').setValue(true);
    this.flagActionEdit = false;
    this.asideIsOpen = true;
  }

  add = () => {
    this.ngxService.startLoader('loading-component');
    const state = (this.form.value.state !== null && this.form.value.state !== false) ? true : false;
    const data = {
      idrole: this.form.value.idrole,
      personname: this.form.value.personname,
      lastnameperson: this.form.value.lastnameperson,
      email: this.form.value.email,
      password: this.form.value.password,
      state,
    };
    this.userService.post(data).subscribe(
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
    $('#confirmDeleteUser').modal('show');
  }

  delete = () => {
    $('#confirmDeleteUser').modal('hide');
    this.ngxService.startLoader('loading-component');
    this.userService.delete(this.itemSelected.iduser).subscribe(
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
