import Quickshell.Io

JsonObject {
    property bool enabled: true
    property int maxToasts: 4
    property Toasts toasts: Toasts {}

    property Sizes sizes: Sizes {}

    component Sizes: JsonObject {
        property int width: 430
        property int toastWidth: 430
    }

    component Toasts: JsonObject {
        property bool audioOutputChanged: true
        property bool audioInputChanged: true
        property bool configLoaded: false
        property bool chargingChanged: true
        property bool gameModeChanged: false
        property bool dndChanged: false
        property bool capsLockChanged: false
        property bool numLockChanged: false
    }
}
