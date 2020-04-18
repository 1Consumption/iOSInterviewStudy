# 실제 디바이스가 없을 경우 개발 환경에서 할 수 있는 것과 없는 것을 설명하시오.



이에 앞서 시뮬레이터와 디바이스의 차이를 알아보자.

> [https://help.apple.com/simulator/mac/10.0/#/devb0244142d](https://help.apple.com/simulator/mac/10.0/#/devb0244142d)

## Overview

시뮬레이터는 Mac에서 실행되는 앱입니다. 따라서 CPU, 메모리 및 네트워크 연결일 비롯한 컴퓨터의 리소스에 액세스할 수 있습니다. 즉 이 말은 성능, 메모리 사용 및 네트워킹 속도를 테스트해야 할 때 실제 디바이스 속도와 매우 다를 수 있다는 말입니다.

그럼 조금 더 알아볼까요?



## 차이점

### 일반적인 차이(General differences)

* 위에서 말했던 것 처럼 simulator는 Mac의 앱이고, Mac의 리소스를 끌어다 쓰기 때문에 정확한 속도를 파악하는데는 문제가 있습니다. 하지만, 앱과 앱사이의 상대적인 속도를 비교할 때는 쓸 수 있습니다. 따라서 실제 결과를 테스트할 경우 디바이스가 필수적입니다. 

* Mac의 포인터나 키보드는 손가락을 사용한 iOS나 watchOS의 인터랙션과 다릅니다.

### 디스플레이 차이

* 디바이스와 Mac의 해상도(Point당 pixel)은 다를 수 있습니다. 이로 인해 텍스트와 이미지가 삐쭉삐쭉하게 표시될 수 있으며, 특히 작은 텍스트가 표시됩니다.

* 시뮬레이터 윈도우의 스케일을 키우면, 이미지와 텍스트가 더 선명하게 보일 수 있습니다.

* Mac 화면의 색영역(color gamut)이 달라서 색상이 정확하지 않을 수 있습니다

> color gamut : 원본이 표현하는 색을 화면에서 어느 정도까지 표현 가능한지를 수치화한 것으로, 디스플레이에서 표현 가능한 색상의 범위를 의미합니다.

### 하드웨어 차이

* watchOS 와 iOS 디바이스를 시뮬레이터로 연결할 경우 연결을 보장합니다.
* 다음은 시뮬레이터에서 사용할 수 없는 하드웨어 기능 입니다.
  * 조도 센서 
  * Siri를 선택하는 것을 제외한 오디오 입력 -> iOS 13버전 시뮬레이터에서는 확인 안됨
  * 기압계
  * 블루투스
  * 카메라
  * 가속계, 자이로스코프
  * 근접 센서(Proximity sensor)

### API 차이

* framework
  * ARKit
  * External Accessory
    * Apple Lightning 커넥터를 통해 장비에 연결되거나 Bluetooth를 통해 무선으로 연결된 액세서리와 통신을 하는 프레임워크
  * HomeKit
    * 홈 오토메이션 악세서리와 통신, 설정 및 제어를 함
  * IOSurface
  * Media Player
    * 앱 내에서 노래, 오디오 팟 캐스트, 오디오 북 등을 찾아서 재생 함
  * Message UI
    * ![](https://docs-assets.developer.apple.com/published/403f4fa522/240e4280-8b80-4559-97ae-7aee0d916a56.png)

* API
  * Apple push notification을 보내고 받기
  * The `UIBackgroundModes` key
  * UIKit 내부의 `UIVideoEditorController` 클래스