import { Injectable } from '@angular/core';

@Injectable({
    providedIn: 'root'
})
export class LocalStorageCommon {

    constructor() {}

    /**
     * Function that obtains the value of a specific key, in the specific format
     * @param key Name of the key
     * @param format Return format (normal, json)
     */
    get(key: string, format: string): any {

        const data = localStorage.getItem(key);

        switch (format) {

            case 'normal': {
                return data;
            }
            case 'json': {
                return (data !== null) ? JSON.parse(data) : null;
            }
            default: {
                return data;
            }
        }

    }

    /**
     * Function to store a value to a specific key and to a specific format
     * @param key Name of the key
     * @param data Value to store
     * @param format Type of format (normal, json)
     */
    store(key: string, data: any, format: string) {

        switch (format) {

            case 'normal': {
                localStorage.setItem(key, data);
                break;
            }
            case 'json': {
                localStorage.setItem(key, JSON.stringify(data));
                break;
            }
            default: {
                localStorage.setItem(key, data);
                break;
            }
        }

    }

    /**
     * function that eliminates a specific value by means of its key
     * @param key Name of the key
     */
    destroy(key: string) {

        localStorage.removeItem(key);

    }

    /**
     * function that cleans all storage
     */
    clear() {

        localStorage.clear();

    }

}
