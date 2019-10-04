# Angular Pipes

Pipes are used by putting the character | when painting a variable, for example we can put:

`{{ 'BBBBB' | lowercase }}`

And what it will print will be: bbbbb

## Pipes by default

1. Currency: Pipes for formatting currencies. To use them you have to pass to the pipe the currency that we want to use, for example: `{{ 345.76 | currency: 'EUR' }}`
2. Date: For formatting dates. As in the currency pipe, we must pass a parameter to the pipe depending on the format of dates we want, for example: `{{myVar | date: 'shortDate'}}`. The date formats that we can pass to these pipes are:
    * ‘short’: for example, 6/15/15, 9:03 AM
    * ‘medium’: for example, Jun 15, 2015, 9:03:01 AM
    * ‘long’: for example, June 15, 2015 at 9:03:01 AM GMT+1
    * ‘full’: for example, Monday, June 15, 2015 at 9:03:01 AM GMT+01:00
    * ‘shortDate’: for example, 6/15/15
    * ‘mediumDate’: for example, Jun 15, 2015
    * ‘longDate’: for example, June 15, 2015
    * ‘fullDate’: for example, Monday, June 15, 2015
    * ‘shortTime’: for example, 9:03 AM
    * ‘mediumTime’: for example, 9:03:01 AM
    * ‘longTime’: for example, 9:03:01 AM GMT+1
    * ‘fullTime’: for example,9:03:01 AM GMT+01:00
    We can also pass directly the format we want: `{{myVar | date: 'M/d/yy'}`
3. Decimal: To display numbers with a decimal point. As an argument, it receives numbers indicating how many decimals we want before and after the comma, for example: `{{ 3.14159265 | number: '3.1-2' }}`. We indicate that we want 3 numbers before the comma and 1 to 2 elements after the comma, which will print: 003.14.
4. JSON: If we directly print a variable that contains a JSON, Angular will print [object Object], but if we use this pipe, it will directly print the entire JSON: `{{ myVal | json }}`
5. LowerCase and UpperCase: As the name suggests, to transform text to uppercase or lowercase: `{{ 'test' | uppercase }}` or `{{ 'TEST' | lowercase }}`.
6. Percent: To print percentages, it is used the same as decimals, indicating the number of digits we want before and after the comma: `{{ 0.38679 | percent: '2.1-2' }}`. What will print: 38.68%
7. Slice: To trim arrays. Two numbers are passed the index of the beginning and the index of the end: `{{ [1,2,3,4,5,6] | slice:1:3 }}`. The result will be: 2,3

## Custom Pipes

To create pipes, Angular cli comes with a command to create them directly: `ng generate pip`

[Angular Pipes Docs](https://angular.io/guide/pipes).

[Pipes](https://codingpotions.com/angular-pipes/).
