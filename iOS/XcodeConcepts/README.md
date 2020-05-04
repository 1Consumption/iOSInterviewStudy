# Xcode Concepts

## Xcode Target
**```target```은 빌드할 product를 지정하고 프로젝트 또는 workspace의 파일 집합에서 제품을 빌드하는 명령을 포함합니다. 
```target```은 단일 product을 정의하고 빌드 시스템에 대한 입력, 즉 해당 product를 빌드하는 데 필요한 소스 파일 및 해당 소스 파일 처리 지침을 구성합니다. 
프로젝트에는 하나 이상의 ```target```이 포함될 수 있으며 각 대상이 하나의 product을 생성합니다.**

=> target 하나에 product 하나라고 보면 될것같다.
=> 프로젝트 하나에 여러개의 target이 포함 될 수 있다.

<br>

<img width="100%" src="https://i.imgur.com/3Tf4J33.png"></img>
여기 예시처럼 Target의 product가 앱이 될 수도있고 Framework가 될 수도 있고 Unit Test일 수도 있다. (캡쳐 사진에는 나와있진 않지만)

<br>

**제품 빌드 instruction(명령)은 Xcode 프로젝트 에디터에서 검토하고 편집할 수 있는 build settings 및 build settings의 형태를 띱니다.**

<img width="100%" src="https://i.imgur.com/mvRS2NT.png"></img>
=> 위에서 말했던 제품을 빌드하는 명령(instruction)이 이것을 말하는 것!

<br>

**```target```은 프로젝트 build setting을 상속하지만 target level에서 다른 설정을 지정하여 프로젝트 설정을 override할 수 있습니다.**

<img width="100%" src="https://i.imgur.com/ZAz1RUM.png"></img>
=> 오 여기서 설정을 변경해서 사용할 수 있나봄.

**active ```target```은 한 번에 하나만 있을 수 있으며, Xcode scheme는 active ```target```을 지정합니다.**

**target과 target이 생성하는 product가 다른 target과 연관될 수 있습니다. 만약 target을 빌드하기 위해 다른 target의 output이 필요한 경우 첫 번째 target은 두 번째 target을 의존한다고 이야기 합니다.**
=> A타겟이 빌드하기 위해 B타겟의 산출물을 필요로 하는 경우, A타겟은 B타겟에 의존한다고 이야기 한다고 함.

**두 대상이 동일한 workspace에 있는 경우 Xcode는 의존성을 찾아 볼 수 있으며, 이 경우 필요한 순서대로 product를 빌드합니다.
이러한 관계를 '암시적 의존'이라고 합니다.**
=> Xcode가 알아서 순서대로 빌드 해줌.

**또한 build settings에서 명시적 대상 의존성을 지정할 수 있으며, Xcode에 암시적 의존성이 있을 것으로 예상되는 두 대상이 실제로 종속되지 않도록 지정할 수 있습니다.**
=> 암묵적으로 말고 의존성을 지정해줌으로써 명시적으로 나타내게 할 수도 있다.

**예를 들어, 동일한 workspace에서 해당 라이브러리에 대해 연결하는 라이브러리와 앱을 모두 빌드할 수 있습니다.**
=> A라이브러리와 링크되어 있는 B라이브러리와, A라이브러리에 링크되어 있는 앱 모두 빌드가 가능하다.

**Xcode는 이 관계를 찾아보고 라이브러리를 먼저 자동으로 빌드할 수 있습니다.**
=> Xcode가 A라이브러리를 자동으로 먼저 빌드함.

**그러나 실제로 workspace에 빌드된 라이브러리가 아닌 다른 라이브러리의 버전에 대해 연결하려는 경우 build settings에 명시적 의존성을 만들 수 있으며, 이는 이 암시적 의존성을 override합니다.**

<br>

## Scheme
Xcode scheme는 빌드할 target의 모음, 빌드할 때 사용할 configuration(구성) 및 실행할 테스트 컬렉션을 정의합니다.

원하는 만큼 scheme를 가질 수 있지만 한 번에 하나의 scheme만 활성화할 수 있습니다.
scheme를 프로젝트에 저장할지(이 경우 해당 프로젝트를 포함하는 모든 workspace에서 사용할 수 있는지 또는  해당 workspace에서만 사용할 수 있는지) 지정할 수 있습니다. 
active scheme를 선택할 때 실행 대상(제품이 빌드되는 하드웨어의 아키텍처)도 선택합니다.

