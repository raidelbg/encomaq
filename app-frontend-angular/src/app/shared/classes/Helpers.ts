import { Injectable } from '@angular/core';

@Injectable({
    providedIn: 'root'
})
export class Helpers {

    constructor() {}

    /**
     * Function that converts numbers to money format
     * @param currency Type of currency($, £, €, etc.)
     * @param value Numerical value (0 or 9.00, etc.)
     * @param decimals Number of decimals (2 by default)
     */
    formatMoney(currency: string, value: any, decimals: number): string {

        if (value !== undefined && value !== '') {
          let n = value;
          n = n.toString();

          if (n === '' || n === '.') {
              n = '0.00';
          }

          const patron = [currency, ' ', ','];
          const longitud = patron.length;

          for (let i = 0; i < longitud; i++) {
              n = n.replace(patron[i], '');
          }
          n = n.replace(patron, '');

          n = parseFloat(n);

          let dec = 2;

          if (decimals !== undefined) {
              dec = decimals;
          }

          const multiplicator = Math.pow(10, dec);
          const valor = currency + ' ' + (Math.round(n * multiplicator) / multiplicator).toFixed(dec);

          return valor;

        }

    }

    /**
     * Function that subtracts two hours
     * @param starthour Start Hour (hh:mm:ss)
     * @param endhour Final Hour (hh:mm:ss)
     */
    subtractHours(starthour: string, endhour: string): string {

        const hourEnd = endhour.split(':');
        const hourStart = starthour.split(':');

        const final = new Date();
        const initial = new Date();

        final.setHours(parseInt(hourEnd[0], 0), parseInt(hourEnd[1], 0), parseInt(hourEnd[2], 0));
        initial.setHours(parseInt(hourStart[0], 0), parseInt(hourStart[1], 0), parseInt(hourStart[2], 0));

        const hours = final.getHours() - initial.getHours();
        const minutes = final.getMinutes() - initial.getMinutes();
        const seconds = final.getSeconds() - initial.getSeconds();

        final.setHours(hours, minutes, seconds);

        return final.getHours() + ':' + final.getMinutes() + ':' + final.getSeconds();

    }

    /**
     * Function that subtracts two dates
     * @param startdate Start date (YYYY-MM-DD)
     * @param enddate Final date (YYYY-MM-DD)
     */
    subtractDates(startdate: string, enddate: string): number {

        let final: string[];
        const initial: Array<string> = startdate.split('-');

        if (enddate !== '') {

            final = enddate.split('-');

        } else {

            const now = new Date();
            final = [String(now.getFullYear()), String(now.getMonth() + 1), String(now.getDate())];

        }

        const dateStart: any = new Date(parseInt(initial[0], 0), ( parseInt(initial[1], 0) - 1 ), parseInt(initial[2], 0));
        const dateEnd: any = new Date(parseInt(final[0], 0), (parseInt(final[1], 0) - 1), parseInt(final[2], 0));

        return Math.floor( ( ( dateEnd - dateStart ) / 86400 ) / 1000 );

    }

    /**
     * Function that transforms a number day into a literal date
     * @param day Number of day(s)
     */
    transformDayLiteral(day: number): string {

        let num: any;
        let num2: any;

        if (day / 365.2427 >= 1) {

          num = Math.floor(day / 365.2427);
          num2 = num * 365.2427;
          return num + ' año(s), ' + this.transformDayLiteral(day - num2);

        }

        if (day / 30.437 >= 1) {

          num = Math.floor(day / 30.437);
          num2 = num * 30.437;
          return  num + ' mes(es), ' + this.transformDayLiteral(day - num2);

        }

        if (day / 7 >= 1) {

          num = Math.floor(day / 7);
          num2 = num * 7;
          return num + ' semana(s), ' + this.transformDayLiteral(day - num2);

        }

        if ( Math.floor(day) !== 0) {

          return Math.floor(day) + ' día(s).';

        } else {

          return '';

        }

    }

}
