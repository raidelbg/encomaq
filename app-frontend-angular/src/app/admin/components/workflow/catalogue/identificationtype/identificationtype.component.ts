import { Component, OnInit } from '@angular/core';
import { IdentificationtypeService } from 'src/app/admin/services/workflow/catalogue/identificationtype.service';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { ICONS_ALERT, CONFIG_LOADING_UI } from 'src/app/shared/classes/ConstantsEnums';
import { customValidatorHandler } from 'src/app/shared/classes/CustomValidators';
import { NgxUiLoaderService } from 'ngx-ui-loader';

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

  typeSpinnerLoading = CONFIG_LOADING_UI.typeSpinnerLoading;
  overlayColorLoading = CONFIG_LOADING_UI.overlayColorLoading;
  colorAnimation = CONFIG_LOADING_UI.colorAnimation;

  constructor(private notification: Notification, private identificationTypeService: IdentificationtypeService,
              private formBuilder: FormBuilder, private ngxService: NgxUiLoaderService) { }

  ngOnInit() {
    this.get();
    this.formIdentifyType = this.formBuilder.group({
      identifytypename: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      identifylength: new FormControl('', {validators: [Validators.pattern('^[0-9]*$')], updateOn: 'change'}),
      state: new FormControl(true)
    });
  }

  get = () => {
    this.ngxService.startLoader('loading-component');
    this.identificationTypeService.get({}).subscribe(
      (response) => {
        if (response.success) {
          this.list = response.data;
          this.ngxService.stopLoader('loading-component');
        }
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
    this.ngxService.startLoader('loading-component');
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
          this.ngxService.stopLoader('loading-component');
        } else {
          this.ngxService.stopLoader('loading-component');
          this.showNotification('¡Atención!', ICONS_ALERT.warning, response.message, 'warning');
        }
      },
      (error) => {
        this.ngxService.stopLoader('loading-component');
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
    this.ngxService.startLoader('loading-component');
    const state = (this.formIdentifyType.value.state !== null && this.formIdentifyType.value.state !== false) ? true : false;
    const data = {
      identifytypename: this.formIdentifyType.value.identifytypename,
      identifylength: this.formIdentifyType.value.identifylength,
      state
    };
    this.identificationTypeService.post(data).subscribe(
      (response) => {
        if (response.success) {
          this.ngxService.stopLoader('loading-component');
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside();
          this.get();
        } else {
          this.ngxService.stopLoader('loading-component');
          this.showNotification('¡Atención!', ICONS_ALERT.warning, response.message, 'warning');
        }
      },
      (error) => {
        this.ngxService.stopLoader('loading-component');
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  confirmDelete = (item: any) => {
    this.itemSelected = item;
    $('#confirmDeleteIdentificationType').modal('show');
  }

  delete = () => {
    $('#confirmDeleteIdentificationType').modal('hide');
    this.ngxService.startLoader('loading-component');
    this.identificationTypeService.delete(this.itemSelected.ididentifytype).subscribe(
      (response) => {
        if (response.success) {
          this.ngxService.stopLoader('loading-component');
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside();
          this.get();
        } else {
          this.ngxService.stopLoader('loading-component');
          this.showNotification('¡Atención!', ICONS_ALERT.warning, response.message, 'warning');
        }
      },
      (error) => {
        this.ngxService.stopLoader('loading-component');
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
