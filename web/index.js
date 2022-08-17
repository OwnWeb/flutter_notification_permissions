window.jsInvokeMethod = async (method, params) => {
    switch (method) {
        case 'getNotificationPermissionStatus':
        getNotificationPermissionStatus();
        break;

        default:
        console.log('Method ' + method + ' not handled');
    }
}

getNotificationPermissionStatus = () {
    return Notification.permission;
}
