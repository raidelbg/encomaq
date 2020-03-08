import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ReferralGuideUltimateComponent } from './referral-guide-ultimate.component';

describe('ReferralGuideUltimateComponent', () => {
  let component: ReferralGuideUltimateComponent;
  let fixture: ComponentFixture<ReferralGuideUltimateComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ReferralGuideUltimateComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ReferralGuideUltimateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
