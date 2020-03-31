# ARC

## Strong Reference Cycle은 어떤 경우에 발생하는지 설명하시오.

### Strong Reference Cycle에 대하여
- ARC는 어떤 인스턴스에 대한 레퍼런스 개수를 카운트하며, 카운트가 0이 될때 해당 인스턴스를 메모리에서 해제합니다.
- 하지만, 두 **클래스** 인스턴스가 서로를 강하게 참조하고 있다면, 두 인스턴스들의 강한 참조 카운트가 0이 되지 않을 수 있습니다. 이 경우 각 인스턴스는 서로를 메모리에서 해제되지 않게 유지하며, 이를 strong reference cycle이라고 합니다.
- Reference cycle을 retain cycle이라고도 부릅니다.

### Strong Reference Cycle이 발생하는 예시와 해결 방안

- 예시 1 — 일반적인 경우

```swift
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

let john = Person(name: "John Appleseed")
let unit4A = Apartment(unit: "4A")

// 1
john.apartment = unit4A
unit4A.tenant = john

// 2
john = nil
unit4A = nil
```

1. 이 부분에서 에서 두 인스턴스가 서로를 강하게 참조하게 되기 때문에 강한 참조 사이클이 발생합니다.
2. 이렇게 두 인스턴스를 메모리에서 해제하려고 해도, 두 인스턴스들의 레퍼런스 카운트는 0이 되지 않기 때문에 메모리에서 해제될 수 없습니다. 강한 참조 사이클 때문에 두 인스턴스가 메모리에서 해제되지 않아서 앱의 메모리 릭을 유발합니다.

강한 순환 참조가 일어나는 두 인스턴스들 중 하나를 weak 또는 unowned 레퍼런스로 선언하여 강한 순환 참조를 해결할 수 있습니다.

스위프트 랭귀지 가이드에 따르면, 먼저 메모리에서 해제될 수 있는 인스턴스를 가리키는 참조를 weak으로 선언하라고 합니다. 위 예제의 경우, 거주민이 없는 아파트가 될 수도 있으므로, 다음과 같이 선언합니다.

```swift
weak var tenant: Person?
```

반대로, 인스턴스가 같거나 더 긴 라이프타임을 갖고 있다면 unowned로 선언합니다.



