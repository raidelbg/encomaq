import { Injectable } from '@angular/core';

@Injectable({
    providedIn: 'root'
})
export class Notification {
    private modals: any[] = [];

    add(modal: any) {
        const modalOld: any = this.modals.filter(x => x.id === modal.id)[0];
        if (modalOld !== null && modalOld !== undefined) {
            this.remove(modalOld.id);
        }
        this.modals.push(modal);
    }

    remove(id?: string) {
        this.modals = this.modals.filter(x => x.id !== id);
    }

    clear() {
        this.modals = [];
    }

    open(id?: string) {
        const modal: any = this.modals.filter(x => x.id === id)[0];
        modal.open();
    }

    close(id?: string) {
        const modal: any = this.modals.filter(x => x.id === id)[0];
        modal.close();
    }
}
