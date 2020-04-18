# 앱이 foreground에 있을 때와 background에 있을 때 어떤 제약사항이 있고, 상태 변화에 따라 다른 동작을 처리하기 위한 델리게이트 메서드들을 설명하시오.

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
