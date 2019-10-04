import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { PaymentResidentService } from 'src/app/admin/services/workflow/catalogue/payment-resident/payment-resident.service';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';

declare var $: any;

@Component({
  selector: 'app-payment-resident',
  templateUrl: './payment-resident.component.html',
  styleUrls: ['./payment-resident.component.scss']
})
export class PaymentResidentComponent implements OnInit {

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  formPaymentResident: FormGroup;

  list = [];
  itemSelected = null;

  constructor(private notification: Notification, private formBuilder: FormBuilder,
              private paymentResidentService: PaymentResidentService) { }

  ngOnInit() {
    this.formPaymentResident = this.formBuilder.group({
      namepaymentresident: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      code: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      state: new FormControl(true)
    });
    this.get();
  }

  get = () => {
    this.paymentResidentService.get({}).subscribe(
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
      this.update(this.itemSelected.id_paymentresident);
    }
  }

  edit = (item: any) => {
    this.itemSelected = item;
    this.formPaymentResident.get('namepaymentresident').setValue(item.namepaymentresident);
    this.formPaymentResident.get('code').setValue(item.code);
    this.formPaymentResident.get('state').setValue(item.state);
    this.titleAside = 'Editar Pago Residente';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    const data = {
      namepaymentresident: this.formPaymentResident.value.namepaymentresident,
      code: this.formPaymentResident.value.code,
      state: this.formPaymentResident.value.state
    };
    this.paymentResidentService.put(id, data).subscribe(
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
    this.titleAside = 'Agregar Pago Residente';
    this.formPaymentResident.reset();
    this.formPaymentResident.get('state').setValue(true);
    this.asideIsOpen = true;
  }

  add = () => {
    const state = (this.formPaymentResident.value.state !== null && this.formPaymentResident.value.state !== false) ? true : false;
    const data = {
      namepaymentresident: this.formPaymentResident.value.namepaymentresident,
      code: this.formPaymentResident.value.code,
      state
    };
    this.paymentResidentService.post(data).subscribe(
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
    $('#confirmDeletePaymentResident').modal('show');
  }

  delete = () => {
    this.paymentResidentService.delete(this.itemSelected.id_paymentresident).subscribe(
      (response) => {
        $('#confirmDeletePaymentResident').modal('hide');
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
    this.formPaymentResident.reset();
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
