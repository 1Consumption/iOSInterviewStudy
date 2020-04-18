# MVC

3가지의 점점 개선되는 MVC 구조로 작성된 [포커게임 앱][pokergameapp] 코드를 분석하고, MVC 구조에 대해 정리하였습니다. 이 샘플 코드에는 참여자 수가 바뀔 때마다 뷰가 바뀌는 동작이 구현되어 있습니다.

## Step1. 흔히 작성하는 MVC 구조

![MVC](MVC.png)

- playerSegment가 변경되면, 선택된 세그먼트 컨트롤의 개수에 따른 플레이어 수를 가진 PokerGame 인스턴스를 생성하고, 플레이어 수에 맞게 뷰를 업데이트합니다.
- 이벤트에 따른 모델 변경 흐름과 모델 변경에 따른 뷰 업데이트 흐름이 구분되어 있지 않고, 함께 이루어집니다.

```swift
// 세그먼트 컨트롤이 바뀔 때마다 호출되는 메서드
private func resetGame() {
    configureGame() // 모델 변경 후
    configureGameView() // 바로 뷰 업데이트
}
```

- 모델이 여러 곳에서 바뀌는 경우, 그 때마다 항상 뷰를 같이 업데이트해줘야 하는 단점이 있습니다.

## Step2. Step1을 개선한 MVC + Observer 구조

![MVC+Observer](MVC+Observer.png)

- 사용자 이벤트에 의해 playerSegment가 변경되면, 모델만 변경합니다.

```swift
@objc func playerChanged(_ sender: UISegmentedControl) {
    configureGame()
}
```

- 모델 변경에 따른 뷰 업데이트 바인딩

```swift
private func configureSubscriber() {
    gamePublisher = NotificationCenter.default
            .publisher(for: PokerGame.Notification.DidChangePlayers)
            .sink { notification in
                DispatchQueue.main.async {
                    self.configureGameView()
                }
            }
}
```

- publisher(for:object:) — Publisher를 반환해줍니다.
- sink — Subscriber를 만들어줍니다. Publisher에 연결되는 것 같고, 클로저를 실행해 주는 것 같습니다..
- 모델이 변경되는 노티피케이션에 따라서 뷰를 업데이트합니다.
- 이벤트에 따른 모델 변경 흐름과, 모델 변경에 따른 뷰 업데이트 흐름이 구분되어 있습니다. 모델을 변경하면 뷰가 알아서 업데이트되기 때문에 중복되는 코드를 줄일 수 있고, 유지보수에 용이합니다.






[pokergameapp]: https://github.com/godrm/swift-pokergameapp/

