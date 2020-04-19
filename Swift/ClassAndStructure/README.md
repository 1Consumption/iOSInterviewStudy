# structure와 class 의 차이점과 structure mutating

### Class와 Structure의 차이점
1. Class는 다른 Class를 상속할 수 있습니다. 
2. Class는 deinitialize 될 수 있습니다.
3. Class는 Reference Counting 가 있습니다.
4. Class는 Reference Type(참조타입)이고 Structure는 Value Type(값 타입)입니다.
 > Structure는 Stack(메모리 공간)에 값을 저장합니다. 값을 전달할 때 마다 복사본 생성합니다. 반면 Class는 Heap(메모리 공간)에 값을 저장하고 Stack에는 Heap에 저장되어있는 값의 주소를 저장합니다. 그리고 값을 전달할 때는 복사본을 생성하지 않고 주소(reference)만 전달합니다. 
 >
 > **예제 코드**
```swift
struct PositionValue{
  var x = 0
  var y = 0
}
class PositionObject{
  var x = 0
  var y = 0
}

var v = PositionValue()
var o = PositionObject()

var v2 = v // PositionValue(구조체) x = 0, y = 0
var o2 = o // PositionObject(클래스) x = 0, y = 0

// 구조체
v2.x = 12
v2.y = 34
// 값을 바꾸고 나서 값을 확인 
//결과: v.x = 0
//     v.y = 0
//     v2.x = 12
//     v2.y = 34

// 클래스
o2.x = 12
o2.y = 34
// 값을 바꾸고 나서 값을 확인
//결과: o2.x = 12
//     o2.y = 34
//     o2.x = 12
//     o2.y = 34
```

### Struct의 mutating function
```swift
struct Person {
var name: String

mutating func makeAnonymous() {
    name = "Anonymous"
  }
}

var person = Person(name: “Ed”)
person.makeAnonymous()

// 이제 person.name은 Anonymous

```
Structure의 프로퍼티를 바꾸고 싶은 경우 Structure의 프로퍼티를 변경하는 메소드 앞에 mutating이라는 키워드를 붙여야 합니다. 왜냐하면 위 예제 코드에서 person이라는 구조체의 인스턴스는 그 위의 Person이라는 Structure의 값이 이미 복사되어서 만들어졌기 때문입니다. 

하지만 mutating 키워드를 사용하면 Structure의 프로퍼티를 변경할 수 있습니다. 이 메소드가 Structure의 암묵적 self 프로퍼티에 새로운 인스턴스를 할당하고 이 메소드가 끝날 때 이 새로운 인스턴스가 기존의 값을 대체하는 방식으로 값을 바꿉니다.결론적으로 mutating function은 이 메소드가 끝났을 때 위 person.makeAnonymous()처럼 이 메소드로 인해 변경된 값들은 다시 원래 구조체에 반영됩니다. 

> 원문: The method can then mutate (that is, change) its properties from within the method, and any changes that it makes are written back to the original structure when the method ends. The method can also assign a completely new instance to its implicit self property, and this new instance will replace the existing one when the method ends.


### 참고 
https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html
https://learnappmaking.com/struct-vs-class-swift-how-to/
https://blog.usejournal.com/swift-basics-struct-vs-class-31b44ade28ae

