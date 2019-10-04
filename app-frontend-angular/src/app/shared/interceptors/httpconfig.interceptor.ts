import { Injectable } from '@angular/core';
import {
    HttpInterceptor,
    HttpRequest,
    HttpResponse,
    HttpHandler,
    HttpEvent,
    HttpErrorResponse
} from '@angular/common/http';

import { Observable, throwError } from 'rxjs';
import { map, catchError, switchMap } from 'rxjs/operators';

import { GlobalErrorHandler } from '../classes/GlobalErrorHandler';
import { LocalStorageCommon } from '../classes/LocalStorageCommon';
import { TokenRenewalService } from 'src/app/admin/services/auth/signin/token-renewal.service';

@Injectable()
export class HttpConfigInterceptor implements HttpInterceptor {

    constructor(
        public errorHandler: GlobalErrorHandler,
        private localStorageCommon: LocalStorageCommon,
        private tokenRenewalServices: TokenRenewalService
    ) { }

    intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
        return next.handle(request).pipe(
            map((event: HttpEvent<any>) => {
                if (event instanceof HttpResponse) {}
                return event;
            }),
            catchError((error: HttpErrorResponse) => {
                if (error.status === 403) {
                    return this.tokenRenewal(request, next);
                } else {
                    return throwError(this.errorHandler.handleError(error));
                }
            }));
    }

    tokenRenewal = (request: HttpRequest<any>, next: HttpHandler) => {
        const data = {
            email: this.localStorageCommon.get('auth_user', 'json').email,
            oldToken: this.localStorageCommon.get('auth_token', 'normal')
        };
        return this.tokenRenewalServices.post(data).pipe(
            switchMap((response) => {
                this.localStorageCommon.store('auth_token', response.result, 'normal');
                return next.handle(this.setHeadersAuthorization(request));
            })
        );
    }

    setHeadersAuthorization = (request: HttpRequest<any>) => {
        return request.clone({
            setHeaders: {
                Authorization: 'Bearer ' + this.localStorageCommon.get('auth_token', 'normal')
            }
        });
    }
}