<img width="100%" src="https://i.imgur.com/meA8akS.png"></img>


<br>

## Build Settings
**build settings은 제품의 build process의 특정 측면을 수행하는 방법에 대한 정보를 포함하는 변수입니다. 예를 들어 build settings의 정보는 Xcode가 컴파일러에 전달할 옵션을 지정할 수 있습니다.**
=> 빌드 세팅은 빌드 프로세스를 어떻게 수행할 것인지도 포함되어 있음.

**프로젝트 또는 target level에서 build settings를 지정할 수 있습니다. 각 프로젝트-level의 build setting은 특정 대상에 대한 build settings에 의해 명시적으로 재정의되지 않는 한 프로젝트의 모든 대상에 적용됩니다.**

<br>

각 target은 하나의 제품을 만드는 데 필요한 소스 파일을 구성합니다. 
빌드 구성은 특정 방법으로 대상의 제품을 빌드하는 데 사용되는 빌드 설정 집합을 지정합니다. 
예를 들어 제품의 디버그 및 릴리스 빌드를 위한 별도의 빌드 구성이 있는 것이 일반적입니다.

**Xcode의 build settings에는 setting title과 definition의 두 부분이 있습니다. build setting title은 build setting을 식별하며 다른 설정에서 사용할 수 있습니다.**
=> 제드 블로그에서는 왼쪽이 title, 오른쪽이 definition이라고 추측을 했음.. 맞는거 같은데?

build setting definition는 Xcode가 빌드 시 빌드 설정 값을 결정하는 데 사용하는 상수 또는 공식(formula)입니다. build setting에는 Xcode 사용자 인터페이스에서 build setting을 표시하는 데 사용되는 display name이 있을 수도 있습니다.

프로젝트 템플릿에서 새 프로젝트를 생성할 때 Xcode에서 제공하는 기본 build setting 외에도 프로젝트 또는 특정 대상에 대한 사용자 정의 build setting을 생성할 수 있습니다.

조건부 build setting을 지정할 수도 있습니다. 조건부 build setting 값은 하나 이상의 필수 구성 요소(선행되어야 하는 요소)가 충족되는지 여부에 따라 달라집니다. 

예를 들어 이 메커니즘을 사용하면 대상 아키텍처를 기반으로 제품을 구축하는 데 사용할 SDK를 지정할 수 있습니다.

<br>

## Xcode Workspace

workspace은 프로젝트 및 기타 문서를 그룹화하여 함께 작업할 수 있도록 하는 Xcode 문서입니다. 
workspace에는 Xcode 프로젝트와 포함시키고 싶은 다른 파일을 모두 포함할 수 있습니다.
workspace는 각 Xcode 프로젝트의 모든 파일을 구성할 뿐만 아니라 포함된 프로젝트와 해당 대상 간에 암시적이고 명시적인 관계를 제공합니다.

### Workspaces Extend the Scope of Your Workflow - Workspace는 Workflow의 범위를 확장시킵니다.

**프로젝트 파일에는 빌드 구성 및 기타 프로젝트 정보와 함께 프로젝트의 모든 파일에 대한 포인터가 포함되어 있습니다.**
=> 내가 아는 포인터인가? 주소를 가지고 있는다는 뜻으로 해석함.

**Xcode 3 혹은 이전 버전에서 프로젝트 파일은 항상 그룹과 파일 구조 계층의 root입니다.**
=> 그룹 / 파일 구조 계층에서 최상위가 project file이다.

**프로젝트에는 다른 프로젝트에 대한 참조가 포함될 수 있지만 Xcode 3의 상호 관련 프로젝트 작업은 복잡하게 되어있습니다. 대부분의 workflow는 단일 프로젝트에 국한됩니다.**
=> Xcode3, 혹은 이전버전은 이러한 참조가 되는 프로젝트들이 있으면 복잡하게 이루어진다는 것 같음. (Xcode 자체적으로)

