import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SddmComponents
import "."

Rectangle {
    id: container
    width: 2560
    height: 1440
    color: "transparent"

    property int sessionIndex: (typeof session !== "undefined") ? session.index : sessionModel.lastIndex

    TextConstants { id: textConstants }

    FontLoader { id: loginfont; source: "CompactaBT.ttf" }
    FontLoader { id: loginfontbold; source: "HelveticaUltraComp.ttf" }
    FontLoader { id: titlefontbold; source: "HelveticaUltraComp.ttf" }

    Connections {
        target: sddm
        function onLoginSucceeded() {
            errorMessage.color = "white"
            errorMessage.text = textConstants.loginSucceeded
        }
        function onLoginFailed() {
            password.text = ""
            errorMessage.color = "#ff9999"
            errorMessage.text = textConstants.loginFailed
            errorMessage.font.bold = true
        }
    }

    // Fixed Image block - z: -100 keeps it at the bottom
    Image {
        id: background
        anchors.fill: parent
        source: "/usr/share/sddm/themes/federation/newbg.jpg"
        fillMode: Image.PreserveAspectCrop
        z: -100
        asynchronous: false
        cache: true
        visible: true
    }

    // Placeholders to fix reference errors
    Item { id: rebootButton; visible: false }
    Item { id: shutdownButton; visible: false }

    // Wrap the UI in its own layer
    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Rectangle {
            id: promptbox
            anchors.left: parent.left
            anchors.leftMargin: 120
            y: parent.height / 2 - 250
            color: "transparent"
            height: 260
            width: 440

            Text {
                id: errorMessage
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 48
                text: textConstants.prompt
                font.pointSize: 10
                color: "white"
                font.family: loginfont.name
            }

            Grid {
                id: gridfield
                anchors.left: promptbox.left
                rowSpacing: 8
                verticalItemAlignment: Grid.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                columns: 2

                Text {
                    id: lblLoginName
                    width: 120
                    height: 30
                    text: textConstants.userName
                    font.pointSize: 12
                    color: "white"
                    font.family: loginfont.name
                }

                TextField {
                    id: name
                    font.family: loginfontbold.name
                    width: 320
                    height: 42
                    text: userModel.lastUser
                    font.pointSize: 14
                    color: "#040a0e"
                    background: Image { source: "input.svg" }
                    KeyNavigation.tab: password
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            password.focus = true
                        }
                    }
                }

                Text {
                    id: lblLoginPassword
                    width: 120
                    height: 30
                    text: textConstants.password
                    color: "white"
                    font.pointSize: 12
                    font.family: loginfont.name
                }

                TextField {
                    id: password
                    width: 320
                    height: 42
                    echoMode: TextInput.Password
                    font.family: loginfontbold.name
                    color: "black"
                    background: Image { source: "input.svg" }
                    KeyNavigation.backtab: name
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(name.text, password.text, sessionIndex)
                        }
                    }
                }
            }

            Row {
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Image {
                    id: loginButton
                    width: 128
                    height: 40
                    source: "buttonup.svg"
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.source = "buttonhover.svg"
                        onExited: parent.source = "buttonup.svg"
                        onPressed: {
                            parent.source = "buttondown.svg"
                            sddm.login(name.text, password.text, sessionIndex)
                        }
                        onReleased: parent.source = "buttonup.svg"
                    }
                    Text {
                        text: textConstants.login
                        anchors.centerIn: parent
                        font.family: loginfont.name
                        color: "white"
                    }
                }
            }
        }

        Image {
            id: greetbox
            anchors.left: parent.left
            anchors.leftMargin: 620
            y: parent.height / 2 - 250
            width: 8
            height: 320
            source: "divider.svg"
        }

        Rectangle {
            id: titlescreen
            anchors.left: parent.left
            y: 120
            anchors.leftMargin: 720
            color: "transparent"
            width: 740
            height: 300

            Text {
                id: greet
                color: "white"
                text: textConstants.welcomeText.arg(sddm.hostName)
                font.family: titlefontbold.name
                font.pointSize: 30
                font.bold: true
            }

            Clock2 {
                id: clock
                anchors.top: greet.bottom
            }
        }
    }
}
