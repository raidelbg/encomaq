import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { CategoryItemService } from 'src/app/admin/services/workflow/catalogue/category-item.service';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';

declare var $: any;

@Component({
  selector: 'app-category-item',
  templateUrl: './category-item.component.html',
  styleUrls: ['./category-item.component.scss']
})
export class CategoryItemComponent implements OnInit {

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;

  list = [];
  itemSelected = null;

  constructor(private notification: Notification, private categoryItemService: CategoryItemService,
              private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.get();
    this.form = this.formBuilder.group({
      categoryitemname: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      state: new FormControl(true)
    });
  }

  get = () => {
    this.categoryItemService.get({}).subscribe(
      (response) => {
        if (response.success) {
          this.list = response.data;
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
      this.update(this.itemSelected.idcategoryitem);
    }
  }

  edit = (item: any) => {
    this.itemSelected = item;
    this.form.get('categoryitemname').setValue(item.categoryitemname);
    this.form.get('state').setValue(item.state);
    this.titleAside = 'Editar Categoría Item';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    const data = {
      categoryitemname: this.form.value.categoryitemname,
      state: this.form.value.state
    };
    this.categoryItemService.put(id, data).subscribe(
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
    this.titleAside = 'Agregar Categoría Item';
    this.form.reset();
    this.form.get('state').setValue(true);
    this.asideIsOpen = true;
  }

  add = () => {
    const state = (this.form.value.state !== null && this.form.value.state !== false) ? true : false;
    const data = {
      categoryitemname: this.form.value.categoryitemname,
      state
    };
    this.categoryItemService.post(data).subscribe(
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
    $('#confirmDeleteCategoryItem').modal('show');
  }

  delete = () => {
    this.categoryItemService.delete(this.itemSelected.idcategoryitem).subscribe(
      (response) => {
        $('#confirmDeleteCategoryItem').modal('hide');
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
