import { Component, OnInit, Input, ElementRef, OnDestroy } from '@angular/core';
import { Notification } from '../../classes/Notification';
import { ITypeNotification } from 'src/app/shared/models/INotification';

@Component({
  selector: 'app-notification',
  templateUrl: './notification.component.html',
  styleUrls: ['./notification.component.scss']
})
export class NotificationComponent implements OnInit, OnDestroy {

  @Input() id?: string;
  @Input() title: string;
  @Input() icon: string;
  @Input() message: string;
  @Input() type: ITypeNotification;

  private element: any;

  constructor(private notification: Notification, private el: ElementRef) {
    this.element = el.nativeElement;
  }

  ngOnInit(): void {
      this.notification.add(this);
      this.element.style.display = 'none';
  }

  ongetStyleClass = () => {
    const styleClass = [
      'notification-modal',
      'flex-row',
      'flex-middle'
    ].join(' ');
    switch (this.type) {
      case 'success':
        return styleClass + ' success' ;
      case 'warning':
        return styleClass + ' warning' ;
      case 'danger':
        return styleClass + ' danger' ;
      case 'primary':
          return styleClass + ' primary' ;
      default:
        return styleClass + ' primary' ;
    }
  }

  ngOnDestroy(): void {
      this.notification.remove();
      this.element.remove();
  }

  open(): void {
      this.element.style.display = 'block';
  }

  close(): void {
      this.element.style.display = 'none';
  }

}
