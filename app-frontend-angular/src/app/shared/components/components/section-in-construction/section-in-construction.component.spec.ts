import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SectionInConstructionComponent } from './section-in-construction.component';

describe('SectionInConstructionComponent', () => {
  let component: SectionInConstructionComponent;
  let fixture: ComponentFixture<SectionInConstructionComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SectionInConstructionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SectionInConstructionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
