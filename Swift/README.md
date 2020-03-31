# Swift

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

### 질문 2 작성

공부하고 정리한 내용을 여기에 추가.
