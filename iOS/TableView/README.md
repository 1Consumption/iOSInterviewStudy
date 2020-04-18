# TableView

### 구성 
- Cell: 콘텐츠 표현. UIKit에서 제공하는 기본 셀이나 커스텀 셀 사용 가능. 

- Table view controller: UITableViewController가 아닌 다른 뷰 컨트롤러도 사용할 수 있음. 하지만 일부 테이블 관련 기능이 작동하려면 테이블 뷰 컨트롤러가 필요하다. 
-> 일부 동작의 예: 선택 관리(selection management), 열(row) 수정, 테이블 설정(configure) 등의 동작

- Data source: UITableViewDataSource 프로토콜 채택. 테이블을 위한 데이터 제공

- Delegate: UITableViewDelegate 프로토콜 채택. 테이블의 콘텐츠와 사용자와의 상호작용(user interactions) 관리

## 데이터로 테이블 채우기

#### 행과 섹션의 수를 제공하는 UITableViewDataSource
화면에 나타나기 전에 테이블 뷰는 행과 단면의 총 수를 지정하도록 요청한다. 

```swift
func numberOfSections(in tableView: UITableView) -> Int  // Optional 
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```
* data source 객체는 테이블로부터 온 데이터 관련 요청에 응답한다.
* 테이블의 데이터를 직접 관리하거나 앱의 다른 부분과 조정하여 해당 데이터를 관리한다. 
* 테이블의 행(row)과 섹션(section) 수를 보고한다.
* 테이블의 각 행에 들어갈 셀을 제공한다.
* 섹션의 헤더와 푸터의 타이틀을 제공한다.
* 테이블의 인덱스를 설정한다.

테이블 뷰는 NSIndexPath 객체의 행 및 섹션 프로퍼티를 사용하여 셀 위치를 사용자에게 전달한다.
행과 섹션 인덱스는 0부터 시작하고 행을 고유하게 식별하기 위해 섹션 및 행 값이 모두 필요하다.

#### 행의 모양을 정의하는 UITableViewCell
* 테이블 행의 탬플릿같은 역할을 하는 객체
* UITableViewCell 상속
* Cell은 뷰로, 다른 서브뷰를 포함할 수 있다. (label, image view 등)
* UIKit에서 제공하는 표준 스타일 중에 하나를 선택할 수도 있고 커스텀 스타일을 정의해도 된다.

** UIKit에서 제공하는 표준 스타일 **

![](https://i.imgur.com/H3bEeEe.png)
 UITableCell이 콘텐츠를 보여주는 뷰를 제공. textLabel,detailTextLabel,imageView
만약에 채워넣지 않으면 다른 빈 공간으로 보여진다.

** 코드 구현 **
![](https://i.imgur.com/taR0Hwl.png)

- Default
![](https://i.imgur.com/kXJvkYt.png)

- Value1
![](https://i.imgur.com/XCh0Gb1.png)

- Value2
![](https://i.imgur.com/uB7X9kX.png)

- Submit
![](https://i.imgur.com/fiKlywB.png)

(사진 출처:[Coding Magic](http://coding-is-kind-of-magic.blogspot.com/2012/02/uitableview-has-some-build-in-styles.html))


#### 퍼포먼스 향상을 위한 UITableViewDataSourcePrefetching
* UITableView와 UICollectionView에서 사용할 수 있는 프로토콜이다.
*  
```swift
tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath])
````
이 델리게이트 함수는 행이 디스플레이 영역에 다다랐을 때 호출될 것이며 이 곳에서 만약 API로 데이터를 받아오고 있다면 API를 호출하여 데이터를 받아올 수 있다.

![](https://i.imgur.com/lnZj1Hy.png)
출처([군옥수수 블로그](https://ehdrjsdlzzzz.github.io/2018/09/19/Smoothen-your-table-view-data-loading-using-UITableViewDataSource-Prefetching/))

* ```swift tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath])``` 함수는 스크롤을 하지 않는 이상 화면에 보여지지 않는 행을 불러오지 않는다.
* 초기 보여질 수 있는 행이 보여지면 ```tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath])```가 호출된다. indexPath 변수는 약 10개의 보여질 수 있는 영역 근처의 행들을 포함하게 된다.
* 스크롤 속도에 따라 prefetch 함수의 indexPath 변수가 포함하게 되는 행의 갯수는 달라진다. 보통의 스크롤 속도에는 보통 1개의 행을 포함한다. 만일 빠른 속도로 스크롤하게 되면 다수의 행을 포함하게 된다.

참고
[Filling a Table with Data](https://hackmd.io/ZSRD90WwT1e1za6HhnQLvg)

[UITableViewDataSource](https://hackmd.io/ZSRD90WwT1e1za6HhnQLvg)

[UITableViewController](https://developer.apple.com/documentation/uikit/uitableviewcontroller) 
