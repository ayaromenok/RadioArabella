import QtQuick 2.9
import QtQuick.Controls 2.9
import Radio 1.0
import QtQml 2.9

Page {
    width: 640
    height: 400

    YRadio{
        id: radio
    }

    function fnSwitch(){
        console.log("onOff:", swRadio.checked)
        radio.onOff = swRadio.checked
        if (swRadio.checked){
            swRadio.text = qsTr("ON")
        } else {
            swRadio.text = qsTr("OFF")
        }
    }
    function fnVolumeDial(){
        console.log("Volume/Dial:", dlVolume.value)
        slVolume.value = dlVolume.value
        radio.volume = dlVolume.value
        lbVolume.text = qsTr("Volume: ") + dlVolume.value.toFixed()
    }
    function fnVolumeSlider(){
        console.log("Volume/Slider:", slVolume.value)
        dlVolume.value = slVolume.value
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
                }
            }
        }
    }
    header: Label {
        text: qsTr("Main")
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    GroupBox {
        id: gbRadio
        x: 0
        y: 6
        width: 148
        height: 300
        title: qsTr("Radio")

        Dial {
            id: dlVolume
            x: -12
            y: 71
            stepSize: 1
            to: 100
            value: radio.volume
            onMoved: fnVolumeDial()
        }

        Switch {
            id: swRadio
            x: 0
            y: 13
            text: qsTr("OFF")
            checked: radio.onOff
            onCheckedChanged: fnSwitch()
        }

        Slider {
            id: slVolume
            x: 84
            y: 71
            width: 36
            height: 100
            stepSize: 1
            to: 100
            orientation: Qt.Vertical
            value: radio.volume
            onMoved: fnVolumeSlider()
        }

        Label {
            id: lbVolume
            x: 23
            y: 188
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
                if (xhr.readyState == XMLHttpRequest.DONE) {
                    var a = JSON.parse(xhr.responseText);
                    fnParseWeatherData(a);
                }
            }
            xhr.send();
        }
    }
    GroupBox {
        id: gbWeather
        x: 492
        y: 6
        width: 148
        height: 235
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
        width: 347
        height: 235
        title: qsTr("Time/Date")

        Label {
            id: lbDate
            x: 143
            y: 20
            width: 41
            height: 0
            text: qsTr("Friday, Nov 22")
            font.pointSize: 30
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            id: lbTime
            x: 62
            y: 48
            width: 200
            height: 156
            text: qsTr("00:00")
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 100
        }
    }
}
