import { TestBed } from '@angular/core/testing';

import { ReferralGuideService } from './referral-guide.service';

describe('ReferralGuideService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: ReferralGuideService = TestBed.get(ReferralGuideService);
    expect(service).toBeTruthy();
  });
});
