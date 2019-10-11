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
      rolename: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
    });
    this.formFilter = this.formBuilder.group({
      search: new FormControl(''),
      idrole: new FormControl(''),
      state: new FormControl('1'),
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
      state: this.formFilter.value.state,
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
