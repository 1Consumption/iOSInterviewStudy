# iOS

### Bounds 와 Frame 의 차이점을 설명하시오.

**1. 애플 공식 문서(해석)**

   -  **Bounds**
        Bounds 사각형은 자체 좌표계에서 view의 위치와 크기를 말합니다.

        기본적인 bounds는 (0, 0)이며 frame 프로퍼티의 사각형 크기와 동일합니다.
        이 직사각형의 크기 부분을 변경하면 중심점을 기준으로 view가 확대되거나 축소됩니다. 
        또한 크기를 변경하면 frame 프로퍼티의 사각형 크기도 일치하도록 변경됩니다.
        Bounds 사각형의 좌표는 항상 특정한 점(point)에 지정됩니다.

        Bounds 사각형을 변경하면 ```draw(:)``` 메서드가 호출되지 않고 view가 자동으로 다시 표시됩니다.
        당신이 UIkit에서 draw(_:) 메서드를 호출하고 싶다면, ```contentMode``` 속성을 ```UIView.ContentMode.redraw```로 설정합니다.


   - **Frame**
        Frame 사각형: superView의 좌표 시스템에 있는 view의 위치와 크기를 말합니다.

        이 직사각형은 수퍼뷰의 좌표 시스템에서 view의 크기와 위치를 정의합니다.
        레이아웃 작업 중에 이 사각형을 사용하여 view의 크기를 설정하고 위치를 지정합니다.
        이 속성을 설정하면 center 프로퍼티로 지정된 점(point)이 변경되고 이에 맞춰서 Frame 사각형의 크기가 변경됩니다.
        Frame 사각형의 좌표는 항상 특정한 점(point)에 지정됩니다.

       >**Warning**
        Transform 프로퍼티가 정해지지 않은 transform일 경우, 해당 프로퍼티의 값이 정의되지 않으므로 이 속성이 무시될 수 있습니다. 
        => 정의되지 않은 transform 프로퍼티는 사용하지 못한다는 말 같음.
        ~~=> 당연한거 아닌가?~~
        => transform : 해당 프로퍼티를 사용해 view의 좌표계 내에서 뷰의 frame을 조정하거나 회전시킬 수 있습니다.

        Frame 사각형을 변경하면 ```draw(_:)``` 메서드가 호출되지 않고 view가 자동으로 다시 표시됩니다.
        당신이 UIkit에서 draw(_:) 메서드를 호출하고 싶다면, ```contentMode``` 속성을 ```UIView.ContentMode.redraw```로 설정합니다.


**2. 정리**

- **공통점**
view의 위치(좌표)와 크기를 나타내는 속성임.
: x, y 좌표 / width, height 값

- **차이점**
어디를 기준으로 잡고 뷰의 위치(좌표)와 크기를 나타내는지가 다르다.

    ```frame```은 superView(상위뷰)를 기준으로 자신의 위치를 정한다. (말해준다?)
    예를 들어 subView의 frame 좌표가 (10, 10)일 경우 superView(상위뷰)로 부터 (10, 10)만큼 떨어져 있다는 의미가 된다.
    그리고 ```frame```의 경우 view를 감싸는 사각형 모양의 view이기 때문에 회전시킬경우 좌표나 너비, 높이가 전부 달라지게 된다.

    ```bounds```는 자신을 기준으로 자신의 위치를 정한다. (자체 좌표계의 의미가 여기서 해당된다..!)
    ```bounds```의 좌표를 다시 설정해 줄 경우, 예를 들어 0,0 -> 100, 100으로 좌표를 변경해줄 경우 해당 view를 (100, 100)만큼 이동해주는게 아닌 해당 view를 (100, 100)위치에서 view를 다시 그려주게 된다.


### 실제 디바이스가 없을 경우 개발 환경에서 할 수 있는 것과 없는 것을 설명하시오.

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



### 앱이 foreground에 있을 때와 background에 있을 때 어떤 제약사항이 있고, 상태 변화에 따라 다른 동작을 처리하기 위한 델리게이트 메서드들을 설명하시오.

공부하고 정리한 내용을 여기에 추가.

