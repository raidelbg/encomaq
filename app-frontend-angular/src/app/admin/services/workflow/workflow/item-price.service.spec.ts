import { TestBed } from '@angular/core/testing';

import { ItemPriceService } from './item-price.service';

describe('ItemPriceService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: ItemPriceService = TestBed.get(ItemPriceService);
    expect(service).toBeTruthy();
  });
});
