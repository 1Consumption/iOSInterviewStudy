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

<center><img width=300 src = "https://docs-assets.developer.apple.com/published/a26b435665/bd1e2eaa-ea1e-4e61-ba3a-f304e92a697a.png"></center>

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

링크 : https://fluffy.es/current-location/
