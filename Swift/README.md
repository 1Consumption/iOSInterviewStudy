# Swift

# Swift Standard Library의 map, filter, reduce, compactMap, flatMap에 대하여 설명하시오.

# map(_:)

sequence의 요소에 주어진 closure를 매핑한 결과가 포함된 배열을 반환합니다.

```swift
func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
```

``` swift
let a = [1, 2, 3, 4, 5, 6, 7]

let b = a.map{"integer : " + String($0)}
//["integer : 1", "integer : 2", "integer : 3", "integer : 4", "integer : 5", "integer : 6", "integer : 7"]
```



# filter(_:)

주어진 속성을 만족시키는 sequence의 요소를 순서대로(원래 배열의) 포함하는 배열을 반환합니다.

```swift
func filter(_ isIncluded: (Self.Element) throws -> Bool) rethrows -> [Self.Element]
```

``` swift
let a = [1, 2, 3, 4, 5, 6, 7]

let b = a.filter{$0 >= 5}
// [5, 6, 7]
```

# reduce(_:_:)

주어진 클로저를 사용하여 sequence의 요소를 결합한 결과를 반환합니다.

```swift
func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result
```

```swift
func reduce<Result>(into initialResult: Result, _ updateAccumulatingResult: (inout Result, Element) throws -> ()) rethrows -> Result
```

> 레이블이 into인 reduce 메소드는 단일 결과값이 아닐 때 사용하면 효율적입니다.

```swift
let a = [1, 1, 1, 2, 2, 3, 4, 4, 4, 4, 5, 6, 7]

let b = a.reduce(0, +)
// 44

let c = a.reduce(into: [Int : Int]()) {
    let value = $1
    $0[value] = a.filter{$0 == value}.count
}
// [2: 2, 3: 1, 7: 1, 5: 1, 6: 1, 1: 3, 4: 4]
```

# flatMap(_:)

각 sequence의 요소를 사용하여 지정된 변환을 호출한 결과를 포함하는 배열을 반환합니다.

```swift
func flatMap<SegmentOfResult>(_ transform: (Element) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element] where SegmentOfResult : Sequence
```

``` swift
let a = [[1, nil, 2], [3, 4, nil], [5, 6, 7], [nil, nil, 9]]

let b = a.flatMap{$0}
// [Optional(1), nil, Optional(2), Optional(3), Optional(4), nil, Optional(5), Optional(6), Optional(7), nil, nil, Optional(9)]

let c = b.compactMap{$0}.filter{$0 > 4}
// [5, 6, 7, 9]
```

# compactMap(_:)

sequence의 각 요소를 사용하여 지정된 변환을 호출한 not nil인 결과를 포함하는 배열을 반환합니다.

```swift
func compactMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult]
```

```swift
let a = [1, 2, 3, nil, 4, nil, 5, 6, nil, 7]

a.compactMap{$0}
// [1, 2, 3, 4, 5, 6, 7]
```

# Extension에 대해 설명하시오.

### Extension 기능 설명

- Extension을 이용하여 이미 존재하는 클래스, 구조체, 열거형, 프로토콜 타입에 새 기능을 추가할 수 있습니다.

    ```swift
    extension SomeType {
        // SomeType에 새로운 기능을 추가한다.
    }
    ```

- 원본 소스 코드에 접근할 수 없는 경우에도 extension을 추가할 수 있습니다.
- 연산 프로퍼티, 메서드, 이니셜라이저, subscript, nested type을 추가할 수 있습니다.
- 클래스에 convenience initializer는 추가할 수 있지만, designated initializer 또는 deinitializer는 추가할 수 없습니다.
- 이미 존재하는 타입을 새 프로토콜을 준수하도록 할 수 있습니다.

    ```swift
    extension SomeType: SomeProtocol, AnotherProtocol {
        // 프로토콜을 준수하기 위한 구현을 한다.
    }
    ```

- 이미 존재하는 기능을 override할 수는 없습니다.
- 저장 프로퍼티는 추가할 수 없고, 이미 존재하는 프로퍼티에 프로퍼티 옵저버를 추가할 수도 없습니다.

### Protocol Extension

스위프트에서는 프로토콜을 확장하여 구현체를 제공하거나, 이 프로토콜을 준수하는 타입들에게 추가적인 기능을 더하는 식으로 사용할 수 있다.

```swift
protocol RandomNumberGenerator { ... }

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
```

이제 RandomNumberGenerator를 채택한 타입들은 randomBool()을 사용할 수 있다.

### 구조체 이니셜라이저 Extension

구조체 이니셜라이저를 extension에서 구현하면, extension 안에서 initializer delegation을 사용하여 default memberwise initializer를 호출할 수 있습니다.

```swift
struct User {
    let name: String
    let title: String
}

let user = User(name: "하이디", title: "짱")
```

위 코드처럼, 구조체에 생성자를 구현하지 않으면 기본적으로 default memberwise initializer가 제공됩니다.

```swift
struct User2 {
    let name: String
    let title: String
    
    init() {
        name = "하이디"
        title = "zzang"
    }
}

let user2 = User2()
// let user22 = User2(name: "하이디", title: "짱") // 불가능
```

구조체에 커스텀 생성자를 추가하면, 자동 생성되는 멤버와이즈 이니셜라이저는 사용할 수 없게 됩니다. 이니셜라이저 위임(initializer delegation)을 통해서도 멤버와이즈 이니셜라이저를 호출할 수 없습니다.

```swift
struct User3 {
    let name: String
    let title: String
}

extension User3 {
    init() {
        name = "하이디"
        title = "zzang"
    }
    
    init(with number: Int) {
        self.init(name: "하이디", title: "\(number)")
    }
}

let user3 = User3()
let user333 = User3(with: 5)
let user33 = User3(name: "", title: "")
```

Extension을 사용하여 생성자를 추가하면, 구조체의 멤버와이즈 이니셜라이저를 그대로 사용할 수 있게 됩니다. 이니셜라이저 위임(initializer delegation)을 통해서도 멤버와이즈 이니셜라이저를 호출할 수 있습니다.
