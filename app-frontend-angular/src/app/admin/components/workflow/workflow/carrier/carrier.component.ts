import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';
import { CarrierService } from 'src/app/admin/services/workflow/workflow/carrier.service';
import { Subject } from 'rxjs';
import { from, Observable } from 'rxjs';
import { tap, map, delay } from 'rxjs/operators';
import { IdentificationtypeService } from 'src/app/admin/services/workflow/catalogue/identificationtype.service';

declare var $: any;

interface FilterServerResponse {
  data: any;
  total: number;
}
@Component({
  selector: 'app-carrier',
  templateUrl: './carrier.component.html',
  styleUrls: ['./carrier.component.scss']
})
export class CarrierComponent implements OnInit {

  private destroySubscription$ = new Subject();

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;
  formFilter: FormGroup;

  list: Observable<any[]>;
  listIdentifyType = [];
  itemSelected = null;

  public labels: any = {
    previousLabel: 'Anterior',
    nextLabel: 'Siguiente',
    screenReaderPaginationLabel: 'Paginado',
    screenReaderPageLabel: 'página',
    screenReaderCurrentLabel: `Estas en la página`
  };

  // tslint:disable-next-line: no-input-rename
  @Input('data') reportData: any[] = [];
  pag = 1;
  pageDelta = 1;
  total = 0;

  constructor(private notification: Notification, private carrierService: CarrierService,
              private identifyTypeService: IdentificationtypeService, private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.form = this.formBuilder.group({
      ididentifytype: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      identify: new FormControl('', {validators: [Validators.required, Validators.pattern('^[0-9]*$')], updateOn: 'change'}),
      carriername: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      licenseplate: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      state: new FormControl(true),
    });
    this.formFilter = this.formBuilder.group({
      search: new FormControl(''),
      stateFilter: new FormControl('1'),
      column: new FormControl('carriername'),
      order: new FormControl('ASC'),
      numPage: new FormControl(12),
    });

    this.getIdentifyType();
  }

  getAction(page: number, perPage: number): Observable<FilterServerResponse> {
    const filters = {
      search: this.formFilter.value.search,
      state: this.formFilter.value.stateFilter,
      column: this.formFilter.value.column,
      order: this.formFilter.value.order,
      num_page: this.formFilter.value.numPage
    };
    return from(this.carrierService.get(filters, null, page)).pipe(delay(200));
  }

  get = (page: number) => {
    this.list =  this.getAction(page, 12).pipe(
      tap(
        (response) => {

          this.total = response.data.total;
          this.pag = response.data.current_page;
          this.pageDelta = (page - 1) * 12;

        },
        (error) => {
          console.error(error);
        }
      ),
      map(response => response.data.data)
    );
  }

  getIdentifyType = () => {
    this.listIdentifyType.push({ididentifytype: '', identifytypename: '-- Seleccione Tipo Identificación --'});
    this.identifyTypeService.get({}).subscribe(
      (response) => {
        if (response.success) {
          response.data.forEach(element => {
            this.listIdentifyType.push({ididentifytype: element.ididentifytype, identifytypename: element.identifytypename});
          });
          this.get(1);
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
      this.update(this.itemSelected.idcarrier);
    }
  }

  edit = (item: any) => {
    this.itemSelected = item;
    this.form.get('ididentifytype').setValue(item.ididentifytype);
    this.form.get('identify').setValue(item.identify);
    this.form.get('carriername').setValue(item.carriername);
    this.form.get('licenseplate').setValue(item.licenseplate);
    this.form.get('state').setValue(item.state);

    this.titleAside = 'Editar Transportista';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    const data = {
      ididentifytype: this.form.value.ididentifytype,
      identify: this.form.value.identify,
      carriername: this.form.value.carriername,
      licenseplate: this.form.value.licenseplate,
      state: this.form.value.state,
    };
    this.carrierService.put(id, data).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside();
          this.get(1);
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
    this.titleAside = 'Agregar Transportista';
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
      carriername: this.form.value.carriername,
      licenseplate: this.form.value.licenseplate,
      state,
    };
    this.carrierService.post(data).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside();
          this.get(1);
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
    $('#confirmDeleteCarrier').modal('show');
  }

  delete = () => {
    this.carrierService.delete(this.itemSelected.idcarrier).subscribe(
      (response) => {
        $('#confirmDeleteCarrier').modal('hide');
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.get(1);
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
