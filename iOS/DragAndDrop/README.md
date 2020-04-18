# Drag and Drop

뷰와 인터렉션 API를 사용하여 앱으로 드래그 앤 드롭합니다.

<br>

## Overview
iOS에서 ```드래그 앤 드롭```을 사용하면 연속적인 제스처를 사용하여 화면상의 한 위치에서 다른 위치로 항목을 끌 수 있습니다. ```드래그 앤 드롭``` 작업이 한 앱에서 수행되거나, 한 앱에서 시작하여 다른 앱에서 끝날 수 있습니다.

<p align="center"><img src="https://docs-assets.developer.apple.com/published/d8a3490e51/5feafe54-90b2-4bd0-9593-3f0ea138df4c.png"></p>

<br>

> **Note**
> 모든 드래그 앤 드롭 기능은 iPad에서 사용할 수 있습니다. iPhone에서는 앱 내에서만 드래그 앤 드롭을 사용할 수 있습니다.

아이템을 드래그 해오는 앱을 ```소스 앱```이라고 합니다. 아이템이 드롭되는 앱을 ```도착지 앱(destination app)```이라고 합니다. 단일 앱에서의 드래그 앤 드롭이 이루어질때 해당 앱은 두 역할을 동시에 수행합니다. 처음부터 끝까지 시스템 매개 동작을 사용하여 완료한 사용자 작업을 드래그 작업이라고합니다. 이와 반대로 드래그 세션은 시스템에서 사용자가 드래그하는 항목을 관리하는 개체입니다.
- 내가 이해한 바.
    - drag activity : 유저가 드래그 앤 드롭을 사용할때 시스템 매개 동작을 사용한 작업 
    - drag session : 유저가 드래그 앤 드롭을 사용할때 시스템에서 관리하는 작업
    
- 원문
:  The complete user action from start to finish—using system-mediated gestures—is called a drag activity. 
A drag session, by contrast, is an object that’s managed by the system and that manages the items the user is dragging.

드래그가 진행 중인 경우 소스 앱 및 대상 앱이 계속 정상적으로 실행되고 사용자 상호 작용을 지원합니다. 사용자는 홈 화면으로 돌아가 Dock을 호출하고 스플릿 뷰에서 두 번째 앱을 열고 다른 드래그 작업을 시작할 수 있습니다.

iOS 드래그앤 드롭은 macOS와 달리 사용자의 여러 손가락을 처리할 수 있는 다중 동시 드래그 앤 드롭 작업을 지원합니다. 사용자가 진행 중인 드래그 세션에 드래그 항목을 순차적으로 추가할 수 있도록 앱을 설계할 수 있으며 도착지 앱에서 여러 개의 동시 드롭을 허용할 수 있습니다.

텍스트 뷰 및 텍스트 필드는 ```드래그앤 드롭```을 자동으로 지원합니다. 콜렉션 뷰 및 테이블 뷰는 뷰 전용 메소드와 프로퍼티를 제공하며, 텍스트 뷰는 뷰의 ```드래그앤 드롭``` 동작을 정의하기 위한 API를 제공합니다. ```드래그 앤 드롭```을 지원하도록 커스텀 뷰를 구성할 수도 있습니다.

> 시스템은 iOS에서 앱 내부에서 드래그 앤 드롭의 모든 보안 측면을 처리합니다. 서명을 코드화하거나 사용 권한을 구성하거나 Info.plist를 설정할 필요가 없습니다.

<br>

## 예제 코드

### ViewController 채택한 프로토콜
```swift
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITableViewDragDelegate, UITableViewDropDelegate {
... }
```

### 프로퍼티
```swift
var leftTableView = UITableView()
var rightTableView = UITableView()
    
var leftItems = (0...20).map{String($0)}
var rightItems = (0...20).map{String($0)}
```

### viewDidLoad()
```swift
override func viewDidLoad() {
    super.viewDidLoad()
        
    leftTableView.dataSource = self
    rightTableView.dataSource = self

    leftTableView.frame = CGRect(x: 0, y: 40, width: 150, height: 400)
    rightTableView.frame = CGRect(x: 150, y: 40, width: 150, height: 400)

    leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    rightTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    view.addSubview(leftTableView)
    view.addSubview(rightTableView)
        
    leftTableView.dragDelegate = self
    leftTableView.dropDelegate = self
    rightTableView.dragDelegate = self
    rightTableView.dropDelegate = self

    leftTableView.dragInteractionEnabled = true
    rightTableView.dragInteractionEnabled = true
}
```

### 테이블 생성
```swift

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == leftTableView {
        return leftItems.count
    } else {
        return rightItems.count
    }
}

    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    if tableView == leftTableView {
        cell.textLabel?.text = leftItems[indexPath.row]
    } else {
        cell.textLabel?.text = rightItems[indexPath.row]
    }

    return cell
}
```

### 드래그 앤 드롭
```swift
func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        // 왼쪽, 오른쪽 테이블 뷰에서 목록 내용 가져오기
        let string = tableView == leftTableView ? leftItems[indexPath.row] : rightItems[indexPath.row]
        // 변환
        guard let data = string.data(using: .utf8) else { return [] }
        // 다른앱이 처리해야할 내용을 알 수 있도록 NSItemProvider를 사용
        // typeIdentifier에 따라 item을 초기화함.
        // kUTTypePlainText : 마크업이 아니고 특정되지 않은 인코딩인 텍스트의 type 식별자.
        let itemProvider = NSItemProvider(item: data as NSData, typeIdentifier: kUTTypePlainText as String)
        //드래그 되는 아이템
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    // 테이블뷰에서 드롭이 될경우 coordinator로 들어감.
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath

        // 비어있는 셀로 드랍했을때는 테이블 끝에서 삽입해 주도록 하는 코드.
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            // 위에서 보내줬던 itemProvider를 읽어서 String 배열로 만듦.
            guard let strings = items as? [String] else { return }

            var indexPaths = [IndexPath]()

            // strings 배열에 담겨진 값들 모두 for문을 돈다.
            for (index, string) in strings.enumerated() {
                // 새로운 행에 대해서 인덱스를 만들고, 삽입한 개수에 따라 아래로 이동해줌
                // 에를 들어 2개를 동시에 옮기면 첫번째는 드롭된 row에다 놓고 두번째는 드롭된 row + 1, 2, 3,,,,,이런식으로
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)

                // 위의 array에 추가.
                if tableView == self.leftTableView {
                    self.leftItems.insert(string, at: indexPath.row)
                    self.rightItems.remove(at: indexPath.row)
                    self.rightTableView.reloadData()
                } else {
                    self.rightItems.insert(string, at: indexPath.row)
                    self.leftItems.remove(at: indexPath.row)
                    self.leftTableView.reloadData()
                }

                // 추가되는 indexPath 저장
                indexPaths.append(indexPath)
            }

            // 이렇게 직접 넣어주게 될 경우 자동적으로 tableview가 업데이트 된다고함.
            // 옵션(with)은 자동선택
            // indexPaths 배열에 들어있는 indexPath 정보로 row가 삽입될거야~~
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
```
