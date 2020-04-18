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




[pokergameapp]: https://github.com/godrm/swift-pokergameapp/

