# Intrinsic content size와 Content hugging 그리고 Compression resistance 

![](https://i.imgur.com/zKzXpDB.png)
[사진 1, 사진 2, 사진 3]
## intrinsicContentSize & invalidateIntrinsicContentSize()
### intrinsicContentSize 프로퍼티

intrinsic Content Size : 본질적인 컨텐츠 크기

UILabel이나 UIButton 등 대부분의 view들은 intrinsic Content Size(기본적으로 컨텐츠 크기만큼의 사이즈)를 가지고 있습니다. 이런 View들은 intrinsicContentSize를 가지고 있기 때문에 auto layout으로 구현할때 제약사항으로 width와 height를 추가하지 않아도 ***사진 1***처럼 오류가 나지 않습니다.

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
코드를 추가하여 UILabel의 invalidateIntrinsicContentSize() 메소드를 비활성화(주석처리)하면 ***사진 3***과 같이 text 길이에 맞게 view의 size가 늘어나지 않습니다.


**예시2**

[MGStarRatingView](https://github.com/magi82/MGStarRatingView) 라이브러리 사용

![](https://i.imgur.com/qtjSey9.png)
[사진 4, 사진 5]

intrinsicContentSize 프로퍼티가 아래와 같이 구현되어 있을 때
```swift
public override var intrinsicContentSize: CGSize {
  let count = CGFloat(self.max) 
  var width = self.point * count 
  width = width + CGFloat(count - 1) * self.spacing 
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

## Content Hugging Priority & Compression resistance
![](https://i.imgur.com/Z0ra5OS.png)

### Content Hugging Priority

![](https://i.imgur.com/Yajwxdd.png)
[Horizontal Hugging Priority (250, 251), (251, 250)]

**: 부모 View의 크기가 늘어나도 View의 고유 사이즈를 지킬 수 있는 우선순위**

**: 해당 View의 영역이 커질 때 어떤 View를 늘릴 것인가에 대한 제약사항**

**Table View Cell 예시** 

 ![](https://i.imgur.com/pDJxzVS.png)

Description의 길이에 따라 Table View Cell의 높이가 동적으로 늘리고 title label의 size는 늘리지 않고 싶을 때 Content Hugging Priority를 사용할 수 있습니다. Cell의 크기가 늘어나도 Cell의 자식 View 중 하나인 title label이 자신의 사이즈를 지키기 위해서는 우선순위를 Description label 레이블보다 높이 설정해야합니다.


두 label의 Content Hugging Priority가 같을 경우 두 label의 Vertical 제약이 충돌하는데, View가 늘어났을 때 어떤 label이 늘어나야 하는지 알 수 없기 때문에 에러 메시지를 띄웁니다. 따라서 Vertical Content Hugging Priority를 조정해야 합니다.

### Compression resistance

![](https://i.imgur.com/ilLkKKo.png)
[Compression Resistance Priority (750, 751), (751, 750)]

**: 외부의 압축에도 View의 고유 사이즈를 지킬 수 있는 우선순위**
**: 해당 View의 영역이 작아질 때 어떤 View를 줄일 것인가에 대한 제약사항**

Content Hugging Priority와 자신의 크기를 지킨다는 점은 같지만 외부 환경 변화가 반대라고 할 수 있습니다. 부모 View가 줄어들 때 자식 View들은 부모 View가 줄어듦에 따라 줄어듭니다. 하지만 다른 View들보다 Content Compression Resistance Priority가 높다면 이 View는 부모 View가 줄어듦에 따라 최소한으로 줄어들 것입니다.(최대한 줄어들지 않을 것입니다.)


**코드를 이용한 지정** 
```swift
titleLabel.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Vertical)
descriptionLabel.setContentHuggingPriority(UILayoutPriorityDefaultLow, forAxis: .Vertical)
```

참고한 자료
[Priority-in-Auto-Layout](https://ehdrjsdlzzzz.github.io/2019/04/14/Priority-in-Auto-Layout/)
[ios-intrinsicContentSize](https://magi82.github.io/ios-intrinsicContentSize/)
[[iOS] Content Hugging & Compression Resistance](http://blog.davepang.com/post/111)