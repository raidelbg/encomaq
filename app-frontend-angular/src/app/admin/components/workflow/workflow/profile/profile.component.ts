import { Component, OnInit, OnDestroy } from '@angular/core';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { ICONS_ALERT, CONFIG_LOADING_UI } from 'src/app/shared/classes/ConstantsEnums';
import { NgxUiLoaderService } from 'ngx-ui-loader';
import { UserService } from 'src/app/admin/services/workflow/catalogue/user.service';
import { LocalStorageCommon } from 'src/app/shared/classes/LocalStorageCommon';

declare var $: any;

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit, OnDestroy {

  private destroySubscription$ = new Subject();

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  form: FormGroup;
  itemSelected = null;

  typeSpinnerLoading = CONFIG_LOADING_UI.typeSpinnerLoading;
  overlayColorLoading = CONFIG_LOADING_UI.overlayColorLoading;
  colorAnimation = CONFIG_LOADING_UI.colorAnimation;

  constructor(private notification: Notification, private formBuilder: FormBuilder, private ngxService: NgxUiLoaderService,
              private userService: UserService, private localStorageCommon: LocalStorageCommon) { }

  ngOnInit() {
    this.form = this.formBuilder.group({
      personname: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      lastnameperson: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      email: new FormControl('', {validators: [Validators.required, Validators.email], updateOn: 'change'}),
      password: new FormControl(''),
    });
    this.get();
  }

  get = () => {
    this.form.get('personname').setValue(this.localStorageCommon.get('auth_user', 'json').personname);
    this.form.get('lastnameperson').setValue(this.localStorageCommon.get('auth_user', 'json').lastnameperson);
    this.form.get('email').setValue(this.localStorageCommon.get('auth_user', 'json').email);
    this.form.get('password').setValue('');
  }

  action = () => {
    this.ngxService.startLoader('loading-component');
    const data = {
      personname: this.form.value.personname,
      lastnameperson: this.form.value.lastnameperson,
      email: this.form.value.email,
      password: (this.form.value.password !== '') ? this.form.value.password : false,
      state: true,
      idrole: this.localStorageCommon.get('auth_user', 'json').idrole
    };
    this.userService.put(this.localStorageCommon.get('auth_user', 'json').iduser, data).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');

          const user = this.localStorageCommon.get('auth_user', 'json');

          user.personname = this.form.value.personname;
          user.lastnameperson = this.form.value.lastnameperson;
          user.email = this.form.value.email;

          this.localStorageCommon.store('auth_user', user, 'json');

          this.get();
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
