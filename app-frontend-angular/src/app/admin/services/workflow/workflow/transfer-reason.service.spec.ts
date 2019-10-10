import { TestBed } from '@angular/core/testing';

import { TransferReasonService } from './transfer-reason.service';

describe('TransferReasonService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: TransferReasonService = TestBed.get(TransferReasonService);
    expect(service).toBeTruthy();
  });
});
