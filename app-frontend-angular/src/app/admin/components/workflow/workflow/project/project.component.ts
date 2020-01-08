import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { from, Observable } from 'rxjs';
import { tap, map, delay } from 'rxjs/operators';
import { NgxUiLoaderService } from 'ngx-ui-loader';
import { customValidatorHandler } from 'src/app/shared/classes/CustomValidators';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ICONS_ALERT, CONFIG_LOADING_UI } from 'src/app/shared/classes/ConstantsEnums';
import { ProjectService } from 'src/app/admin/services/workflow/workflow/project.service';
import { ClientService } from 'src/app/admin/services/workflow/workflow/client.service';

declare var $: any;

interface FilterServerResponse {
  data: any;
  total: number;
}
@Component({
  selector: 'app-project',
  templateUrl: './project.component.html',
  styleUrls: ['./project.component.scss']
})
export class ProjectComponent implements OnInit, OnDestroy {

  private destroySubscription$ = new Subject();

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  form: FormGroup;
  formFilter: FormGroup;
  error = {
    idclient: { error: false, msg: ''},
    projectname: { error: false, msg: ''},
  };

  list: Observable<any[]>;
  listClient = [];
  itemSelected = null;
  anything = '';

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

  typeSpinnerLoading = CONFIG_LOADING_UI.typeSpinnerLoading;
  overlayColorLoading = CONFIG_LOADING_UI.overlayColorLoading;
  colorAnimation = CONFIG_LOADING_UI.colorAnimation;

  constructor(private notification: Notification, private projectService: ProjectService,
              private clientService: ClientService, private formBuilder: FormBuilder, private ngxService: NgxUiLoaderService) { }

  ngOnInit() {
    this.form = this.formBuilder.group({
      idclient: new FormControl(null, {validators: [Validators.required], updateOn: 'change'}),
      projectname: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      place: new FormControl(''),
      state: new FormControl(true),
    });
    this.formFilter = this.formBuilder.group({
      search: new FormControl(''),
      stateFilter: new FormControl('1'),
      column: new FormControl('projectname'),
      order: new FormControl('ASC'),
      numPage: new FormControl(5),
    });

    this.getClient();
  }

  getAction(page: number, perPage: number): Observable<FilterServerResponse> {
    const filters = {
      search: this.formFilter.value.search,
      state: this.formFilter.value.stateFilter,
      column: this.formFilter.value.column,
      order: this.formFilter.value.order,
      num_page: this.formFilter.value.numPage
    };

    return from(this.projectService.get(filters, null, page)).pipe(delay(200));

  }

  get = (page: number) => {
    this.ngxService.startLoader('loading-component');
    this.list =  this.getAction(page, 5).pipe(
      tap(
        (response) => {

          this.total = response.data.total;
          this.pag = response.data.current_page;
          this.pageDelta = (page - 1) * 5;
          this.ngxService.stopLoader('loading-component');

        },
        (error) => {
          this.ngxService.stopLoader('loading-component');
          console.error(error);
        }
      ),
      map(response => response.data.data)
    );
  }

  getClient = () => {
    this.listClient.push({idclient: null, businessname: '-- Seleccione Cliente --'});
    this.clientService.get({}).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          response.data.forEach(element => {
            this.listClient.push({idclient: element.idclient, businessname: element.businessname});
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
      this.update(this.itemSelected.idproject);
    }
  }


  edit = (item: any) => {
    this.itemSelected = item;
    this.form.get('idclient').setValue(item.idclient);
    this.form.get('projectname').setValue(item.projectname);
    this.form.get('place').setValue(item.place);
    this.form.get('state').setValue(item.state);

    this.titleAside = 'Editar Proyecto';
    this.asideIsOpen = true;
  }

  update = (id: any) => {
    this.ngxService.startLoader('loading-component');
    const data = {
      idclient: this.form.value.idclient,
      projectname: this.form.value.projectname,
      place: this.form.value.place,
      state: this.form.value.state,
    };
    this.projectService.put(id, data).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside();
        } else {
          this.showNotification('¡Atención!', ICONS_ALERT.warning, response.message, 'warning');
        }
        this.ngxService.stopLoader('loading-component');
      },
      (error) => {
        this.ngxService.stopLoader('loading-component');
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  create = () => {
    this.titleAside = 'Agregar Proyecto';
    this.form.reset();
    this.form.get('idclient').setValue(null);
    this.form.get('state').setValue(true);
    this.asideIsOpen = true;
  }

  add = () => {
    this.ngxService.startLoader('loading-component');
    const state = (this.form.value.state !== null && this.form.value.state !== false) ? true : false;
    const data = {
      idclient: this.form.value.idclient,
      projectname: this.form.value.projectname,
      place: this.form.value.place,
      state,
    };
    this.projectService.post(data).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.closeAside();
        } else {
          this.showNotification('¡Atención!', ICONS_ALERT.warning, response.message, 'warning');
        }
        this.ngxService.stopLoader('loading-component');
      },
      (error) => {
        this.ngxService.stopLoader('loading-component');
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  confirmDelete = (item: any) => {
    this.itemSelected = item;
    this.anything = item.projectname;
    $('#confirmDeleteProject').modal('show');
  }

  delete = () => {
    $('#confirmDeleteProject').modal('hide');
    this.ngxService.startLoader('loading-component');
    this.projectService.delete(this.itemSelected.idproject).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
        } else {
          this.showNotification('¡Atención!', ICONS_ALERT.warning, response.message, 'warning');
        }
        this.ngxService.stopLoader('loading-component');
      },
      (error) => {
        this.ngxService.stopLoader('loading-component');
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  closeAside = () => {
    this.asideIsOpen = false;
    this.form.reset();
    this.itemSelected = null;
    this.get(1);
  }

  info = (item: any) => {
    this.itemSelected = item.biz_client;
    $('#infoClient').modal('show');
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

  ngOnDestroy(): void {
    this.destroySubscription$.next();     // trigger the unsubscribe
    this.destroySubscription$.complete(); // finalize & clean up the subject stream
  }

}
