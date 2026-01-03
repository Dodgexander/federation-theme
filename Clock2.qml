/***************************************************************************
* Copyright (c) 2013 Abdurrahman AVCI <abdurrahmanavci@gmail.com>
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge,
* publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included
* in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
* OR OTHER DEALINGS IN THE SOFTWARE.
*
***************************************************************************/

import QtQuick

Column {
    id: container

    property date dateTime: new Date()
    property date futureDate: new Date(dateTime.getFullYear() + 385, dateTime.getMonth(), dateTime.getDate())
    property var d: new Date()
    property color color: "white"
    property alias timeFont: time.font
    property alias dateFont: date.font
    property alias stardateFont: stardate.font
    property real epochsecs: d.getTime()/1000;
    property real epochsd: epochsecs / 34367.0564
    property real stardate: epochsd + 33508.42

    Timer {
        interval: 100; running: true; repeat: true;
        onTriggered: {
            container.dateTime = new Date();
            container.d = new Date();
        }
    }

     Row {
        Text {
            id: time
            color: container.color
            text : Qt.formatTime(container.dateTime, "H:mm:ss") + "     "
            font.pointSize: 18
        }

        Text {
            id: date
            color: container.color
            text : Qt.formatDate(container.futureDate, Qt.DefaultLocaleLongDate) + "     "
            font.pointSize: 18
        }

         Text {
            id: stardate
            color: container.color
            text :  "Stardate " + container.stardate.toFixed(2)
            font.pointSize: 18
        }
    }
}
