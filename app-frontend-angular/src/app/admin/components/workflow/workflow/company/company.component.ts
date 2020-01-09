import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { ICONS_ALERT, CONFIG_LOADING_UI } from 'src/app/shared/classes/ConstantsEnums';
import { takeUntil } from 'rxjs/operators';
import { Subject } from 'rxjs';
import { from, Observable } from 'rxjs';
import { tap, map, delay } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { CompanyService } from 'src/app/admin/services/workflow/workflow/company.service';
import { NgxUiLoaderService } from 'ngx-ui-loader';

declare var $: any;

@Component({
  selector: 'app-company',
  templateUrl: './company.component.html',
  styleUrls: ['./company.component.scss']
})
export class CompanyComponent implements OnInit, OnDestroy {

  private destroySubscription$ = new Subject();

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  form: FormGroup;

  fileToUpload: File = null;
  urlBasic: string;

  urlImageDefault = './assets/image/no_image_available.jpg';

  typeSpinnerLoading = CONFIG_LOADING_UI.typeSpinnerLoading;
  overlayColorLoading = CONFIG_LOADING_UI.overlayColorLoading;
  colorAnimation = CONFIG_LOADING_UI.colorAnimation;

  constructor(private formBuilder: FormBuilder, private notification: Notification, private companyService: CompanyService,
              private ngxService: NgxUiLoaderService) { }

  ngOnInit() {
    this.form = this.formBuilder.group({
      idcompany: new FormControl(0, {validators: [Validators.required], updateOn: 'change'}),
      businessname: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      tradename: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      identify: new FormControl('', {validators: [Validators.required, Validators.pattern('^[0-9]*$')], updateOn: 'change'}),
      phone: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      address: new FormControl(''),
      email: new FormControl('', {validators: [Validators.required, Validators.email], updateOn: 'change'}),
      urlweb: new FormControl(''),
    });
    const partUrl = environment.baseUrl.replace('api/', '');
    this.urlBasic =  partUrl;
    this.get();
  }

  handleFileInput(files: FileList, fieldName: string) {
    this.fileToUpload = files.item(0);
    // this.form.get(fieldName).setValue(files.item(0));
  }

  get = () => {
    this.ngxService.startLoader('loading-component');
    this.companyService.get({}).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.form.get('idcompany').setValue(response.data.idcompany);
          this.form.get('businessname').setValue(response.data.businessname);
          this.form.get('tradename').setValue(response.data.tradename);
          this.form.get('identify').setValue(response.data.identify);
          this.form.get('phone').setValue(response.data.phone);
          this.form.get('address').setValue(response.data.address);
          this.form.get('email').setValue(response.data.email);
          this.form.get('urlweb').setValue(response.data.urlweb);
          if (response.data.image !== null) {
            this.urlImageDefault = this.urlBasic + response.data.image;
          }
          this.ngxService.stopLoader('loading-component');
        }
      },
      (error) => {
        this.ngxService.stopLoader('loading-component');
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  action = () => {
    this.ngxService.startLoader('loading-component');
    const data = {
      idcompany: this.form.value.idcompany,
      businessname: this.form.value.businessname,
      tradename: this.form.value.tradename,
      identify: this.form.value.identify,
      phone: this.form.value.phone,
      address: this.form.value.address,
      email: this.form.value.email,
      urlweb: this.form.value.urlweb,
    };
    this.companyService.postFile(data, this.fileToUpload).pipe(takeUntil(this.destroySubscription$)).subscribe(
      (response) => {
        if (response.success) {
          this.showNotification('Información', ICONS_ALERT.success, response.message, 'success');
          this.get();
          this.ngxService.stopLoader('loading-component');
        } else {
          this.ngxService.stopLoader('loading-component');
          this.showNotification('¡Atención!', ICONS_ALERT.warning, response.message, 'warning');
        }
      },
      (error) => {
        this.ngxService.stopLoader('loading-component');
        this.showNotification(error.title, error.icon, error.message, error.type);
      }
    );
  }

  cancelConfirm = () => {
    $('#confirmCancel').modal('show');
  }

  cancel = () => {
    this.get();
    $('#confirmCancel').modal('hide');
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
