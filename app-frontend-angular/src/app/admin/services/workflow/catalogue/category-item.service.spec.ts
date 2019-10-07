import { TestBed } from '@angular/core/testing';

import { CategoryItemService } from './category-item.service';

describe('CategoryItemService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: CategoryItemService = TestBed.get(CategoryItemService);
    expect(service).toBeTruthy();
  });
});
