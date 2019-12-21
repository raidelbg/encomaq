import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { LocalStorageCommon } from './LocalStorageCommon';

export class Services {

  protected url = environment.baseUrl;
  protected component: string;
  protected http: any;
  protected httpOptions: any;
  protected authBasic: boolean;
  protected storage: any;

  constructor(component: string, http: HttpClient, authBasic: boolean = false) {
    this.component = component;
    this.http = http;
    this.storage = new LocalStorageCommon();
    this.authBasic = authBasic;
    this.resolvedSchema();
  }

  resolvedSchema(currentSchema: string = null, contentType: string = null) {
    let schema = currentSchema;
    if (schema === null) {
      const schemaStorage = this.storage.get('schema_db', 'normal');
      if (schemaStorage === null || schemaStorage === 'null') {
        schema = 'public';
      } else {
        schema = schemaStorage;
      }
    }

    let authorization = 'Bearer ' + this.storage.get('auth_token', 'normal');
    if (this.authBasic) {
      authorization = 'Basic ';
    }

    this.httpOptions = {
      headers: new HttpHeaders({
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': '*',
        Authorization: authorization,
        'schema-db': schema
      })
    };
    this.httpOptions.headers.set('Content-Type', contentType);

  }

  // -------------------------------------------------------------------------------------------------

  get(filter: number | object, partUrl: string = null, pageCurrentPaginate: number = null, schema: string = null): Observable<any> {

    this.resolvedSchema(schema);

    let resultURL = this.url + this.component;

    if (partUrl !== null) {
      resultURL += '/' + partUrl;
    }

    if (typeof filter === 'number') {
      resultURL += '/' + filter;
    } else {
      resultURL += '?filter=' + JSON.stringify(filter);
      if (pageCurrentPaginate !== null) {
        resultURL += '&page=' + pageCurrentPaginate;
      }
    }

    return this.http.get(resultURL, this.httpOptions);

  }


  post(data: any, schema: string = null): Observable<any> {
    this.resolvedSchema(schema);
    return this.http.post(this.url + this.component, data, this.httpOptions);
  }

  put(id: any, data: any, schema: string = null): Observable<any> {

    this.resolvedSchema(schema);

    return this.http.put(this.url + this.component + '/' + id, data, this.httpOptions);

  }

  delete(id: any, schema: string = null): Observable<any> {

    this.resolvedSchema(schema);

    return this.http.delete(this.url + this.component + '/' + id, this.httpOptions);

  }

  state(id: any, schema: string = null): Observable<any> {

    this.resolvedSchema(schema);

    return this.http.put(this.url + this.component + '/state/' + id, {}, this.httpOptions);

  }

  exportComplete(schema: string = null): Observable<any> {

    this.resolvedSchema(schema);

    return this.http.get(this.url + this.component + '/exportComplete', this.httpOptions);

  }

  postFile(data: any, file: File, partUrl: string = null, schema: string = null): Observable<any> {

    this.resolvedSchema(schema);

    let resultURL = this.url + this.component;

    if (partUrl !== null) {
      resultURL += '/' + partUrl;
    }

    const formData: FormData = new FormData();
    formData.append('file', file);
    formData.append('data', JSON.stringify(data));
    return this.http.post(resultURL, formData, this.httpOptions);

  }

  postMultiplesFiles(data: any, file: FileList, schema: string = null): Observable<any> {

    this.resolvedSchema(schema);

    const formData: FormData = new FormData();

    Array.from(file).forEach(row => {
      /* tslint:disable:no-string-literal */
      formData.append('file[]', row, row['name']);
    });

    formData.append('data', JSON.stringify(data));

    return this.http.post(this.url + this.component + '/postMultiplesFiles', formData, this.httpOptions);

  }

  recover(data: any, schema: string = null): Observable<any> {

    this.resolvedSchema(schema);

    return this.http.post(this.url + this.component + '/resetPassword', data, this.httpOptions);

  }

  show(id: any, schema: string = null): Observable<any> {

    this.resolvedSchema(schema);

    return this.http.get(this.url + this.component + '/show/' + id, this.httpOptions);

  }

}
