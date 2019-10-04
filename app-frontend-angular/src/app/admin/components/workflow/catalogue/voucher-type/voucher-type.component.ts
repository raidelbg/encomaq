import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { VoucherTypeService } from 'src/app/admin/services/workflow/catalogue/voucher-type/voucher-type.service';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';

declare var $: any;

@Component({
  selector: 'app-voucher-type',
  templateUrl: './voucher-type.component.html',
  styleUrls: ['./voucher-type.component.scss']
})
export class VoucherTypeComponent implements OnInit {

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  formVoucherType: FormGroup;

  list = [];
  itemSelected = null;

  constructor(private notification: Notification, private formBuilder: FormBuilder,
              private voucherTypeService: VoucherTypeService) { }

  ngOnInit() {
    this.formVoucherType = this.formBuilder.group({
      nametypevoucher: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      code: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      state: new FormControl(true)
    });
    this.get();
  }

  get = () => {
    this.voucherTypeService.get({}).subscribe(
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
      this.update(this.itemSelected.id_typevoucher);
    }
  }

  edit = (item: any) => {
    this.itemSelected = item;
    this.formVoucherType.get('nametypevoucher').setValue(item.nametypevoucher);
    this.formVoucherType.get('code').setValue(item.code);
    this.formVoucherType.get('state').setValue(item.state);
    this.titleAside = 'Editar Tipo de Comprobante';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    const data = {
      nametypevoucher: this.formVoucherType.value.nametypevoucher,
      code: this.formVoucherType.value.code,
      state: this.formVoucherType.value.state
    };
    this.voucherTypeService.put(id, data).subscribe(
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
    this.titleAside = 'Agregar Tipo de Comprobante';
    this.formVoucherType.reset();
    this.formVoucherType.get('state').setValue(true);
    this.asideIsOpen = true;
  }

  add = () => {
    const state = (this.formVoucherType.value.state !== null && this.formVoucherType.value.state !== false) ? true : false;
    const data = {
      nametypevoucher: this.formVoucherType.value.nametypevoucher,
      code: this.formVoucherType.value.code,
      state
    };
    this.voucherTypeService.post(data).subscribe(
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
    $('#confirmDeleteTypeVoucher').modal('show');
  }

  delete = () => {
    this.voucherTypeService.delete(this.itemSelected.id_typevoucher).subscribe(
      (response) => {
        $('#confirmDeleteTypeVoucher').modal('hide');
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
    this.formVoucherType.reset();
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
