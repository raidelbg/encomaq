import { TestBed } from '@angular/core/testing';

import { TokenRenewalService } from './token-renewal.service';

describe('TokenRenewalService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: TokenRenewalService = TestBed.get(TokenRenewalService);
    expect(service).toBeTruthy();
  });
});
