import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Services } from 'src/app/shared/classes/Services';

@Injectable({
  providedIn: 'root'
})
export class LiquidationService extends Services {

  constructor(http: HttpClient) {
    super ('liquidation', http);
  }
}
