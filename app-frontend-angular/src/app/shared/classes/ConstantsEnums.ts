
export const ICONS_ALERT = {
    success: 'fa-check-circle',
    warning: 'fa-exclamation-triangle',
    danger: 'fa-bomb',
    primary: 'fa-info-circle'
};

export const REGEX_DICTIONARY = {
    password: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$#@$!%*?&-_])[A-Za-z\d$@$#!%*?&-_]{8,}/,
    numericMonetary: /^[1-9][0-9]+(\.[0-9]{2})?$/,
    names: /([A-ZÑ]+[a-zñáéíóú]+)/,
    cellphoneEcu: /^[09]\d{9}$/,
    teleponeEcu: /^[0][2-7]\d{7}$/,
    userId: /^\d{10}$/g,
    userRuc: /^\d{13}$/g
};

export const VALIDATOR_ENUM = {
    required: 'Campo requerido',
    required_email: 'Ingresa el email',
    required_emailBill: 'Ingresa el email para enviar la factura',
    required_password: 'Ingresa la contraseña',
    required_passwordCurrent: 'Ingresa la contraseña actual',
    required_repeatPassword: 'Ingresa la contraseña',
    required_address: 'Ingresa una dirección válida',
    required_name: 'Ingresa tu nombre',
    required_fullName: 'Ingrese nombre completo',
    required_identification: 'Ingresa número de cédula o RUC',
    required_businessName: 'Ingresa tu nombre o razón social',
    required_phone: 'Ingresa un número de teléfono',
    required_celphone: 'Ingresa tu número de celular',
    required_celphoneBill: 'Ingresa tu número de teléfono o celular',
    name: 'Ingrese nombres o un nombre válido',
    email: 'Ingresa un email válido',
    password: 'Debe contener al menos 8 caracteres, mayúsculas, números y símbolos',
    samePassword: 'Las contraseñas deben ser iguales',
    url: 'Ingrese una url válida',
    moneyQuantity: 'El valor debe ser un número mayor a 10 y puede contener 2 decimales',
    min: 'El valor debe ser mayor a 1',
    max: 'El valor no debe exceder el 100%',
    userId: 'Ingrese una cédula válida',
    userRuc: 'Ingrese un RUC válido',
    telephone: 'Ingrese un número de teléfono fijo válido',
    cellphone: 'Ingrese un número de celular válido',
};
