import { Component, OnInit } from '@angular/core';
import { LocalStorageCommon } from 'src/app/shared/classes/LocalStorageCommon';
import { Router } from '@angular/router';

declare var $: any;

@Component({
  selector: 'app-workflow',
  templateUrl: './workflow.component.html',
  styleUrls: ['./workflow.component.scss']
})
export class WorkflowComponent implements OnInit {

  username = '';

  constructor(private localStorageCommon: LocalStorageCommon, private router: Router) { }

  ngOnInit(): void {
    $(document).ready(() => {
      // Hide submenus
      $('#body-row .collapse').collapse('hide');

      // Collapse/Expand icon
      $('#collapse-icon').addClass('fa-angle-double-left');

      // Collapse click
      $('[data-toggle=sidebar-colapse]').click(() => {
          SidebarCollapse();
      });

      function SidebarCollapse() {
          $('.menu-collapsed').toggleClass('d-none');
          $('.sidebar-submenu').toggleClass('d-none');
          $('.submenu-icon').toggleClass('d-none');
          $('#sidebar-container').toggleClass('sidebar-expanded sidebar-collapsed');
          // Treating d-flex/d-none on separators with title
          const SeparatorTitle = $('.sidebar-separator-title');
          if ( SeparatorTitle.hasClass('d-flex') ) {
              SeparatorTitle.removeClass('d-flex');
          } else {
              SeparatorTitle.addClass('d-flex');
          }
          // Collapse/Expand icon
          $('#collapse-icon').toggleClass('fa-angle-double-left fa-angle-double-right');
      }
    });

    this.security();
  }

  security = () => {
    const token = this.localStorageCommon.get('auth_token', 'normal');
    if (token === null || token === 'null') {
      this.router.navigate(['/auth']);
    } else {
      const user = this.localStorageCommon.get('auth_user', 'json');
      this.username = user.personname + ' ' + user.lastnameperson;
    }
  }

  logout = () => {
    this.localStorageCommon.clear();
    this.router.navigate(['/auth']);
  }

}
