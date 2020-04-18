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
