import { Component, OnInit } from '@angular/core';
import { IdentificationtypeService } from 'src/app/admin/services/workflow/catalogue/identificationtype.service';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';
import { customValidatorHandler } from 'src/app/shared/classes/CustomValidators';

declare var $: any;

@Component({
  selector: 'app-identificationtype',
  templateUrl: './identificationtype.component.html',
  styleUrls: ['./identificationtype.component.scss']
})
export class IdentificationtypeComponent implements OnInit {

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  formIdentifyType: FormGroup;
  error = {
    identifytypename: { error: false, msg: ''},
    identifylength: { error: false, msg: ''},
  };

  list = [];
  itemSelected = null;

  constructor(private notification: Notification, private identificationTypeService: IdentificationtypeService,
              private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.get();
    this.formIdentifyType = this.formBuilder.group({
      identifytypename: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      identifylength: new FormControl('', {validators: [Validators.pattern('^[0-9]*$')], updateOn: 'change'}),
      state: new FormControl(true)
    });
  }

  get = () => {
    this.identificationTypeService.get({}).subscribe(
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
      this.update(this.itemSelected.ididentifytype);
    }
  }

  edit = (item: any) => {
    this.itemSelected = item;
    this.formIdentifyType.get('identifytypename').setValue(item.identifytypename);
    this.formIdentifyType.get('identifylength').setValue(item.identifylength);
    this.formIdentifyType.get('state').setValue(item.state);
    this.titleAside = 'Editar Tipo Identificación';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    const data = {
      identifytypename: this.formIdentifyType.value.identifytypename,
      identifylength: this.formIdentifyType.value.identifylength,
      state: this.formIdentifyType.value.state
    };
    this.identificationTypeService.put(id, data).subscribe(
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
    this.titleAside = 'Agregar Tipo Identificación';
    this.formIdentifyType.reset();
    this.formIdentifyType.get('state').setValue(true);
    this.asideIsOpen = true;
  }

  add = () => {
    const state = (this.formIdentifyType.value.state !== null && this.formIdentifyType.value.state !== false) ? true : false;
    const data = {
      identifytypename: this.formIdentifyType.value.identifytypename,
      identifylength: this.formIdentifyType.value.identifylength,
      state
    };
    this.identificationTypeService.post(data).subscribe(
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
    $('#confirmDeleteIdentificationType').modal('show');
  }

  delete = () => {
    this.identificationTypeService.delete(this.itemSelected.ididentifytype).subscribe(
      (response) => {
        $('#confirmDeleteIdentificationType').modal('hide');
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
    this.formIdentifyType.reset();
    this.itemSelected = null;
  }

  validInput(id: string) {
    if (this.formIdentifyType.get(id).errors) {
      this.error[id].error = true;
      this.error[id].msg = customValidatorHandler(this.formIdentifyType, id);
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
