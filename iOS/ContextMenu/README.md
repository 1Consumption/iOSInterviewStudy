# context menu

iOS 13 이상부터 사용 가능하며 인터페이스를 어지럽히지 않고 현재 화면과 관련된 추가 기능에 접근이 가능하다~

<img src = "https://developer.apple.com/design/human-interface-guidelines/ios/images/context-menu_2x.png" width = "300" >



Peek and Pop과 비슷하지만 두가지 주요 차이점이 있다!

> Peek and Pop?
>
> <img src = "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=http%3A%2F%2Fcfile8.uf.tistory.com%2Fimage%2F99972A395C4D45B035D7F9"  width = "200">

1. peek and pop은 3D Touch를 지원하는 장치에서만 사용이 가능하다
2. context menu는 상황에 맞는 명령을 즉시 표시하지만, peek and pop은 위로 스와이프 해야 명령을 볼 수 있다.

#### 하지만 애플에서는 3D Touch를 더 이상 사용하지 않기 때문에(아이폰 11에도 3D touch를 탑재 하지 않음) 이는 그냥 이런게 있구나~ 정도로만 알자



context menu는 홀드 제스처 또는 3D Touch를 사용하여 도출 가능하다. 이를 사용하여 명령을 선택하거나 item을 다른 영역, window, app으로 드래그할 수 있다.

또한 context menu에는 가장 일반적으로 사용되는 기능을 넣는 것이 좋다. 예를 들어 메일을 보내는 상황에서 회신 및 이동 명령을 포함하는 것은 합리적이지만 사서함 명령을 포함하는 것은 합리적이지 않다. 너무 많은 명령을 나열하면 사용자들에게 혼동을 줄 수 있다.

context menu의 항목에 대해 사용자들에게 이해를 돕기위해 glyph를 포함할 수 있다. SF symbol을 사용하는 것을 권장한다.

하위 메뉴를 사용하여 보다 논리적으로 보조메뉴를 표시할 수 있다. 사용자들은 이를 통해 필요 없는 기능을 탐색하는 것을 피할 수 있다. 또한 depth는 한단계 정도가 적당하며, 자주 사용하는 항목을 상단에 배치해라.

![화면 기록 2020-04-08 오전 4 09 58](https://user-images.githubusercontent.com/37682858/78709703-0fa3ed00-794f-11ea-88b0-237f66a937af.gif)





#### 예시

##### ViewController.swift

```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var VIEW: UIView!
    let dele = delegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let inter = UIContextMenuInteraction(delegate: dele)
        VIEW.addInteraction(inter)
    }
}
```

##### delegate.swift

``` swift
import UIKit

class delegate: NSObject, UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { action in
            return self.makeMenu()
        })
    }
    
    
    func makeMenu() -> UIMenu {
        let add = UIAction(title: "add something", image: UIImage(systemName: "plus")){action in
            // do something
        }
        let delete = UIAction(title: "delete something", image: UIImage(systemName: "minus")){action in
            // do something
        }
        let A = UIAction(title: "do A"){action in
            //do something
        }
        let B = UIAction(title: "do B"){action in
            //do something
        }
        let innerMenu = UIMenu(title: "innerMenu", children: [A,B])
        let menu = UIMenu(title: "menuTitle", children: [add, delete, innerMenu])
        return menu
    }
}
```



##### 메소드 원형

```swift
func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
  <#code#>
}
```

UIContextMenuConfiguration: context menu의 구성 세부 정보가 포함 된 객체



### 이제 이것을 tableView에 적용해보자!

```swift
func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
        let moveToDone = UIAction(title: "move to done") { _ in }
        let edit = UIAction(title: "edit...") { _ in}
        let delete = UIAction(title: "delete", attributes: .destructive) { _ in }
        let menu = UIMenu(title: "", children: [moveToDone, edit, delete])
        
        return menu
    }
    return configuration
}

```

위 코드는 `UITableViewDelegate` 프로토콜을 적용하면 사용할 수 있는 메소드를 구성한 모습이다. 다행스럽게도 `UITableViewDelegate` 에서 contextMenu에 대한 작업을 수행해주는 메소드가 있어서 각 셀마다 contextMenu를 등록해주지 않고도 각 셀에 대해 contextMenu를 사용할 수 있다.