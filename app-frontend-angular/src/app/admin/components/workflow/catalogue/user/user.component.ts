import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';
import { UserService } from 'src/app/admin/services/workflow/catalogue/user.service';
import { RoleService } from 'src/app/admin/services/workflow/catalogue/role.service';

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

  constructor(private notification: Notification, private userService: UserService, private roleService: RoleService,
              private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.form = this.formBuilder.group({
      idrole: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      personname: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      lastnameperson: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      email: new FormControl('', {validators: [Validators.required, Validators.email], updateOn: 'change'}),
      password: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
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
        this.list = response;
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getRole = () => {
    this.listRole.push({idrole: '', rolename: '-- Seleccione Rol --'});
    this.roleService.get({}).subscribe(
      (response) => {
        response.forEach(element => {
          this.listRole.push({idrole: element.idrole, rolename: element.rolename});
        });
        this.get();
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

    this.titleAside = 'Editar Usuario';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    const data = {
      idrole: this.form.value.idrole,
      personname: this.form.value.personname,
      lastnameperson: this.form.value.lastnameperson,
      email: this.form.value.email,
      password: this.form.value.password,
      state: this.form.value.state,
    };
    this.userService.put(id, data).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside();
          this.get();
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
    this.titleAside = 'Agregar Usuario';
    this.form.reset();
    this.form.get('state').setValue(true);
    this.asideIsOpen = true;
  }

  add = () => {
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
          this.get();
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
    $('#confirmDeleteUser').modal('show');
  }

  delete = () => {
    this.userService.delete(this.itemSelected.iduser).subscribe(
      (response) => {
        $('#confirmDeleteUser').modal('hide');
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.get();
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

}
