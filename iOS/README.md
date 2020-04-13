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

키워드
`App LifeCycle`,`AppDelegate`,`Foreground`, `background`
> **사전 지식**
> **- iOS 앱이 시작할 때 과정**
> 1.UIApplication 객체 생성
> 2.@UIApplicationMain annotation이 있는 클래스를 찾아 AppDelegate 객체 생성
> 3.Main Event Loop를 실행(touch, text input등 사용자의 액션을 받는 루프) 및 기타 설정
> UIApplication 객체는 싱글톤 객체이며 Event Loop에서 발생하는 여러 이벤트들을 감지하고 Delegate에 전달하는 역할을 합니다.
> AppDelegate 객체는 UIApplication 객체로 부터 메시지를 받았을 때, 해당 상황에서 실행 될 함수들을 정의합니다. Xcode로 Swift 프로젝트를 만들면 자동으로 생성되는 AppDelegate.swift 파일 클래스 선언부분에 @UIApplicationMain annotation이 붙어있기 때문에 앱이 구동되면 AppDelegate.swift의 AppDelegate 클래스를 delegate 객체로 지정합니다. AppDelegate.swift 파일에는 앱의 상태에 따라 실행되는 함수들이 정의되어 있습니다. 정의된 함수들은 앱의 5개의 실행 상태로 구분 될 수 있습니다.
> Non-running - 앱이 아직 실행되지 않은 상태
> Inactive - 앱이 foreground에서 실행되고 있지만 이벤트를 받지 않는 상태. 예를들어, 전화나 SMS를 수신할 경우 앱을 Inactive 상태로 전환할 수 있습니다. 
> Active - 앱이 foreground에서 실행되고 이벤트를 받고 있습니다.
> Background - 앱이 background에서 실행되고 있고 코드를 실행하고 있습니다.
> Suspended - 앱이 background에서 실행되고 있고 실행할 코드가 없습니다.
![](https://i.imgur.com/svF1H66.png)
![](https://i.imgur.com/xl2HkGI.png)
(출처: https://velog.io/@cskim/iOS-App-%EC%83%9D%EB%AA%85%EC%A3%BC%EA%B8%B0Life-Cycle)
## 앱이 foreground에 있을 때 제약 사항
- Foreground에 진입할 때 앱의 데이터 모델을 업데이트 해야합니다.
**델리게이트 메소드**
```sceneWillEnterForeground(_:)```
```applicationWillEnterForeground(_:) ```
- 유저 인터페이스와 활성화시 초기 작업을 설정해야하니다
 1. 앱의 윈도우를 보인다(필요시)
 2. 현재 보여지는 View Controller를 바꾼다 (필요시)
 3. 데이터 값 그리고 뷰와 콘트롤의 상태를 업데이트 한다
 4. 일시 중지된 게임을 재개(resume)하기 위한 컨트롤 표시.
 5. 작업을 수행하는데 사용하는 모든 dispatch queue를 시작하거나 다시 시작한다.
 6. 데이터 소스 객체를 업데이트한다.
 7. 주기적인 작업을 위한 타이머를 시작한다.
**델리게이트 메소드**
```sceneDidBecomeActive(_:)``` 
```applicationDidBecomeActive(_:)```
앱이 active되면 애플리케이션 델리게이트가 applicationDidBecomeActive 메소드를 통해 콜백 노티피케이션 메세지를 받게 됩니다. 앱이 Inactive 상태에서 Active 상태로 되돌아올 때마다 호출됩니다.

Activation는 사용자에게 UI를 표시하기 전에 UI를 마무리할 수 있는 시간이다. 활성화 방법을 차단할 수 있는 코드를 실행하지 마십시오. 대신 필요한 것은 미리 다 준비해두도록 한다. 예를 들어 앱 밖에서 데이터가 자주 바뀐다면, foreground에 앱이 돌아오기 전에 네트워크로부터 업데이트를 가지고 오는 백그라운드의 작업을 이용해라. 아니면 비동기적으로 변화를 가지고 오는 동안 기존의 데이터를 표시하는 준비를 해라.

## 앱이 background에 있을 때 제약 사항

백그라운드 상태가 있을때, 가능한 한 적게 해야하고, 가급적 아무것도 하지 않는 것이 좋습니다.

만약 앱이 이전에 포어그라운드에 있었다면 백그라운드 트렌지션(전환)을 사용해 작업을 중단하고 모든 공유 리소스를 해제해야합니다. 앱이 중요한 이벤트를 처리하기 위해 백그라운드에서 입력하는 경우 이벤트를 처리하고 가능한 한 빨리 종료해야합니다.
- 비활성화 시 애플리케이션 중단

**델리게이트 메소드**
`sceneWillResignActive(_:)`
`applicationWillResignActive(_:)` 

1. 사용자 데이터를 디스크에 저장하고 열려있는 파일을 모두 닫는다
2. dispatch 및 operation queue를 일시 중단한다.
3. 실행을 위한 어떤 새로운 작업의 일정을 잡지않는다.
4. 활성화 되어있는 모든 타이머를 무효화시킨다.
5. 자동으로 게임 플레이를 일시중지한다.
6. 처리될 모든 새로운 Metal 작업을 약속하지 않는다.
7. 모든 새로운 OpenGL 명령어를 약속하지 않는다.

- 백그라운드 진입시 리소스를 놓아줌
앱이 백그라운드로 전환되면 메모리를 해제하고 앱이 보유하고 있는 공유 리소스를 확보합니다. 앱이 포어그라운드에서 백그라운드로 전환하는 것에 있어서 특히 메모리를 해제하는게(free up) 중요합니다. 포어그라운드는 메모리와 다른 시스템 자원보다 우선순위를 가지고 있으며, 세스템은 그러한 리소스를 이용할 수 있도록 백그라운드 앱을 종료합니다. 앱이 전면에 나타나지 않았더라도 리소스를 최대한 적게 사용하는지 확인해야합니다.  


**델리게이트 메소드**
`sceneDidEnterBackground(_:)` 
`applicationDidEnterBackground(_:)`

백그라운드 전환 중에 다음 작업 중 앱에 적합한 작업을 수행합니다.
1. 파일에서 직접 읽은 모든 미디어나 이미지를 삭제한다.
2. 디스크에서 재생성하거나 다시 로드할 수 있는 큰 메모리 개체를 모두 삭제한다.
3. 카메라 및 기타 공유 하드웨어 리소스에 대한 액세스 권한을 해제한다.
4. 앱의 사용자 인터페이스에 있는 비밀번호와 같은 민감한 정보를 숨긴다.
5. 알람과 다른 임시 인터페이스를 해제한다
6. 모든 공유 시스템 데이터 베이스와의 연결을 종료한다. 
7. Bonjour 서비스에서 등록을 취소하고 관련 수신 소켓을 모두 닫는다.
8. 모든 Metal command buffer가 스케쥴 되었는지 확인한다.
9. 이전에 제출한 모든 OpenGL 명령이 완료됐는지 확인한다.

백그라운드로 전환할 때 앱이 공유 시스템 리소스를 보유하고 있지 않은지 확인해야합니다. 백그라운드로 전환한 후에도 카메라나 공유 시스템 데이터베이스와 같은 리소스에 계속 액세스하는 경우, 시스템은 해당 리소스를 확보하기 위해 앱을 종료합니다. 시스템 프레임워크를 사용하여 리소스에 액세스하는 경우 프레임워크의 설명서에서 수행할 작업에 대한 지침을 확인해야합니다.

- 앱 스냅샷에 대한 UI 준비
또한 앱을 다시 전면에 배치할 때 일시적으로 이미지를 표시해야합니다.
앱의 UI에는 패스워드나 신용 카드 번호와 같은 어떤 민감한 사용자 정보가 포함되지 않아야 합니다. 만약 인터페이스가 이런 정보를 포함하고 있다면 백그라운드에 진입할 때 뷰에서 지워야 합니다. 또한 알람과 임시 인터페이스, 그리고 앱의 콘텐트를 모호하게 하는 시스템 view controller를 해제합니다. 스냅샷은 앱의 인터페이스를 나타내고 사용자가 인식할 수 있어야 합니다.

- 백그라운드에서 중요한 이벤트에 대한 대응
앱은 보통 백그라운드에 들어간 후 별도의 실행 시간을 받지 않습니다. 그러나 UIKit는 다음과 같은 시간에 민감한 기능을 지원하는 앱에 실행 시간을 부여합니다.
1. AirPlay를 사용한 오디오 커뮤니케이션 또는 Picture video 안에 사진.
2. 사용자의 우치에 민감한 서비스
3. 인터넷 전화(Voice over IP)
4. 외부 액세서리와 커뮤니케이션(Communication with an external accessory)
5. Bluetooth LE 액세서리와의 통신 또는 장치를 Bluetooth LE 액세서리로 변환
6. 서버로부터 정규 업데이트
7. Apple Push Notification 서비스 지원

### 참고한 자료
https://developer.apple.com/documentation/uikit/app_and_environment/scenes/preparing_your_ui_to_run_in_the_foreground

https://developer.apple.com/documentation/uikit/app_and_environment/scenes/preparing_your_ui_to_run_in_the_background

https://www.techrepublic.com/blog/software-engineer/understand-the-states-and-transitions-of-an-ios-app/

---------------------------------------------------


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

## TableView
### 구성 
- Cell: 콘텐츠 표현. UIKit에서 제공하는 기본 셀이나 커스텀 셀 사용 가능. 

- Table view controller: UITableViewController가 아닌 다른 뷰 컨트롤러도 사용할 수 있음. 하지만 일부 테이블 관련 기능이 작동하려면 테이블 뷰 컨트롤러가 필요하다. 
-> 일부 동작의 예: 선택 관리(selection management), 열(row) 수정, 테이블 설정(configure) 등의 동작

- Data source: UITableViewDataSource 프로토콜 채택. 테이블을 위한 데이터 제공

- Delegate: UITableViewDelegate 프로토콜 채택. 테이블의 콘텐츠와 사용자와의 상호작용(user interactions) 관리

## 데이터로 테이블 채우기

#### 행과 섹션의 수를 제공하는 UITableViewDataSource
화면에 나타나기 전에 테이블 뷰는 행과 단면의 총 수를 지정하도록 요청한다. 

```swift
func numberOfSections(in tableView: UITableView) -> Int  // Optional 
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```
* data source 객체는 테이블로부터 온 데이터 관련 요청에 응답한다.
* 테이블의 데이터를 직접 관리하거나 앱의 다른 부분과 조정하여 해당 데이터를 관리한다. 
* 테이블의 행(row)과 섹션(section) 수를 보고한다.
* 테이블의 각 행에 들어갈 셀을 제공한다.
* 섹션의 헤더와 푸터의 타이틀을 제공한다.
* 테이블의 인덱스를 설정한다.

테이블 뷰는 NSIndexPath 객체의 행 및 섹션 프로퍼티를 사용하여 셀 위치를 사용자에게 전달한다.
행과 섹션 인덱스는 0부터 시작하고 행을 고유하게 식별하기 위해 섹션 및 행 값이 모두 필요하다.

#### 행의 모양을 정의하는 UITableViewCell
* 테이블 행의 탬플릿같은 역할을 하는 객체
* UITableViewCell 상속
* Cell은 뷰로, 다른 서브뷰를 포함할 수 있다. (label, image view 등)
* UIKit에서 제공하는 표준 스타일 중에 하나를 선택할 수도 있고 커스텀 스타일을 정의해도 된다.

** UIKit에서 제공하는 표준 스타일 **

![](https://i.imgur.com/H3bEeEe.png)
 UITableCell이 콘텐츠를 보여주는 뷰를 제공. textLabel,detailTextLabel,imageView
만약에 채워넣지 않으면 다른 빈 공간으로 보여진다.

** 코드 구현 **
![](https://i.imgur.com/taR0Hwl.png)

- Default
![](https://i.imgur.com/kXJvkYt.png)

- Value1
![](https://i.imgur.com/XCh0Gb1.png)

- Value2
![](https://i.imgur.com/uB7X9kX.png)

- Submit
![](https://i.imgur.com/fiKlywB.png)

(사진 출처:[Coding Magic](http://coding-is-kind-of-magic.blogspot.com/2012/02/uitableview-has-some-build-in-styles.html))


#### 퍼포먼스 향상을 위한 UITableViewDataSourcePrefetching
* UITableView와 UICollectionView에서 사용할 수 있는 프로토콜이다.
*  
```swift
tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath])
````
이 델리게이트 함수는 행이 디스플레이 영역에 다다랐을 때 호출될 것이며 이 곳에서 만약 API로 데이터를 받아오고 있다면 API를 호출하여 데이터를 받아올 수 있다.

![](https://i.imgur.com/lnZj1Hy.png)
출처([군옥수수 블로그](https://ehdrjsdlzzzz.github.io/2018/09/19/Smoothen-your-table-view-data-loading-using-UITableViewDataSource-Prefetching/))

* ```swift tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath])``` 함수는 스크롤을 하지 않는 이상 화면에 보여지지 않는 행을 불러오지 않는다.
* 초기 보여질 수 있는 행이 보여지면 ```tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath])```가 호출된다. indexPath 변수는 약 10개의 보여질 수 있는 영역 근처의 행들을 포함하게 된다.
* 스크롤 속도에 따라 prefetch 함수의 indexPath 변수가 포함하게 되는 행의 갯수는 달라진다. 보통의 스크롤 속도에는 보통 1개의 행을 포함한다. 만일 빠른 속도로 스크롤하게 되면 다수의 행을 포함하게 된다.

참고
[Filling a Table with Data](https://hackmd.io/ZSRD90WwT1e1za6HhnQLvg)

[UITableViewDataSource](https://hackmd.io/ZSRD90WwT1e1za6HhnQLvg)

[UITableViewController](https://developer.apple.com/documentation/uikit/uitableviewcontroller) 



## Container ViewController

- View Controller는 한 화면에서 처리할 책임이 너무 많을 때가 있는데, 이는 SRP(Single Responsibility Principle)를 위반해 모듈 간 긴밀하게 결합하고, 각 부품의 재사용과 테스트가 어려워지게 한다.
- 메모리적인 이점은 없지만, 하나의 View Controller에서의 역할을 Container View Controller로 분담하면 재사용성을 높일 수 있고 디자인 패턴을 사용하는데 용이하다. [Movie List 예시](https://www.appcoda.com/container-view-controller/)
- 각 Child는 자신의 보기 계층을 계속 관리하지만  Container ViewController는 해당 Child의 root view의 위치와 크기(position and size)를 관리한다.
  ![](https://i.imgur.com/hTlYAAP.png)

### Programmatically

- 컨테이너 뷰 컨트롤러가 하위 뷰 컨트롤러를 동적으로 변경하면 해당 하위 항목을 프로그래밍 방식으로 추가하는 것이 더 쉽다.

```swift
// 스토리보드에 viewController를 생성했을 경우
//child ViewController 생성 

let storyboard = UIStoryboard(name: "Main", bundle: .main)
if let firstChildVC = storyboard.instantiateViewController(identifier: "firstChildVC")
                                    as? FirstChildVC {
   // container에 view controller 추가
   addChild(firstChildVC) // containment relationship 추가
   view.addSubview(firstChildVC.view) // container의 view 계층에 child의 root view 추가
            
   // child view의 size와 position을 설정하는 constraints 추가
   onscreenConstraints = configureConstraintsForContainedView(containedView: firstChildVC.view,
                             stage: .onscreen)
   NSLayoutConstraint.activate(onscreenConstraints)
     
   // controller의 전환(transition)이 완료됐음을 알림    
   viewController.didMove(toParent: self)
}

// 또 다른 방법 - 스토리보드에 viewController를 생성하지 않았을 경우
    let secondChildVC = SecondChildVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSecondChildVC()
    }
    
    func addSecondChildVC() {
        addChild(secondChildVC)
        view.addSubview(secondChildVC.view)
        secondChildVC.didMove(toParent: self)
        setSecondChildVCConstraints()
    }
        
    func setSecondChildVCConstraints() {
        secondChildVC.view.translatesAutoresizingMaskIntoConstraints = false
        secondChildVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        secondChildVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        secondChildVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        secondChildVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400).isActive = true
    }
}
```


### Using Storyboard

<img src="https://i.imgur.com/hYZNnJY.png{width: 300}" style="zoom:50%;" />
<img src="https://i.imgur.com/IGk4Cdc.png" style="zoom:70%;" />

```swift
// Container View가 속해있는 ViewController 
class ViewController: UIViewController {

    enum Segues {
        static let toFirstChild = "ToFirstChild"
    }
    
// 만약 스토리보드로 추가한 Container View가 여러 개일 경우 필요
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toFirstChild {
            let destVC = segue.destination as! FirstChildVC
        }
    }
}    
    
```

### ViewController와 Container View Controller의 관계

1. 일반적으로 새로 생성된 ViewController는 Container ViewController와 다르다. 그것은 독립적인 ViewController이다. Segue를 임베드하면 원래 ViewController에서 어느 ViewController를 표시할지 정확하게 지정하게 된다. 그러나 Container ViewController는 여전히 이전 ViewController의 일부분이고 표시할 다른 ViewController의 View만 표시하는 역할을 한다.
2. Container ViewController를 포함하고 있는 ViewController는 Container View에 표시되는 다른 ViewController의 View를 선택하는 책임을 갖고있다. 

### 참고 자료

* [Creating a Custom Container View Controller](https://developer.apple.com/documentation/uikit/view_controllers/creating_a_custom_container_view_controller)



## context menu

iOS 13 이상부터 사용 가능하며 인터페이스를 어지럽히지 않고 현재 화면과 관련된 추가 기능에 접근이 가능하다~

<img src = "https://developer.apple.com/design/human-interface-guidelines/ios/images/context-menu_2x.png" width = "300" >



Peek and Pop과 비슷하지만 두가지 주요 차이점이 있다!

> Peek and Pop?
>
> <img src = "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=http%3A%2F%2Fcfile8.uf.tistory.com%2Fimage%2F99972A395C4D45B035D7F9"  width = "200">

1. peek and pop은 3D Touch를 지원하는 장치에서만 사용이 가능하다
2. context menu는 상황에 맞는 명령을 즉시 표시하지만, peek and pop은 위로 스와이프 해야 명령을 볼 수 있다.

#### 하지만 애플에서는 3D Touch를 더 이상 사용하지 않기 때문에(아이폰 11에도 3D touch를 탑재 하지 않음) 이는 그냥 이런게 있구나~ 정도로만 알자



context menu는 홀드 제스처 또는 3D Touch를 사용하여 도출 가능하다. 이를 사용하여 명령을 선택하거나 item을 다른 영역, window, app으로 드래그할 수 있다.

또한 context menu에는 가장 일반적으로 사용되는 기능을 넣는 것이 좋다. 예를 들어 메일을 보내는 상황에서 회신 및 이동 명령을 포함하는 것은 합리적이지만 사서함 명령을 포함하는 것은 합리적이지 않다. 너무 많은 명령을 나열하면 사용자들에게 혼동을 줄 수 있다.

context menu의 항목에 대해 사용자들에게 이해를 돕기위해 glyph를 포함할 수 있다. SF symbol을 사용하는 것을 권장한다.

하위 메뉴를 사용하여 보다 논리적으로 보조메뉴를 표시할 수 있다. 사용자들은 이를 통해 필요 없는 기능을 탐색하는 것을 피할 수 있다. 또한 depth는 한단계 정도가 적당하며, 자주 사용하는 항목을 상단에 배치해라.

![화면 기록 2020-04-08 오전 4 09 58](https://user-images.githubusercontent.com/37682858/78709703-0fa3ed00-794f-11ea-88b0-237f66a937af.gif)





#### 예시

##### ViewController.swift

```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var VIEW: UIView!
    let dele = delegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let inter = UIContextMenuInteraction(delegate: dele)
        VIEW.addInteraction(inter)
    }
}
```

##### delegate.swift

``` swift
import UIKit

class delegate: NSObject, UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { action in
            return self.makeMenu()
        })
    }
    
    
    func makeMenu() -> UIMenu {
        let add = UIAction(title: "add something", image: UIImage(systemName: "plus")){action in
            // do something
        }
        let delete = UIAction(title: "delete something", image: UIImage(systemName: "minus")){action in
            // do something
        }
        let A = UIAction(title: "do A"){action in
            //do something
        }
        let B = UIAction(title: "do B"){action in
            //do something
        }
        let innerMenu = UIMenu(title: "innerMenu", children: [A,B])
        let menu = UIMenu(title: "menuTitle", children: [add, delete, innerMenu])
        return menu
    }
}
```



##### 메소드 원형

```swift
func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
  <#code#>
}
```

UIContextMenuConfiguration: context menu의 구성 세부 정보가 포함 된 객체



### 이제 이것을 tableView에 적용해보자!

```swift
func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
        let moveToDone = UIAction(title: "move to done") { _ in }
        let edit = UIAction(title: "edit...") { _ in}
        let delete = UIAction(title: "delete", attributes: .destructive) { _ in }
        let menu = UIMenu(title: "", children: [moveToDone, edit, delete])
        
        return menu
    }
    return configuration
}

```

위 코드는 `UITableViewDelegate` 프로토콜을 적용하면 사용할 수 있는 메소드를 구성한 모습이다. 다행스럽게도 `UITableViewDelegate` 에서 contextMenu에 대한 작업을 수행해주는 메소드가 있어서 각 셀마다 contextMenu를 등록해주지 않고도 각 셀에 대해 contextMenu를 사용할 수 있다.
