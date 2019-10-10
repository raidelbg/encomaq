import { TestBed } from '@angular/core/testing';

import { ConfigEmailService } from './config-email.service';

describe('ConfigEmailService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: ConfigEmailService = TestBed.get(ConfigEmailService);
    expect(service).toBeTruthy();
  });
});
