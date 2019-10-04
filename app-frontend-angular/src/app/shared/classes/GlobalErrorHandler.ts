import { ErrorHandler, Injectable } from '@angular/core';
import { HttpErrorResponse } from '@angular/common/http';
import { ICONS_ALERT } from './ConstantsEnums';

@Injectable({
  providedIn: 'root'
})
export class GlobalErrorHandler implements ErrorHandler {

  /**
   * @tutorial Customer Errors
   *
   * @see 400 Bad Request
   * @see 401 Unauthorized
   * @see 402 Payment Required
   * @see 403 Forbidden
   * @see 404 Not Found
   * @see 405 Method Not Allowed
   * @see 406 Not Acceptable
   * @see 407 Proxy Authentication Required
   * @see 408 Request Timeout
   * @see 409 Conflict
   * @see 410 Gone
   * @see 411 Length Required
   * @see 412 Precondition Failed
   * @see 413 Payload Too Large
   * @see 414 URI Too Long
   * @see 415 Unsupported Media Type
   * @see 416 Requested Range Not Satisfiable
   * @see 417 Expectation Failed
   * @see 418 I'm a teapot
   * @see 421 Misdirected Request
   * @see 422 Unprocessable Entity (WebDAV)
   * @see 423 Locked (WebDAV)
   * @see 424 Failed Dependency (WebDAV)
   * @see 426 Upgrade Required
   * @see 428 Precondition Required
   * @see 429 Too Many Requests
   * @see 431 Request Header Fields Too Large
   * @see 451 Unavailable For Legal Reasons
   *
   *
   * @tutorial Server Errors
   *
   * @see 500 Internal Server Error
   * @see 501 Not Implemented
   * @see 502 Bad Gateway
   * @see 503 Service Unavailable
   * @see 504 Gateway Timeout
   * @see 505 HTTP Version Not Supported
   * @see 506 Variant Also Negotiates
   * @see 507 Insufficient Storage
   * @see 508 Loop Detected (WebDAV)
   * @see 510 Not Extended
   * @see 511 Network Authentication Required
   *
   *
   */



  /**
   * Function that receives from the interceptor the error of the request
   *
   * @param error tslint(no-redundant-jsdoc)
   */
  handleError(error: any) {
    const objectCustomError = {
      title: '',
      message: 'Por favor, contacte con el administrador del sistema.',
      icon: ICONS_ALERT.danger,
      type: 'danger',
      error: null
    };
    if ( error instanceof HttpErrorResponse ) {
      objectCustomError.title = 'ERROR TIPO: ' + error.status;
      if (error.error !== undefined) {
        objectCustomError.error = error.error;
      }
    } else {
      objectCustomError.title = 'ERROR TIPO: (DESCONOCIDO)';
    }

    return objectCustomError;
  }

}
