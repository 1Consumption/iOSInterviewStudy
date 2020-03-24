# iOS

### Bounds 와 Frame 의 차이점을 설명하시오.

공부하고 정리한 내용을 여기에 추가.

### 실제 디바이스가 없을 경우 개발 환경에서 할 수 있는 것과 없는 것을 설명하시오.

공부하고 정리한 내용을 여기에 추가.

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