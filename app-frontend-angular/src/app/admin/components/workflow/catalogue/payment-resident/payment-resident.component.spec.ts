import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PaymentResidentComponent } from './payment-resident.component';

describe('PaymentResidentComponent', () => {
  let component: PaymentResidentComponent;
  let fixture: ComponentFixture<PaymentResidentComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PaymentResidentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PaymentResidentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