### Scene Delegate에 대해 설명하시오.

#### iOS 13에서 Scene의 필요성

iOS 12 이전의 앱 딜리게이트에서는 앱 시작과 종료 등 프로세스 레벨의 이벤트와 함께, Foreground에 들어가거나, Active 상태에 들어가거나 하는 등의 UI 라이프 사이클 관련 이벤트들도 처리했어야 했습니다.

하지만, 예전엔 앱 하나당 하나의 프로세스이면서 하나의 유저 인터페이스만 있으면 됐었는데, 이제 하나의 앱에 여러 개의 유저 인터페이스가 필요해 졌습니다. 이 UI를 Scene Session이라고 합니다.

#### iOS 13에서의 App Delegate와 Scene Delegate

이제 App Delegate에서는 UI 라이프사이클에 관련된 이벤트들은 처리하지 않고, Scene Delegate에서 처리하게 되었습니다. UI를 셋업하거나 메모리에서 해제하는 등의 일은 이제 Scene Delegate에서 하게 됩니다. 이에 따라서, iOS 13에서는

- application:willEnterForeground
- application:didEnterBackground
- application:willResignActive
- application:didBecomeActive

이 메서드들은 호출되지 않고, 대신에

- scene:willEnterForeground
- scene:didEnterBackground
- scene:willResignActive
- scene:didBecomeActive

이 메서드들이 호출됩니다. 배포 타겟 버전이 iOS 12 및 그 이전 버전이라면, 두 세트의 메서드들을 모두 남겨두면 UIKit이 알아서 런타임에 알맞는 메서드들을 부르게 됩니다.

iOS 13에서 Scene 관련 기능들이 추가됨에 따라서, App Delegate에서 책임져야 할 추가적인 역할도 생겼습니다. 새로운 Scene Session이 생성되거나, 기존의 Scene Session이 버려질 때 App Delegate의 메서드가 호출됩니다.

#### UI를 Setup하는 위치의 변화

iOS 12 및 그 이전엔 App Delegate에서 UIWindow에 대한 레퍼런스를 갖고 있고, 앱 딜리게이트의 application(didFinishLanchingWithOptions:)에서 UIWindow 인스턴스를 생성하여 UI를 셋업하는 방식이었습니다. iOS 13 부터는 Scene Delegate에서 이 일을 하게 되었습니다.

#### App의 라이프 사이클에 따른 딜리게이트 메서드들과, 각 메서드들에서 수행하기 적합한 기능들

1. **App Delegate**의 didFinishLaunching — 앱 런치 후 한 번만 하면 되는 셋업을 하기에 적합합니다.
2. **App Delegate**의 configurationForSession — 앱 런치 직후, 시스템이 Scene session을 생성하기 전 호출하는 메서드입니다. 이곳에서는 어떤 씬이 생성되는지 등을 알 수 있습니다. Scene의 subclass를 명시하면 어떤 씬을 생성할 것인지 정할 수 있고, 씬에 맞는 configuration을 할 수도 있습니다. 매개변수로 전달되는 옵션을 보고 어떤 씬인지 알 수 있습니다. 
3. **Scene Delegate**의 willConnectToSession — 이곳에서 UIWindow 인스턴스를 생성하고 UI 셋업을 합니다. 이때 새로 생긴 `UIWindow(windowScene:)` 생성자를 이용하면 됩니다.
4. 앱에서 홈 화면으로 갈 때, 원래 App Delegate에서 호출되었던 메서드들인 willResignActive, didEnterBackground가 **Scene Delegate**에서 호출됩니다.
5. Scene이 백그라운드로 간 후에, 언제 호출될지는 모르지만 Scene을 메모리에서 해제하면서 **Scene Delegate**의 sceneDidDisconnect가 호출됩니다. 다시 해당 Scene에 돌아올 수도 있기 때문에 여기서 유저 데이터나 상태를 지우면 안됩니다.
6. 사용자가 앱을 종료하면, **App Delegate**의 didDiscardSceneSession이 호출됩니다. 이 때 Scene에 연관된 유저 데이터나 상태를 지울 수 있습니다.