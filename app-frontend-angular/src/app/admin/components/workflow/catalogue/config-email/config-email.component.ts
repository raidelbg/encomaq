import { Component, OnInit } from '@angular/core';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';
import { ConfigEmailService } from 'src/app/admin/services/workflow/catalogue/config-email.service';

declare var $: any;

@Component({
  selector: 'app-config-email',
  templateUrl: './config-email.component.html',
  styleUrls: ['./config-email.component.scss']
})
export class ConfigEmailComponent implements OnInit {

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  form: FormGroup;
  itemSelected = null;

  constructor(private notification: Notification, private configEmailService: ConfigEmailService,
              private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.form = this.formBuilder.group({
      driver: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      server: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      port: new FormControl('', {validators: [Validators.pattern('^[0-9]*$')], updateOn: 'change'}),
      encryptation: new FormControl(''),
      useremail: new FormControl('', {validators: [Validators.required, Validators.email], updateOn: 'change'}),
      passwordemail: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
    });
    this.get();
  }

  get = () => {
    this.configEmailService.get({}).subscribe(
      (response) => {
        if (response.length > 0) {
          this.itemSelected = response[0];
          this.form.get('driver').setValue(this.itemSelected.driver);
          this.form.get('server').setValue(this.itemSelected.server);

          this.form.get('port').setValue(this.itemSelected.port);
          this.form.get('encryptation').setValue(this.itemSelected.encryptation);
          this.form.get('useremail').setValue(this.itemSelected.useremail);
          this.form.get('passwordemail').setValue(this.itemSelected.passwordemail);
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
      this.update(this.itemSelected.idconfigemail);
    }
  }

  update = (id: any) => {
    const data = {
      driver: this.form.value.driver,
      server: this.form.value.server,
      port: this.form.value.port,
      encryptation: this.form.value.encryptation,
      useremail: this.form.value.useremail,
      passwordemail: this.form.value.passwordemail,
    };
    this.configEmailService.put(id, data).subscribe(
      (response) => {
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

  add = () => {
    const data = {
      driver: this.form.value.driver,
      server: this.form.value.server,
      port: this.form.value.port,
      encryptation: this.form.value.encryptation,
      useremail: this.form.value.useremail,
      passwordemail: this.form.value.passwordemail,
    };
    this.configEmailService.post(data).subscribe(
      (response) => {
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
