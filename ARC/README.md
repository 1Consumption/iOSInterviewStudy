# ARC

## Strong Reference Cycle은 어떤 경우에 발생하는지 설명하시오.

### Strong Reference Cycle에 대하여
- ARC는 어떤 인스턴스에 대한 레퍼런스 개수를 카운트하며, 카운트가 0이 될때 해당 인스턴스를 메모리에서 해제합니다.
- 하지만, 두 **클래스** 인스턴스가 서로를 강하게 참조하고 있다면, 두 인스턴스들의 강한 참조 카운트가 0이 되지 않을 수 있습니다. 이 경우 각 인스턴스는 서로를 메모리에서 해제되지 않게 유지하며, 이를 strong reference cycle이라고 합니다.
- Reference cycle을 retain cycle이라고도 부릅니다.

### 질문 2 작성

공부하고 정리한 내용을 여기에 추가.


