import { Component, OnInit, OnDestroy } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';
import { IdentificationtypeService } from 'src/app/admin/services/workflow/catalogue/identificationtype.service';
import { ClientService } from 'src/app/admin/services/workflow/workflow/client.service';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';

declare var $: any;

@Component({
  selector: 'app-client',
  templateUrl: './client.component.html',
  styleUrls: ['./client.component.scss']
})
export class ClientComponent implements OnInit, OnDestroy {

  private destroySubscription$ = new Subject();

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;
  formFilter: FormGroup;

  list = [];
  listIdentifyType = [];
  itemSelected = null;
  anything = '';

  constructor(private notification: Notification, private clientService: ClientService,
              private identifyTypeService: IdentificationtypeService, private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.form = this.formBuilder.group({
      ididentifytype: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      identify: new FormControl('', {validators: [Validators.required, Validators.pattern('^[0-9]*$')], updateOn: 'change'}),
      businessname: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      phone: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),

      phone_2: new FormControl(''),
      address: new FormControl(''),
      email: new FormControl('', {validators: [Validators.required, Validators.email], updateOn: 'change'}),
      email_2: new FormControl('', {validators: [Validators.email], updateOn: 'change'}),
      email_3: new FormControl('', {validators: [Validators.email], updateOn: 'change'}),
      observation: new FormControl(''),

      state: new FormControl(true),
    });
    this.formFilter = this.formBuilder.group({
      search: new FormControl(''),
      stateFilter: new FormControl('1'),
      column: new FormControl('businessname'),
      order: new FormControl('ASC'),
      numPage: new FormControl(5),
    });

    this.getIdentifyType();
  }

  get = () => {
    const filters = {
      search: this.formFilter.value.search,
      state: this.formFilter.value.stateFilter,
      column: this.formFilter.value.column,
      order: this.formFilter.value.order,
      num_page: this.formFilter.value.num_page
    };
    this.clientService.get(filters).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        this.list = response;
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  getIdentifyType = () => {
    this.listIdentifyType.push({ididentifytype: '', identifytypename: '-- Seleccione Tipo Identificación --'});
    this.identifyTypeService.get({}).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        response.forEach(element => {
          this.listIdentifyType.push({ididentifytype: element.ididentifytype, identifytypename: element.identifytypename});
        });
        this.get();
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
      this.update(this.itemSelected.idclient);
    }
  }

  info = (item: any) => {
    this.itemSelected = item;
    $('#infoClient').modal('show');
  }

  edit = (item: any) => {
    this.itemSelected = item;
    this.form.get('ididentifytype').setValue(item.ididentifytype);
    this.form.get('identify').setValue(item.identify);
    this.form.get('businessname').setValue(item.businessname);
    this.form.get('phone').setValue(item.phone);
    this.form.get('phone_2').setValue(item.phone_2);
    this.form.get('address').setValue(item.address);
    this.form.get('email').setValue(item.email);
    this.form.get('email_2').setValue(item.email_2);
    this.form.get('email_3').setValue(item.email_3);
    this.form.get('observation').setValue(item.observation);
    this.form.get('state').setValue(item.state);

    this.titleAside = 'Editar Cliente';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    const data = {
      ididentifytype: this.form.value.ididentifytype,
      identify: this.form.value.identify,
      businessname: this.form.value.businessname,
      phone: this.form.value.phone,
      phone_2: this.form.value.phone_2,
      address: this.form.value.address,
      email: this.form.value.email,
      email_2: this.form.value.email_2,
      email_3: this.form.value.email_3,
      observation: this.form.value.observation,
      state: this.form.value.state,
    };
    this.clientService.put(id, data).pipe(takeUntil(this.destroySubscription$)).subscribe(
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
    this.titleAside = 'Agregar Cliente';
    this.form.reset();
    this.form.get('ididentifytype').setValue('');
    this.form.get('state').setValue(true);

    this.asideIsOpen = true;
  }

  add = () => {
    const state = (this.form.value.state !== null && this.form.value.state !== false) ? true : false;
    const data = {
      ididentifytype: this.form.value.ididentifytype,
      identify: this.form.value.identify,
      businessname: this.form.value.businessname,
      phone: this.form.value.phone,
      phone_2: this.form.value.phone_2,
      address: this.form.value.address,
      email: this.form.value.email,
      email_2: this.form.value.email_2,
      email_3: this.form.value.email_3,
      observation: this.form.value.observation,
      state,
    };
    this.clientService.post(data).pipe(takeUntil(this.destroySubscription$)).subscribe(
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
    this.anything = item.businessname;
    $('#confirmDeleteClient').modal('show');
  }

  delete = () => {
    this.clientService.delete(this.itemSelected.idclient).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        $('#confirmDeleteClient').modal('hide');
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

  closeAside = () => {
    this.asideIsOpen = false;
    this.form.reset();
    this.itemSelected = null;
  }

  exportToPDF = () => {
    const filters = {
      search: this.formFilter.value.search,
      state: this.formFilter.value.stateFilter,
      column: this.formFilter.value.column,
      order: this.formFilter.value.order
    };

    const action = this.clientService.exportToPDF(filters);

    // console.log(action);
    this.clientService.exportToPDF(filters).subscribe(
      response => console.log(response.text())
      /*(response) => {
        console.log(response);
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      }*/
    );

    /*$('#printtitle').html('Lista de Clientes');
    $('#print').modal('show');
    // $('#printbody').html("<object width='100%' height='600' data='" + action + "'></object>");
    $('#printbody').html('<object width="100%" height="600" data="' + action + '"></object>');*/
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

  ngOnDestroy(): void {
    this.destroySubscription$.next();     // trigger the unsubscribe
    this.destroySubscription$.complete(); // finalize & clean up the subject stream
  }

}
