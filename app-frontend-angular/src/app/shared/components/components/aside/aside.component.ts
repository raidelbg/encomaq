import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-aside',
  templateUrl: './aside.component.html',
  styleUrls: ['./aside.component.scss']
})
export class AsideComponent implements OnInit {

  @Input() isOpen: boolean;
  @Input() headerOverlay?: boolean;
  @Input() title: string;
  @Input() closeAside: () => void;

  constructor() { }

  ngOnInit() {
  }

}
