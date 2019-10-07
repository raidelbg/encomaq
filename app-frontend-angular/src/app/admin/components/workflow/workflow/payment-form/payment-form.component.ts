import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { PaymentFormService } from 'src/app/admin/services/workflow/workflow/payment-form.service';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';

declare var $: any;

@Component({
  selector: 'app-payment-form',
  templateUrl: './payment-form.component.html',
  styleUrls: ['./payment-form.component.scss']
})
export class PaymentFormComponent implements OnInit {

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;

  list = [];
  itemSelected = null;

  constructor(private notification: Notification, private paymentFormService: PaymentFormService,
              private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.get();
    this.form = this.formBuilder.group({
      paymentformname: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      state: new FormControl(true)
    });
  }

  get = () => {
    this.paymentFormService.get({}).subscribe(
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
      this.update(this.itemSelected.idpaymentform);
    }
  }

  edit = (item: any) => {
    this.itemSelected = item;
    this.form.get('paymentformname').setValue(item.paymentformname);
    this.form.get('state').setValue(item.state);
    this.titleAside = 'Editar Forma de Pago';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    const data = {
      paymentformname: this.form.value.paymentformname,
      state: this.form.value.state
    };
    this.paymentFormService.put(id, data).subscribe(
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
    this.titleAside = 'Agregar Forma de Pago';
    this.form.reset();
    this.form.get('state').setValue(true);
    this.asideIsOpen = true;
  }

  add = () => {
    const state = (this.form.value.state !== null && this.form.value.state !== false) ? true : false;
    const data = {
      paymentformname: this.form.value.paymentformname,
      state
    };
    this.paymentFormService.post(data).subscribe(
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
    $('#confirmDeletePaymentForm').modal('show');
  }

  delete = () => {
    this.paymentFormService.delete(this.itemSelected.idpaymentform).subscribe(
      (response) => {
        $('#confirmDeletePaymentForm').modal('hide');
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
