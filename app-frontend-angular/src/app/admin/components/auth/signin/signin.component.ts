import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators, FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { LocalStorageCommon } from 'src/app/shared/classes/LocalStorageCommon';
import { SigninService } from 'src/app/admin/services/auth/signin/signin.service';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';

@Component({
  selector: 'app-signin',
  templateUrl: './signin.component.html',
  styleUrls: ['./signin.component.scss']
})
export class SigninComponent implements OnInit {

  formSignin: FormGroup;

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  constructor(private formBuilder: FormBuilder, private localStorageCommon: LocalStorageCommon, private router: Router,
              private notification: Notification, private signinService: SigninService) {}

  ngOnInit() {
    this.formSignin = this.formBuilder.group({
      email: new FormControl('admin@example.com', {validators: [Validators.required, Validators.email], updateOn: 'change'}),
      password: new FormControl('admin', {validators: [Validators.required], updateOn: 'change'})
    });
    this.security();
  }

  security = () => {
    const token = this.localStorageCommon.get('auth_token', 'normal');
    if (token !== null && token !== 'null') {
      this.router.navigate(['/']);
    }
  }

  signIn = () => {
    const data = {
      email: this.formSignin.value.email,
      password: this.formSignin.value.password
    };
    this.signinService.post(data).subscribe(
      (response) => {
        if (response.success) {
          this.localStorageCommon.store('auth_token', response.token, 'normal');
          this.localStorageCommon.store('auth_user', response.user, 'json');
          this.router.navigate(['/workflow']);
        } else {
          // this.showNotification('Información', ICONS_ALERT.success, 'no login', 'success');
          this.showNotification('¡Atención!', ICONS_ALERT.warning, response.message, 'warning');
          // this.showNotification('¡Error!', ICONS_ALERT.danger, 'no login', 'danger');
          // this.showNotification('Confirmación', ICONS_ALERT.primary, 'no login', 'primary');
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
