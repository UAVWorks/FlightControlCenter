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

import FGear 0.1
import FGear.Pages 0.1
import FGear.Controls 0.1

FgPage {
    id: aircraftsPage
    objectName: "AircraftsPage"

    title: qsTr("Aircrafts")

    property bool extended: false

    FgTileView {
        id: tileView
        anchors.fill: parent
        model: aircraftsManager.model
        delegate: FgInfoTile {
            overlay: tileView.overlayItem
        }
    }
}
