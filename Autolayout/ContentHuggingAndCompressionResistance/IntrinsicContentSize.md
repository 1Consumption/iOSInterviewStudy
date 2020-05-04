# IntrinsicContentSize

![](https://i.imgur.com/zKzXpDB.png)
[사진 1, 사진 2, 사진 3]

## IntrinsicContentSize & invalidateIntrinsicContentSize()

### intrinsicContentSize 프로퍼티

intrinsic Content Size : 본질적인 컨텐츠 크기

UILabel이나 UIButton 등 대부분의 view들은 intrinsic Content Size(기본적으로 컨텐츠 크기만큼의 사이즈)를 가지고 있습니다. 이런 View들은 intrinsicContentSize를 가지고 있기 때문에 auto layout으로 구현할때 제약사항으로 width와 height를 추가하지 않아도 ***사진 1***처럼 정상적으로 View가 표시됩니다.

**예시 1**

```swift
@IBAction func tapped(_ sender: Any) {
  label.text = "intrinsicContentSize 테스트 중"
}
```

IntrinsicContentSize 버튼을 눌러 UILabel의 text가 변경됐을 때, label의 content size가 변경되어도 ***사진 2***와 같이 auto layout이 제대로 적용되는 이유는 UILabel의 intrinsicContentSize 프로퍼티에서 content size를 계산해주기 때문입니다.

### invalidateIntrinsicContentSize() 메소드 

invalidateIntrinsicContentSize() 메소드는 view의 content size가 바뀌었을때 intrinsicContentSize 프로퍼티를 통해 size를 갱신하고 그에 맞게 auto layout이 업데이트 되도록 해주는 메소드입니다.

apple에서 제공해주는 view는 내부적으로 적용되어 있지만 custom view를 구현할때는 intrinsicContentSize 프로퍼티 invalidateIntrinsicContentSize() 메소드를 구현해야 합니다.


위의 예시(***사진 1,2***)와 같은 상황에서 
```swift
extension UILabel {
  open override func invalidateIntrinsicContentSize() {
//    super.invalidateIntrinsicContentSize()
  }
}
```
코드를 추가하여 UILabel의 invalidateIntrinsicContentSize() 메소드를 비활성화(주석처리한 부분)하면 ***사진 3***과 같이 text 길이에 맞게 view의 size가 늘어나지 않습니다.


**예시2**

[MGStarRatingView](https://github.com/magi82/MGStarRatingView) 라이브러리 사용

![](https://i.imgur.com/qtjSey9.png)
[사진 4, 사진 5]

intrinsicContentSize 프로퍼티가 아래와 같이 구현되어 있을 때
```swift
public override var intrinsicContentSize: CGSize {
  let count = CGFloat(self.max) // 별의 총 개수
  var width = self.point * count // 별을 담는 사각형의 가로폭 * 별의 총 개수
  width = width + CGFloat(count - 1) * self.spacing // 별들의 가로폭 * 별 사이 공백을 포함한 넓이
  return CGSize(width: width, height: self.point)
}
```

런타임에서 view의 크기와 관련된 메소드를 실행 했을시(별의 크기를 바꾸거나 간격을 조절 하는 등) invalidateIntrinsicContentSize() 메소드를 실행 해주지 않는다면 view가 ***사진 4***와 같이 의도대로 표시되지 않을 수 있습니다.


하지만 view의 content size가 바뀔때 invalidateIntrinsicContentSize() 메소드를 실행하면 ***사진 5***와 같이 제대로 적용됩니다.
```swift
public var point: CGFloat = 0 {
  didSet {
    self.currentWidth = getRateToWidth(self.current)
    self.maxWidth = getRateToWidth(CGFloat(self.max))

    invalidateIntrinsicContentSize()
  }
}
```
참고한 자료
[ios-intrinsicContentSize](https://magi82.github.io/ios-intrinsicContentSize/)
