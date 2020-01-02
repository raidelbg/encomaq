import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { UnitTypeService } from 'src/app/admin/services/workflow/catalogue/unit-type.service';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';
import { customValidatorHandler } from 'src/app/shared/classes/CustomValidators';

declare var $: any;

@Component({
  selector: 'app-unit-type',
  templateUrl: './unit-type.component.html',
  styleUrls: ['./unit-type.component.scss']
})
export class UnitTypeComponent implements OnInit {

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;
  error = {
    unittypename: { error: false, msg: ''},
  };

  list = [];
  itemSelected = null;

  constructor(private notification: Notification, private unitTypeService: UnitTypeService,
              private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.get();
    this.form = this.formBuilder.group({
      unittypename: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      state: new FormControl(true)
    });
  }

  get = () => {
    this.unitTypeService.get({}).subscribe(
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
      this.update(this.itemSelected.idunittype);
    }
  }

  edit = (item: any) => {
    this.error = {
      unittypename: { error: false, msg: ''},
    };
    this.itemSelected = item;
    this.form.get('unittypename').setValue(item.unittypename);
    this.form.get('state').setValue(item.state);
    this.titleAside = 'Editar Tipo de Unidad';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    const data = {
      unittypename: this.form.value.unittypename,
      state: this.form.value.state
    };
    this.unitTypeService.put(id, data).subscribe(
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
    this.error = {
      unittypename: { error: false, msg: ''},
    };
    this.titleAside = 'Agregar Tipo Unidad';
    this.form.reset();
    this.form.get('state').setValue(true);
    this.asideIsOpen = true;
  }

  add = () => {
    const state = (this.form.value.state !== null && this.form.value.state !== false) ? true : false;
    const data = {
      unittypename: this.form.value.unittypename,
      state
    };
    this.unitTypeService.post(data).subscribe(
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
    $('#confirmDeleteUnitType').modal('show');
  }

  delete = () => {
    this.unitTypeService.delete(this.itemSelected.idunittype).subscribe(
      (response) => {
        $('#confirmDeleteUnitType').modal('hide');
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
