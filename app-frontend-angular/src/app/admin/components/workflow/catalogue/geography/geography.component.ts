import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Notification } from 'src/app/shared/components/classes/Notification';
import { CountryService } from 'src/app/admin/services/workflow/catalogue/country/country.service';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';
declare var $: any;
@Component({
  selector: 'app-geography',
  templateUrl: './geography.component.html',
  styleUrls: ['./geography.component.scss']
})
export class GeographyComponent implements OnInit {

  titleNotification?: string;
  iconNotification?: string;
  messageNotification?: string;
  typeNotification?: string;

  asideIsOpen = false;
  titleAside = '';

  auxTypeFrm = null;

  // itemSelected =  { id_country: '', namecountry: '', code: '' };
  itemSelected = null;

  listCountry = [];
  constructor(private notification: Notification, private formBuilder: FormBuilder,
              private country: CountryService) { }

  ngOnInit() {
    this.getCountry();
    this.hideShow();
  }
  getCountry = () => {
    this.country.get({}).subscribe(
      (response) => {
        this.listCountry =  response;
      },
      (error) => {
        this.showNotification(error.title, error.icon, error.message, error.type);
      });
  }

  createCountry = () => {
    this.titleAside = 'Agregar País';
    this.asideIsOpen = true;
    this.hideShow(1);
  }
  editCountry = (item: any) => {
    this.itemSelected = item;
    this.titleAside = 'Editar País';
    this.asideIsOpen = true;
    this.hideShow(2);
  }
  confirmDeleteCountry = (item: any) => {
    this.itemSelected = item;
    $('#confirmDeleteIdentificationType').modal('show');
    this.auxTypeFrm = 1;
  }
  delete = () => {
    switch (this.auxTypeFrm) {
      case 1:
        this.deleteCountry();
        break;
    }
  }
  deleteCountry = () => {
    this.country.delete(this.itemSelected.id_country).subscribe(
      (response) => {
        $('#confirmDeleteIdentificationType').modal('hide');
        if (response.success) {
          this.refresh({title: 'Información', icon: ICONS_ALERT.success, message: response.message,  type: 'success' });
        } else {
          this.refresh({title: '¡Atención!', icon: ICONS_ALERT.warning, message: response.message,  type: 'warning' });
        }
      },
      (error) => {
        this.refresh({title: error.title, icon: error.icon, message: error.message,  type: error.type });
      }
    );
  }

  closeAside = () => {
    this.asideIsOpen = false;
  }
  refresh = ( sms: any) => {
    this.showNotification(sms.title, sms.icon, sms.message, sms.type);
    this.closeAside();
    this.getCountry();
    this.hideShow();
  }
  hideShow = (form: any = null)  => {
    $('#createCountry').css('display', 'none');
    $('#editCountry').css('display', 'none');
    switch (form) {
      case 1:
          $('#createCountry').css('display', '');
          break;
        case 2:
          $('#editCountry').css('display', '');
          break;
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
}
