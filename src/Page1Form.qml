import QtQuick 2.9
import QtQuick.Controls 2.9
import Radio 1.0
import QtQml 2.9

Page {
    width: 800
    height: 480

    YRadio{
        id: radio
    }

    function fnSwitch(){
        console.log("onOff:", swRadio.checked)
        radio.onOff = swRadio.checked
        if (swRadio.checked){
            swRadio.text = qsTr("Radio ON")
        } else {
            swRadio.text = qsTr("Radio OFF")
        }
    }

    function fnDisplayOn(){
         console.log("display:", swDisplay.checked)
        radio.displayOn = swDisplay.checked
        if (swDisplay.checked){
            swDisplay.text = qsTr("Display ON")
        } else {
            swDisplay.text = qsTr("Display OFF")
        }
    }

    function fnVolumeSlider(){
        console.log("Volume/Slider:", slVolume.value)
        radio.volume = slVolume.value
        lbVolume.text = qsTr("Volume: ") + slVolume.value.toFixed()
    }

    Timer {
        id: timerRadio
        interval: 60000; running: true; repeat: true
        onTriggered: {
            console.log("get current played list, need to use once in 1 min")
            var xhr2 = new XMLHttpRequest;
            xhr2.open("GET","https://www.arabella.at/songfinder/");
            xhr2.send();
            xhr2.onreadystatechange = function() {
                if (xhr2.readyState == 4 && xhr2.status == 200) {
                    console.log( "get answer of bytes:", xhr2.response.length);
                    //around 70kb - need to parse in C++
                    //console.log("html", xhr2.responseText);
                    /* //example to parse, path in mozilla: view-source:https://www.arabella.at/songfinder/
                    <table class="table-playlist">
                            <tbody><tr>
                                 <td class="when"> <div>
                                                <span class="when-date">23.11.</span>
                                                <span class="when-time">12:37</span>
                                            </div>   </td>
                                        <td class="title"> <div>
                                                <h4 class="title-song">Got My Mind Set On You</h4>
                                                <h5 class="title-performer">George Harrison</h5>
                                            </div>   </td>
                */
                }
            }
        }
    }
//    header: Label {
//        text: qsTr("Main")
//        horizontalAlignment: Text.AlignHCenter
//        font.pixelSize: Qt.application.font.pixelSize * 2
//        padding: 10
//    }

    GroupBox {
        id: gbRadio
        x: 2
        y: 6
        width: 148
        height: 400
        title: qsTr("Radio")


        Switch {
            id: swRadio
            x: -10
            y: 320
            text: qsTr("Radio")

            checked: radio.onOff
            onCheckedChanged: fnSwitch()
        }


        Slider {
            id: slVolume
            x: 54
            y: 10
            width: 10
            height: 290
            stepSize: 1
            to: 100
            orientation: Qt.Vertical
            value: radio.volume
            onMoved: fnVolumeSlider()
        }

        Label {
            id: lbVolume
            x: 10
            y: 300
            //font.pixelSize: Qt.application.font.pixelSize * 1.4
            text: qsTr("Volume: 40")
        }
    }

    function fnParseWeatherData(weatherData) {
            console.log("temperature,K",weatherData.main.temp);
            console.log("pressure",weatherData.main.pressure);
            lbTemperature.text = (weatherData.main.temp-273).toFixed()+" C";
            lbWind.text = weatherData.wind.speed+" m/s? or km/h";
            lbWindDirection.text = weatherData.wind.deg + "North - 0?";
        }
    Timer {
        id: timerWeather
        interval: 60000; running: true; repeat: true
        onTriggered: {
            var xhr = new XMLHttpRequest;
            xhr.open("GET","https://samples.openweathermap.org/data/2.5/weather?lat=48.0222&lon=16.6268&appid=b6907d289e10d714a6e88b30761fae22");
            xhr.onreadystatechange = function() {
                console.log( "get answer of bytes:", xhr.response.length);
//                if (xhr.readyState == XMLHttpRequest.DONE) {
//                    var a = JSON.parse(xhr.responseText);
//                    fnParseWeatherData(a);
//                }
            }
            xhr.send();
        }
    }
    GroupBox {
        id: gbWeather
        x: 630
        y: 6
        width: 148
        height: 400
        title: qsTr("Weather")

        Label {
            id: lbTemperature
            x: 10
            y: 33
            text: qsTr("+10C")
            horizontalAlignment: Text.AlignRight
            font.pointSize: 20
        }

        Label {
            id: lbWind
            x: 10
            y: 81
            text: qsTr("25 km/h")
            horizontalAlignment: Text.AlignRight
            font.pointSize: 20
        }

        Label {
            id: lbWindDirection
            x: 10
            y: 139
            text: qsTr("S-E")
            font.pointSize: 20
            horizontalAlignment: Text.AlignRight
        }
        Switch {
            id: swDisplay
            x: -10
            y: 320
            text: qsTr("Display OFF")
            checked: radio.displayOn
            onCheckedChanged: fnDisplayOn()
        }
    }



    Timer {
        id: timer
        interval: 1000; running: true; repeat: true
        onTriggered: {
            lbDate.text = Qt.formatDateTime(new Date, "dddd, d MMM")
            lbTime.text = Qt.formatDateTime(new Date, "HH:mm")
        }
    }
    GroupBox {
        id: gbTimeDate
        x: 146
        y: 6
        width: 488
        height: 400
        title: qsTr("Time/Date")

        Label {
            id: lbDate
            x: 243
            y: 30
            width: 1
            height: 0
            text: qsTr("Friday, Nov 22")
            font.pixelSize: Qt.application.font.pixelSize * 3
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            id: lbTime
            x: 242
            y: 120
            width: 1
            height: 156
            text: qsTr("00:00")
            horizontalAlignment: Text.AlignHCenter
            //font.pointSize: 100
            font.pixelSize: Qt.application.font.pixelSize * 6
        }
    }
}
