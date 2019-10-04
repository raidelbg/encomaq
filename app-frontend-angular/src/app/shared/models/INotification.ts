export interface INotification {
    title: string;
    message: string;
    type: ITypeNotification;
}

export type ITypeNotification = 'success' | 'danger' | 'warning' | 'primary';
