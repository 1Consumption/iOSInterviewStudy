# Notification

notification center 를 통해 등록된 모든 관찰자에게 브로드캐스트되는 정보를 위한 구조입니다.

밑에서 부터 살펴볼건 ```Notification Center```에 관한 메소드 입니다.

<br>

## Posting Notification

1. post(name:object:userInfo:)
```swift 
func post(name aName: NSNotification.Name, 
          object anObject: Any?, 
          userInfo aUserInfo: [AnyHashable : Any]? = nil)
```
- aName : notification의 이름
- object : post 보내는 객체 <- 정확하게 어떻게 사용하는지 모르겠음.
    - 원문 : The object posting the notification.
- userInfo : notification에 담겨져서 보낼 정보 
(userInfo에 보낼값이 없으면 해당 파라미터를 써주지 않아도 된다.)

<br>

## Receive Notification

1. addObserver(forName:object:queue:using:)
```swift
func addObserver(forName name: NSNotification.Name?, 
                 object obj: Any?, 
                 queue: OperationQueue?, 
                 using block: @escaping (Notification) -> Void) -> NSObjectProtocol
```
- name : 해당 관찰자에만 알람을 가게 합니다. nil일 경우 notification center는 알림을 보낸 객체를 사용하여 관찰자에게 전달할지 여부를 결정하지 않습니다.
-> nil로 사용할 경우 특정 Name만 받는게 아니라 알림 전부를 받는다. C의 message queue 느낌을 받았음..!
- object : object에 특정 객체를 명시하면 명시한 객체가 발송한 노티피케이션일 때에만 해당 이름의 노티피케이션을 수신합니다.<sup id="al1">[1](#footnote1)</sup>
- queue : notification 대기열, nil일 경우 block이 동기적으로 수행된다.
- block : 알림을 받았을 때 실행됩니다. block은 notification center에서 복사하고 관찰자 등록이 제거될 때까지 보관합니다.

<br>

2. addObserver
```swift
func addObserver(_ observer: Any, 
                 selector aSelector: Selector, 
                 name aName: NSNotification.Name?, 
                 object anObject: Any?)
```

- observer : 관찰자에 등록되는 객체
- selector : selector는 발신자가 관찰자에게 통지하기 위해 통지 메시지를 지정합니다.  selector에서 지정한 메서드는 인수(NSNotification의 인스턴스)가 하나만 있어야 합니다. 
-> 번역이 좀 이상한데 관찰자가 발신자 알림을 받을때 selector를 지정한다는 말인것 같음.
->``` @objc func test(notification: Notification) { ... } ```
- name : 위 메서드와 동일
- object : 위 메서드와 동일

<br>

### Remove observer

앱이 iOS 9.0 이상 또는 macOS 10.11 이상을 대상으로 하는 경우 dealloc 메소드로 관찰자의 등록을 취소할 필요가 없습니다. 그렇지 않은경우 관찰자 또는 이 메서드에 전달된 개체의 메모리가 해제되기 전에 removeObserver(_:name:object:)를 호출해야 합니다.

<br>

## Publisher

알림을 브로드캐스트할 때 이벤트를 내보내는 publisher<sup id="al2">[2](#footnote2)</sup>를 반환합니다.

```swift 
func publisher(for name: Notification.Name, object: AnyObject? = nil) -> NotificationCenter.Publisher 
```
- 공식문서(article) : https://developer.apple.com/documentation/combine/receiving_and_handling_events_with_combine
- 예제 : https://medium.com/flawless-app-stories/swift-combine-custom-publisher-6d1cc3dc248f

<b id="footnote1">1</b>: 출처 : https://gwangyonglee.tistory.com/31 [↩](#al1)

<b id="footnote2">2</b>: 유형이 시간에 따라 일련의 값을 전송할 수 있는 publisher란 객체를 반환함. [↩](#al2)