Xcode 4 이상에서는 하나 이상의 프로젝트와 포함시킬 다른 파일들을 저장할 워크스페이스를 생성할 수 있습니다.

workspace는 포함된 각 Xcode 프로젝트의 모든 파일에 액세스할 수 있을 뿐만 아니라 중요한 많은 Xcode workflow의 범위를 확장합니다.

**예1)** 인덱싱은 전체 작업 공간에서 수행되므로 code completion, Jump to Definition 및 기타 모든 컨텐츠 인식 기능은 workspace의 모든 프로젝트에서 원활하게 작동합니다.

**예2)** refactoring 작업은 workspace의 모든 컨텐츠에 걸쳐 수행되므로 프레임워크 프로젝트와 해당 프레임워크를 모두 사용하는 여러 애플리케이션 프로젝트에서 API를 refactoring할 수 있습니다. 
빌드할 때, 프로젝트는 작업 공간에서 다른 프로젝트의 product를 사용할 수 있습니다.

workspace 문서에는 포함된 프로젝트 및 기타 파일에 대한 포인터가 있지만 다른 데이터는 없습니다. 
프로젝트는 둘 이상의 workspace에 속할 수 있습니다. 
그림에는 두 개의 Xcode 프로젝트(Sketch 및 TextEdit)와 설명서 프로젝트(Xcode4)가 포함된 작업 공간이 나와 있습니다.

<p align="center"><img src="https://developer.apple.com/library/archive/featuredarticles/XcodeConcepts/art/workspace_hierarchy.jpg"></p>

<br>

### Projects in a Workspace Share a Build Directory - Workspace의 프로젝트 빌드 디렉터리를 공유합니다.

기본적으로 workspace의 모든 Xcode 프로젝트는 workspace 빌드 디렉토리라고 하는 동일한 디렉토리에 구축됩니다. 
각 workspace에는 고유한 빌드 디렉터리가 있습니다. 
workspace의 모든 프로젝트에 있는 모든 파일이 동일한 빌드 디렉토리에 있기 때문에 이러한 모든 파일이 각 프로젝트에 표시됩니다. 
**따라서 둘 이상의 프로젝트가 동일한 라이브러리를 사용하는 경우 각 프로젝트 폴더에 별도로 복사할 필요가 없습니다.**
=> 저 위에 사진처럼 Sketch, TextEdit 2개의 프로젝트가 동일한 라이브러리를 사용할 경우에는 각각의 프로젝트마다 동일한 라이브러리를 넣어줄 필요가 없다는 의미.

Xcode는 빌드 디렉토리의 파일을 검사하여 암시적 의존성을 검색합니다. 
예를 들어 workspace에 포함된 프로젝트 중 하나가 동일한 workspace의 다른 프로젝트에 의해 연결된 라이브러리를 사용하는 경우, 이 의존성이 명시되지 않더라도 build configuration으로 인해 Xcode는 다른 프로젝트를 빌드하기 전에 라이브러리를 자동으로 빌드합니다.

**필요한 경우 이러한 암시적 의존성을 명시적 build settings으로 override할 수 있습니다. 명시적 의존성의 경우 프로젝트 참조를 작성해야 합니다.**
=> 프로젝트 참조..? (For explicit dependencies, you must create project references.)

**workspace의 각 프로젝트는 고유한 ID를 가지고 있습니다. workspace의 다른 프로젝트에 영향을 미치거나 영향을 받지 않고 프로젝트 작업을 수행하려면 workspace를 열지 않고 프로젝트를 열거나 다른 workspace에 프로젝트를 추가할 수 있습니다.**
=> workspace에서 프로젝트 작업을 하면 의존성이 있는 다른 프로젝트에 영향이 가므로 workspace 이외에 따로 열어서 작업해야 한다는 것 같음.

프로젝트가 둘 이상의 workspace에 속할 수 있으므로 프로젝트 또는 workspace를 재구성하지 않고도 원하는 조합으로 프로젝트를 작업할 수 있습니다.

workspace의 기본 빌드 디렉토리를 사용하거나 지정할 수 있습니다. 
프로젝트가 빌드 디렉터리를 지정하는 경우, 프로젝트를 빌드할 때 프로젝트가 있는 workspace의 빌드 디렉터리에 의해 override됩니다.

