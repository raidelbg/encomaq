import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { CountryService } from 'src/app/admin/services/workflow/catalogue/country/country.service';
import { ICONS_ALERT } from 'src/app/shared/classes/ConstantsEnums';
@Component({
  selector: 'app-add-country',
  templateUrl: './add-country.component.html',
  styleUrls: ['./add-country.component.scss']
})
export class AddCountryComponent implements OnInit {
  @Output() notify = new EventEmitter<any>();
  sms = { title: '', icon: '', message: '', type: ''  };
  formCountry: FormGroup;
  constructor(private formBuilder: FormBuilder, private country: CountryService) { }

  ngOnInit() {
    this.formCountry =  this.formBuilder.group({
      namecountry: new FormControl('', {validators: [Validators.required], updateOn: 'change'}),
      code: new FormControl('', {validators: [Validators.required], updateOn: 'change'})
    });
  }
  add = () => {
    const data = {
      namecountry: this.formCountry.value.namecountry,
      code: this.formCountry.value.code
    };
    this.country.post(data).subscribe(
      (response) => {
        this.sms.message =  response.message;
        if (response.success) {
          this.sms.title = 'Información';
          this.sms.icon = ICONS_ALERT.success;
          this.sms.type = 'success';

        } else {
          this.sms.title = '¡Atención!';
          this.sms.icon = ICONS_ALERT.warning;
          this.sms.type = 'warning';
        }
        this.notify.emit(this.sms);
        this.formCountry.reset();
      },
      (error) => {
        this.sms.title = error.title;
        this.sms.icon = error.icon;
        this.sms.type = error.type;
        this.sms =  error.message;
        this.notify.emit(this.sms);
      }
    );
  }

}
