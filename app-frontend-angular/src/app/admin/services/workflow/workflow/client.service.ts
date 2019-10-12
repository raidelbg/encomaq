import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Services } from 'src/app/shared/classes/Services';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class ClientService extends Services {

  constructor(http: HttpClient) {
    super ('client', http);
  }

  exportToPDF(filter: any): Observable<any> {
    this.resolvedSchema(null, 'application/pdf');
    const completeUrl = this.url + this.component + '/exportToPDF?filter=' + JSON.stringify(filter);
    return this.http.get(completeUrl, this.httpOptions);
  }
}
