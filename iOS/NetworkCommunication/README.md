# URLSession

## Overview

 [`URLSession`](https://developer.apple.com/documentation/foundation/urlsession)클래스와 관련된 클래스는 제공된 URL에서 데이터를 endpoint로 부터 다운로드 및 endpoint에 업로드하느 API를 제공합니다. 

앱은 하나 이상의 URLSession 인스턴스를 생성하며각 인스턴스는 관련 data-transfer 작업을 조정합니다.`(Your app creates one or more URLSession instances, each of which coordinates a group of related data-transfer tasks.)` 예를 들어 웹브라우저를 만드는 경우, 창당 하나의 세션을 생성하거나 상호작용을 하기 위해(서로 메세지를 보내기 위해) 사용하거나, 백그라운드에서 다운로드를 하기 위해 다른 세션을 생성할 수 있습니다.

URLSession에는 기본 요청에 대한 싱글톤 세션이 있습니다. 당신이 만든 세션처럼 맞춤 설정할 수 없지만 요구 사항이 매우 제한적인 경우 좋은 출발점이됩니다. shared 클래스 메소드를 호출하여 이 세션에 액세스합니다.

URLSession은 다음과 같은 네가지 유형의 task를 제공합니다.

1. dataTask
   * NSData 객체를 사용하여 데이터를 주고 받습니다. 데이터 작업은 서버에 짧은 상호작용(interactive) 요청입니다.
2. uploadTask
   * dataTask와 비슷하지만 데이터(보통은 파일 형식)을 전송하고 앱이 실행되지 않는 동안 백그라운드 업로드를 지원합니다.
3. downloadTask
   * 파일 형식으로 데이터를 꺼내오고 앱이 실행되지 않는 동안 백그라운드 다운로드 및 업로드를 지원합니다.
   * `Download tasks retrieve data in the form of a file, and support background downloads and uploads while the app isn’t running.`
4. websocketTask
   * RFC 6455에 정의 된 WebSocket 프로토콜을 사용하여 TCP 및 TLS를 통해 메시지를 교환합니다.

## dataSession

```swift
func dataTask(with request: URLRequest, 
completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
```

지정된 URL request 객체를 기반으로 URL의 컨텐츠를 받아오고 완료시 핸들러를 호출

* request:  URL, cache policy, request type, body data 또는 body stream 등을 제공하는 URL request 객체
* completionHandler: load request가 완료되었을 때 호출할 핸들러입니다. 이 핸들러는 다음과 같은 세개의 파라미터를 사용합니다.
  * Data?: 서버가 리턴한 data
  * URLResponse?: HTTP 헤더 및 상태 코드와 같은 응답 메타 데이터를 제공하는 객체입니다. HTTP 또는 HTTPS 요청을하는 경우 리턴된 오브젝트는 HTTPURLResponse 오브젝트입니다.
  * Error?: 요청이 실패한 이유를 나타내는 오류 객체 또는 요청이 성공한 경우 nil

### 작업(태스크) 상태 제어

- cancel() : 작업을 취소합니다.
- resume() : 일시중단된 경우 작업을 다시 시작합니다.
- suspend() : 작업을 일시적으로 중단합니다.
- state : 작업의 상태를 나타냅니다.
- priority : 작업처리 우선순위입니다. 0.0부터 1.0 사이입니다.



## 그래서 어떻게 쓰는건데?

```swift
import Foundation

enum HTTPHeaderField: Hashable {
    static let TYPE = "Content-Type"
    static let Authorization = "Authorization"
}

enum HTTPHeaderValue {
    static let JSON = "application/json"
    static var token: String?
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum NetworkErrorCase : Error {
    case InvalidURL
    case NotFound
}


struct NetworkManager: NetworkManable{
    func getResource(from: String, handler: @escaping (Data?, URLResponse?, Error?) -> ()) throws {
        guard let url = URL(string: from) else {
            throw NetworkErrorCase.InvalidURL
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            handler(data, urlResponse, error)
        }
    }
    
    static let endPoint: String = "https://public.codesquad.kr/jk/PokerPlayer.json"
}


protocol NetworkManable {
    func getResource(from: String, handler: @escaping (Data?, URLResponse?, Error?) -> ()) throws
}
```

왜 다음 프로토콜을 사용했을까?

``` swift
protocol NetworkManable {
    func getResource(from: String, handler: @escaping (Data?, Error?) -> ()) throws
}
```



나의 생각: 해당 프로토콜을 채택한 객체는 네트워크 통신을 한다라는 동작을한다 라는 것만 알고있지 어떻게 통신한다는 것은 모릅니다. 따라서 실제 네트워크 통신이 아닌 mock data를 활용한 데이터통신을 가정했을 때, 실제로는 서버에서 데이터를 받아오지 않지만 뷰컨트롤러는 어쨌든 값이 왔기 때문에 서버와 통신이 되었다고 생각하고 데이터를 처리할 것입니다. 

이를 통해 데이터 전송 실패, 상태코드, 성공 등을 다양하게 테스트 해 볼 수 있습니다.

``` swift
struct MockNetworkSuccessStub: NetworkManable {
    func getResource(from: String, handler: @escaping (Data?, URLResponse?, Error?) -> ()) throws {
        let data = "this is mock data".data(using: .utf8)
        handler(data, nil ,nil)
    }
}

struct MockNetworkFailureStub: NetworkManable {
    func getResource(from: String, handler: @escaping (Data?, URLResponse?, Error?) -> ()) throws {
        handler(nil, nil, NetworkErrorCase.NotFound)
    }
}

struct MockNetworkInvalidURLStub: NetworkManable {
    func getResource(from: String, handler: @escaping (Data?, URLResponse?, Error?) -> ()) throws {
        throw NetworkErrorCase.InvalidURL
    }
}
```

