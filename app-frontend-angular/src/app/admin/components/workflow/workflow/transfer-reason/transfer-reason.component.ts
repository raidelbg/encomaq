import { Component, OnInit } from '@angular/core';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { TransferReasonService } from 'src/app/admin/services/workflow/workflow/transfer-reason.service';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';

declare var $: any;

@Component({
  selector: 'app-transfer-reason',
  templateUrl: './transfer-reason.component.html',
  styleUrls: ['./transfer-reason.component.scss']
})
export class TransferReasonComponent implements OnInit {

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;

  list = [];
  listTypeTransferReason = [];
  itemSelected = null;

  constructor(private notification: Notification, private transferReasonService: TransferReasonService,
              private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.get();
    this.getTypeTransferReason();
    this.form = this.formBuilder.group({
      transferreasonname: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      idtypetransferreason: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      state: new FormControl(true)
    });
  }

  get = () => {
    this.transferReasonService.get({}).subscribe(
      (response) => {
        this.list = response;
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getTypeTransferReason = () => {
    this.transferReasonService.get({}, null, 'type-reason').subscribe(
      (response) => {
        this.listTypeTransferReason = response;
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
      this.update(this.itemSelected.idtransferreason);
    }
  }

  edit = (item: any) => {
    this.itemSelected = item;
    this.form.get('transferreasonname').setValue(item.transferreasonname);
    this.form.get('idtypetransferreason').setValue(item.idtypetransferreason);
    this.form.get('state').setValue(item.state);
    this.titleAside = 'Editar Motivo Traslado';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    const data = {
      transferreasonname: this.form.value.transferreasonname,
      idtypetransferreason: this.form.value.idtypetransferreason,
      state: this.form.value.state
    };
    this.transferReasonService.put(id, data).subscribe(
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
    this.titleAside = 'Agregar Motivo Traslado';
    this.form.reset();
    this.form.get('state').setValue(true);
    this.asideIsOpen = true;
  }

  add = () => {
    const state = (this.form.value.state !== null && this.form.value.state !== false) ? true : false;
    const data = {
      transferreasonname: this.form.value.transferreasonname,
      idtypetransferreason: this.form.value.idtypetransferreason,
      state
    };
    this.transferReasonService.post(data).subscribe(
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
    $('#confirmDeleteTransferReason').modal('show');
  }

  delete = () => {
    this.transferReasonService.delete(this.itemSelected.idtransferreason).subscribe(
      (response) => {
        $('#confirmDeleteTransferReason').modal('hide');
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
