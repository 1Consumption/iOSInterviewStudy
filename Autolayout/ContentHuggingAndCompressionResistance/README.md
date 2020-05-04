# Content hugging과 Compression resistance 

![](https://i.imgur.com/zKzXpDB.png)
[사진 1, 사진 2, 사진 3]

## Content Hugging & Compression resistance
![](https://i.imgur.com/Z0ra5OS.png)

### Content Hugging Priority

![](https://i.imgur.com/Yajwxdd.png)
[Horizontal Hugging Priority (250, 251), (251, 250)]

**: 부모 View의 크기가 늘어나도 View의 고유 사이즈를 지킬 수 있는 우선순위**

**: 해당 View의 영역이 커질 때 어떤 View를 늘릴 것인가에 대한 제약사항**

**Table View Cell 예시** 

 ![](https://i.imgur.com/pDJxzVS.png)

Description의 길이에 따라 Table View Cell의 높이가 동적으로 늘리고 title label의 size는 늘리지 않고 싶을 때 Content Hugging Priority를 사용할 수 있습니다. Cell의 크기가 늘어나도 Cell의 자식 View 중 하나인 title label이 자신의 사이즈를 지키기 위해서는 우선순위를 Description label 보다 높이 설정해야합니다.


두 label의 Content Hugging Priority가 같을 경우 두 label의 Vertical 제약이 충돌하는데, View가 늘어났을 때 어떤 label이 늘어나야 하는지 알 수 없기 때문에 에러 메시지를 띄웁니다. 따라서 Vertical Content Hugging Priority를 조정해야 합니다.

### Compression resistance

![](https://i.imgur.com/ilLkKKo.png)
[Compression Resistance Priority (750, 751), (751, 750)]

**: 외부의 압축에도 View의 고유 사이즈를 지킬 수 있는 우선순위**

**: 해당 View의 영역이 작아질 때 어떤 View를 줄일 것인가에 대한 제약사항**

부모 View가 줄어들 때 자식 View들은 부모 View가 줄어듦에 따라 줄어드는데, 다른 View들보다 Content Compression Resistance Priority를 높이 설정한다면 이 View는 부모 View가 줄어듦에 따라 최소한으로 줄어듭니다(최대한 줄어들지 않습니다.)


**코드를 이용한 지정** 
```swift
titleLabel.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Vertical)
descriptionLabel.setContentHuggingPriority(UILayoutPriorityDefaultLow, forAxis: .Vertical)
// UILayoutPriorityDefaultLow: 단추가 내용을 가로로 고정하는 우선 순위 수준.
```
메소드 원형
```
func setContentHuggingPriority(_ priority: UILayoutPriority, 
for axis: NSLayoutConstraint.Axis)
```

참고한 자료
[setContentHuggingPriority(_:for:)](https://developer.apple.com/documentation/uikit/uiview/1622485-setcontenthuggingpriority)
[Priority-in-Auto-Layout](https://ehdrjsdlzzzz.github.io/2019/04/14/Priority-in-Auto-Layout/)
[[iOS] Content Hugging & Compression Resistance](http://blog.davepang.com/post/111)
