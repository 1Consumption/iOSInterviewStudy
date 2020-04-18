
## Container ViewController

- View Controller는 한 화면에서 처리할 책임이 너무 많을 때가 있는데, 이는 SRP(Single Responsibility Principle)를 위반해 모듈 간 긴밀하게 결합하고, 각 부품의 재사용과 테스트가 어려워지게 한다.
- 메모리적인 이점은 없지만, 하나의 View Controller에서의 역할을 Container View Controller로 분담하면 재사용성을 높일 수 있고 디자인 패턴을 사용하는데 용이하다. [Movie List 예시](https://www.appcoda.com/container-view-controller/)
- 각 Child는 자신의 보기 계층을 계속 관리하지만  Container ViewController는 해당 Child의 root view의 위치와 크기(position and size)를 관리한다.
  ![](https://i.imgur.com/hTlYAAP.png)

### Programmatically

- 컨테이너 뷰 컨트롤러가 하위 뷰 컨트롤러를 동적으로 변경하면 해당 하위 항목을 프로그래밍 방식으로 추가하는 것이 더 쉽다.

```swift
// 스토리보드에 viewController를 생성했을 경우
//child ViewController 생성 

let storyboard = UIStoryboard(name: "Main", bundle: .main)
if let firstChildVC = storyboard.instantiateViewController(identifier: "firstChildVC")
                                    as? FirstChildVC {
   // container에 view controller 추가
   addChild(firstChildVC) // containment relationship 추가
   view.addSubview(firstChildVC.view) // container의 view 계층에 child의 root view 추가
            
   // child view의 size와 position을 설정하는 constraints 추가
   onscreenConstraints = configureConstraintsForContainedView(containedView: firstChildVC.view,
                             stage: .onscreen)
   NSLayoutConstraint.activate(onscreenConstraints)
     
   // controller의 전환(transition)이 완료됐음을 알림    
   viewController.didMove(toParent: self)
}

// 또 다른 방법 - 스토리보드에 viewController를 생성하지 않았을 경우
    let secondChildVC = SecondChildVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSecondChildVC()
    }
    
    func addSecondChildVC() {
        addChild(secondChildVC)
        view.addSubview(secondChildVC.view)
        secondChildVC.didMove(toParent: self)
        setSecondChildVCConstraints()
    }
        
    func setSecondChildVCConstraints() {
        secondChildVC.view.translatesAutoresizingMaskIntoConstraints = false
        secondChildVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        secondChildVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        secondChildVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        secondChildVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400).isActive = true
    }
}
```


### Using Storyboard

<img src="https://i.imgur.com/hYZNnJY.png{width: 300}" style="zoom:50%;" />
<img src="https://i.imgur.com/IGk4Cdc.png" style="zoom:70%;" />

```swift
// Container View가 속해있는 ViewController 
class ViewController: UIViewController {

    enum Segues {
        static let toFirstChild = "ToFirstChild"
    }
    
// 만약 스토리보드로 추가한 Container View가 여러 개일 경우 필요
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toFirstChild {
            let destVC = segue.destination as! FirstChildVC
        }
    }
}    
    
```

### ViewController와 Container View Controller의 관계

1. 일반적으로 새로 생성된 ViewController는 Container ViewController와 다르다. 그것은 독립적인 ViewController이다. Segue를 임베드하면 원래 ViewController에서 어느 ViewController를 표시할지 정확하게 지정하게 된다. 그러나 Container ViewController는 여전히 이전 ViewController의 일부분이고 표시할 다른 ViewController의 View만 표시하는 역할을 한다.
2. Container ViewController를 포함하고 있는 ViewController는 Container View에 표시되는 다른 ViewController의 View를 선택하는 책임을 갖고있다. 

### 참고 자료

* [Creating a Custom Container View Controller](https://developer.apple.com/documentation/uikit/view_controllers/creating_a_custom_container_view_controller)
