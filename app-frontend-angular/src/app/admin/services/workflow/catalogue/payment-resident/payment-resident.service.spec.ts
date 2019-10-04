import { TestBed } from '@angular/core/testing';

import { PaymentResidentService } from './payment-resident.service';

describe('PaymentResidentService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: PaymentResidentService = TestBed.get(PaymentResidentService);
    expect(service).toBeTruthy();
  });
});
