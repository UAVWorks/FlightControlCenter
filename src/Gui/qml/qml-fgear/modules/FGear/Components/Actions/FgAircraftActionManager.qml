/*
 * Copyright © 2015-2016 Oleksii Aliakin. All rights reserved.
 * Author: Oleksii Aliakin (alex@nls.la)
 * Author: Andrii Shelest
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import QtQuick 2.7
import QtQml 2.2

import FGear 0.1
import FGear.Components.Actions 0.1

FgBaseActionManager {
    id: aircraftActionManager
    objectName: "aircraftActionManager"

    actions: [
        FgAircraftAction {
            objectName: "aircraftConnectedAction"
        },
        FgAircraftAction {
            objectName: "aircraftDisconnectedAction"
        }
    ]

    readonly property int count: aircraftObjects.model ? aircraftObjects.model.count : 0
    property int connectedCount: 0
    readonly property int disconnectedCount: (count - connectedCount)

    readonly property FgAircraftAction connectedAction: getByName("aircraftConnectedAction")
    readonly property FgAircraftAction disconnectedAction: getByName("aircraftDisconnectedAction")

    readonly property Instantiator aircraftObjects: Instantiator {
        QtObject {
            id: __aircraft

            property string _callsign: callsign
            property bool _connected: connected

            on_ConnectedChanged: {
                if (connected) {
                    connectedAction.activeObject = __aircraft;
                    connectedCount++;
                    connectedAction.triggered();
                } else {
                    disconnectedAction.activeObject = __aircraft;
                    connectedCount--;
                    disconnectedAction.triggered();
                }
            }
        }
    }
}
