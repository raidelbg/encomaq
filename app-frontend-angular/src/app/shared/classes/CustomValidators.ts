import {FormControl, FormGroup, ValidationErrors, AbstractControl} from '@angular/forms';
import { REGEX_DICTIONARY, VALIDATOR_ENUM } from './ConstantsEnums';

export const regex = REGEX_DICTIONARY;

export function passwordValidator(control: AbstractControl): {[key: string]: boolean | null} {
    if (control.value !== '' && control.value !== null && control.value !== undefined) {
    const expReg = regex.password;
    if (!expReg.test(control.value) && control.value.length) {
            return {password: true};
        }
    }

    return null;
  }

export function samePasswordValidator(control: FormGroup): {[key: string]: boolean | null} {

    if (control.value !== '' && control.value !== null && control.value !== undefined) {

    const password = control.get('password').value;
    const repeatPassword = control.get('passwordconfirm').value;

    if (password !== repeatPassword && repeatPassword.length) {
      return {samePassword: true};
    }
    return null;
    }
  }

export function monetaryValidator(control: FormControl): {[key: string]: boolean | null} {
  if (control.value !== '' && control.value !== null && control.value !== undefined) {
    const numericMonetary = regex.numericMonetary;
    console.log(numericMonetary.test(control.value));
    if (!numericMonetary.test(control.value)) {
      return {moneyQuantity: true};
    }
  }

  return null;

}


export function nameValidator(control: FormControl) {
    if (control.value !== '' && control.value !== null && control.value !== undefined) {
       const names = regex.names;

       if (!names.test(control.value)) {
        return {name: true};
       }
    }

    return null;

}

export function cellphoneEcuValidator(control: FormControl) {
    if (control.value !== '' && control.value !== null && control.value !== undefined) {
       const cellphoneEcu = regex.cellphoneEcu;

       if (!cellphoneEcu.test(control.value)) {
           return {cellphone: true};
       }
    }

    return null;
}

export function teleponeEcuValidator(control: FormControl) {
    if (control.value !== '' && control.value !== null && control.value !== undefined) {
        const teleponeEcu = regex.teleponeEcu;

        if (!teleponeEcu.test(control.value)) {
            return {telephone: true};
        }
    }

    return null;
}

export function identifyIdECValidator(control: FormControl) {
    if (control.value !== '' && control.value !== null && control.value !== undefined) {
      const userId = regex.userId;
      if (!userId.test(control.value) && control.value.length) {
        return {userId: true};
      }
    }
    return null;
  }

export function identifyRucECValidator(control: FormControl) {
    if (control.value !== '' && control.value !== null && control.value !== undefined) {
      const userId = regex.userRuc;
      if (!userId.test(control.value) && control.value.length) {
        return {userRuc: true};
      }
    }
    return null;
  }

export function customValidatorHandler(formGroup: any, id: string) {
    let errorMessage = '';
    Object.keys(formGroup.get(id).errors).forEach(error => {
      let customError = '';
      if (error === 'required') {
        if (id.indexOf('address') !== -1) {
          customError = `${error}_address`;
        } else  if (id.indexOf('nameCompleteReceive') !== -1) {
          customError = `${error}_nameCompleteReceive`;
        } else  if (id.indexOf('nameComplete') !== -1) {
          customError = `${error}_nameComplete`;
        }  else  if (id.indexOf('Add') !== -1) {
          customError = `${error}_${id.substring(0, id.indexOf('Add'))}`;
        } else {
          customError = error;
        }
      } else {
        customError = error;
      }
      errorMessage = formGroup.get(id).hasError(error) ? VALIDATOR_ENUM[customError] : '';
    });
    return errorMessage;
  }
