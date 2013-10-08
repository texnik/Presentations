/* Copyright (c) 2013 BlackBerry Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import bb.cascades 1.2
import "Cities"

// This is a Page where a list of favorite cities are shown. A NavigationPane
// is used to drill down from the list of favorites into a specific
// city and present the weather report of that city.
NavigationPane {
    id: favNav
    
    Page {
        id: favorites
        
        titleBar: TitleBar {
            title: qsTr("Favorites") + Retranslate.onLanguageChanged
        }
        
        Container {
            CityList {
                dataModel: favModel
                
                onTriggered: {
                    var chosenItem = dataModel.data(indexPath);
                    
                    // Create the WeatherPage and set its properties, then push it to the NavigaitonPane.
                    var weatherPage = weatherPageDefinition.createObject();   
                    favNav.push(weatherPage);
                }
            }
        }
    }
        
    onPopTransitionEnded: {
        page.destroy();
    }
    
    attachedObjects: [
        ComponentDefinition {
            id: weatherPageDefinition
            source: "Weather/WeatherPage.qml"
        }
    ]
}
