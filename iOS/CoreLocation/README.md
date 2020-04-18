### Core Location

장치의 지리적 위치와 방향을 가져옵니다.

<br>

## OverView

```Core Location```은 장치의 지리적 위치, 고도 및 방향 또는 근처의 iBeacon[^1] 장치와 관련된 위치를 측정하는 서비스를 제공합니다.
이 프레임워크는 Wi-Fi, GPS, Bluetooth, 자기계, 기압계 및 셀룰러 하드웨어를 포함하여 장치에서 사용 가능한 모든 구성 요소를 사용하여 데이터를 수집합니다. ```CLLocationManager``` 클래스의 인스턴스를 사용하여 ```Core Location``` 서비스를 구성, 시작 및 중지할 수 있습니다. location manager는 다음과 같은 위치 관련 작업을 지원합니다.

- **기본적이거나 의미가 있는 위치를 업데이트 해줍니다.** 설정이 가능한 정확도로 사용자의 현재 위치에서 크고 작은 변경 사항을 추적합니다.
- **지역 모니터링.** 사용자가 해당 지역에 들어가거나 나갈때 관심 지역을 모니터링하고 위치 이벤트를 생성합니다.
- **Beacon ranging.** 근처의 비컨을 탐지하여 찾습니다.
- **나침반 기능.** Report heading[^2]이 탑재된 나침반으로 부터 변경됩니다.

위치 서비스를 사용하려면 앱이 승인을 요청하고 시스템이 사용자에게 요청을 승인하거나 거부하라는 메시지를 표시합니다. 초기 프롬프트는 다음과 같습니다.

<p align="center"><img width=300 src = "https://docs-assets.developer.apple.com/published/a26b435665/bd1e2eaa-ea1e-4e61-ba3a-f304e92a697a.png"></p>

<br>

iOS 기기에서 사용자는 설정 앱에서 언제든지 위치 서비스 설정을 변경할 수 있으며, 개별 앱이나 기기 전체에 영향을 미칩니다. 앱은 ```CLLocationManagerDelegate``` 프로토콜을 따르는 location manager의 delegate 객체에서 권한 변경을 포함한 이벤트를 수신합니다.

[^1]: iOS 기기들에게 자신의 위치를 알릴 수 있는, 새로운 형태의 저전력, 저비용의 전파발신장치 (출처 : [위키: 아이비콘](https://ko.wikipedia.org/wiki/%EC%95%84%EC%9D%B4%EB%B9%84%EC%BD%98))
[^2]: 나침반의 북쪽을 가리키는 compass head라 생각된다.

<br>

<br>

# Adding Location Services to Your App - Article

## Start Location Services and Receive Events

```CLLocationManager``` 인스턴스에서 다른 메서드를 사용하기 전에 delegate 개체를 설정해야 합니다.

- ```CLLocationManager```에서 적절한 메서드를 호출하여 이벤트 전송을 시작합니다.
- ```CLLocationManager```에서 적절한 메서드를 호출하여 앱이 더 이상 위치 이벤트를 수신할 필요가 없을 때 서비스를 중지합니다.

```Core Location```은 필요하지 않을 때 하드웨어를 꺼 전력(배터리)을 적극적으로 관리합니다.
예를 들어, 위치 이벤트에 필요한 정확도를 1km로 설정하면 location manager가 GPS 하드웨어를 끄고 WiFi 또는 셀 라디오에만 의존할 수 있으므로 상당한 전력 절감 효과를 얻을 수 있습니다.

<br>

# Choosing the Location Services Authorization to Request - Article

## OverView

앱이 위치 이벤트를 수신하는지 여부와 수신 시기를 결정하는 권한 상태입니다. 앱에서 요청할 수 있는 인증에는 두 가지 유형이 있습니다.

- 사용할 때만
  앱이 사용 중인 동안 모든 위치 서비스를 사용하고 이벤트를 수신할 수 있습니다. 일반적으로 iOS 앱은 배경 위치 사용 표시기가 활성화된 상태에서 포어그라운드 또는 백그라운드에서 실행 중일 때 사용 중인 것으로 간주됩니다.

- 항상
  앱은 모든 위치 서비스를 사용할 수 있으며, 사용자가 앱이 실행되고 있다는 것을 알지 못하는 경우에도 이벤트를 수신할 수 있습니다. 앱이 실행되고 있지 않으면 시스템이 앱을 시작하고 이벤트를 제공합니다.
  
<br>
  
# Core Location Framework 예제 참고
원문 : https://fluffy.es/current-location/

## 전체 core location 사용 흐름
<p align="center"><img src="https://iosimage.s3.amazonaws.com/2019/45-current-location/locationFlow.png"></p>

<br>

## initialization code
```swift
// ViewController.swift
import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
  
     override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
}

extension ViewController: CLLocationManagerDelegate {
    //이곳에서 delegate 메소드나 location manager를 다루면 된다.
}
```
<br>

## 사용자의 현재 위치를 알아내는 방법
1. locationManager.requestLocation() 
2. locationManager.startUpdatingLocation()

차이점은 단 한번 요청(1번 메소드)하는가, 지속적으로 요청(2번 메소드)하는가.

```swift
// requestLocation()
extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // locations라는 배열로 현재 위치를 가져온다.
        // 첫번째 인덱스에 있는 정보로 활용이 가능하다.
        if let location = locations.first {
            self.latitudeLabel.text = "\(location.coordinate.latitude)"
            self.longitudeLabel.text = "\(location.coordinate.longitude)"
        }
    }
}


// startUpdatingLocation()
extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // locations의 배열에 하나 이상의 location을 담고 있음.
      for location in locations {
        // 마지막 인덱스에 가까울 수록 최근 위치.
      }
    }
}
// stopUpdatingLocation으로 추적을 멈출수가 있음.
```
<br>

## 에러 핸들링
```swift
func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    // 사용자가 장치에서 위치 서비스를 활성화하지 않았을때나,
    // 건물 내부에 있어 GPS 신호가 잡히지 않을 경우.
  
    // 예를 들자면 사용자에게 GPS 신호가 있는 장소로 걸어가라고 요청하는 경고를 표시하는 것이 좋습니다.
}
```

<br>

## requestLocation()이 위치를 검색하는데 더 오래 걸릴 수도 있습니다.
requestLocation()는 Apple에서 제공하는 편리한 방법으로, 내부에서 startUpdatingLocation()을 실행하고, 여러 위치 데이터를 검색하고, delegate에게 전달할 가장 정확한 데이터를 선택하고, StopUpdatingLocation()을 호출합니다. 이 프로세스는 어떤 위치 데이터가 가장 적합한지 결정할 수 없는 경우 최대 10초(타임아웃 전후)가 걸릴 수 있습니다.

검색 속도가 앱에 중요하고 위치 데이터 검색 및 필터링의 시작/중지 작업을 처리할 경우 대신 startUpdatingLocation()을 사용합니다.

<br>

## 정확도
위치 데이터를 요청하기 전에 CLLocationManager에 대해 원하는 정확도 속성을 지정하여 위치 데이터의 정확도를 지정할 수 있습니다.

```swift
// location data의 정확도는 100m 범위내에 있음.
locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
```

iOS 및 macOS의 경우 이 속성의 기본값은 ```kCLLocationAccuracyBest```입니다. watchOS의 경우 기본값은 ```kCLLocationAccuracyHundredMeters``` 입니다.
-> 애플 공식문서 참고.

오차범위가 낮아질수록 반대급부로 위치를 특정하는 시간이 더 오래걸리므로 위치를 찾는데 시간을 절약해야할 필요가 있으면 적절하게 사용해야 한다고 합니다.
