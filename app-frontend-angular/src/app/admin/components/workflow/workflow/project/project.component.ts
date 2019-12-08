import { Component, OnInit, OnDestroy } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';
import { ProjectService } from 'src/app/admin/services/workflow/workflow/project.service';
import { ClientService } from 'src/app/admin/services/workflow/workflow/client.service';

declare var $: any;

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

  list = [];
  listClient = [];
  itemSelected = null;
  anything = '';

  constructor(private notification: Notification, private projectService: ProjectService,
              private clientService: ClientService, private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.form = this.formBuilder.group({
      idclient: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
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

  get = () => {
    const filters = {
      search: this.formFilter.value.search,
      state: this.formFilter.value.stateFilter,
      column: this.formFilter.value.column,
      order: this.formFilter.value.order,
      num_page: this.formFilter.value.num_page
    };
    this.projectService.get(filters).pipe(takeUntil(this.destroySubscription$)).subscribe(
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

  getClient = () => {
    const filters = {
      search: this.formFilter.value.search,
      state: '1',
      column: 'businessname',
      order: 'ASC',
    };
    this.listClient.push({idclient: '', businessname: '-- Seleccione Cliente --'});
    this.clientService.get(filters).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          response.data.forEach(element => {
            this.listClient.push({idclient: element.idclient, businessname: element.businessname});
          });
          this.get();
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
    this.titleAside = 'Agregar Proyecto';
    this.form.reset();
    this.form.get('idclient').setValue('');
    this.form.get('state').setValue(true);

    this.asideIsOpen = true;
  }

  add = () => {
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
    this.anything = item.projectname;
    $('#confirmDeleteProject').modal('show');
  }

  delete = () => {
    this.projectService.delete(this.itemSelected.idproject).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        $('#confirmDeleteProject').modal('hide');
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

  info = (item: any) => {
    this.itemSelected = item.biz_client;
    $('#infoClient').modal('show');
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
