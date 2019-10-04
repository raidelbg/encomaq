import { Component, OnInit } from '@angular/core';
import { IdentificationtypeService } from 'src/app/admin/services/workflow/catalogue/identificationtype.service';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';

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

  list = [];
  itemSelected = null;

  constructor(private notification: Notification, private identificationTypeService: IdentificationtypeService,
              private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.get();
    this.formIdentifyType = this.formBuilder.group({
      nametypeidentification: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      code: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      state: new FormControl(true)
    });
  }

  get = () => {
    this.identificationTypeService.get({}).subscribe(
      (response) => {
        this.list = response;
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
      this.update(this.itemSelected.id_typeidentification);
    }
  }

  edit = (item: any) => {
    this.itemSelected = item;
    this.formIdentifyType.get('nametypeidentification').setValue(item.nametypeidentification);
    this.formIdentifyType.get('code').setValue(item.code);
    this.formIdentifyType.get('state').setValue(item.state);
    this.titleAside = 'Editar Tipo Identificación';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    const data = {
      nametypeidentification: this.formIdentifyType.value.nametypeidentification,
      code: this.formIdentifyType.value.code,
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
      nametypeidentification: this.formIdentifyType.value.nametypeidentification,
      code: this.formIdentifyType.value.code,
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
    this.identificationTypeService.delete(this.itemSelected.id_typeidentification).subscribe(
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
