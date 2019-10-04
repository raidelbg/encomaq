import { TestBed } from '@angular/core/testing';

import { IdentificationtypeService } from './identificationtype.service';

describe('IdentificationtypeService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: IdentificationtypeService = TestBed.get(IdentificationtypeService);
    expect(service).toBeTruthy();
  });
});
