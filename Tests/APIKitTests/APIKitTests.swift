import XCTest
@testable import APIKit

final class APIKitTests: XCTestCase {
    func testExample() async {
        let result1 = await HTTPBin.Get().request()
        print(result1)
        
        let result2 = await HTTPBin.Post(parameter: .init(name: "jungmin", age: "35")).request()
        print(result2)
    }

    func testURLInfo() {
        let info = API.URLInfo(host: "httpbin.org", port: 80, path: "/get", query: ["hello":"world"])
        let url = info.url.absoluteString
        print(url)
        XCTAssertEqual(url,
                       "https://httpbin.org:80/get?hello=world")
    }
    
    func testStubAPI() async {
        do {
            let result = await withCheckedContinuation { continuation in
                let errorService = ErrorSessionDataTaskService1()
                _ = StubAPI.Get()._request(service: URLSessionService(errorService),
                                           completion: {
                    continuation.resume(returning: $0)
                })
            }
            print(result)
            XCTAssertNil(try? result.get())
        }

        do {
            let result = await withCheckedContinuation { continuation in
                let errorService = ErrorSessionDataTaskService2()
                _ = StubAPI.Get()._request(service: URLSessionService(errorService),
                                           completion: {
                    continuation.resume(returning: $0)
                })
            }
            print(result)
            XCTAssertNil(try? result.get())
        }

        do {
            let result = await withCheckedContinuation { continuation in
                let errorService = ErrorSessionDataTaskService3()
                _ = StubAPI.Get()._request(service: URLSessionService(errorService),
                                           completion: {
                    continuation.resume(returning: $0)
                })
            }
            print(result)
            XCTAssertNil(try? result.get())
        }

        do {
            let result = await withCheckedContinuation { continuation in
                let errorService = ErrorSessionDataTaskService4()
                _ = StubAPI.Get()._request(service: URLSessionService(errorService),
                                           completion: {
                    continuation.resume(returning: $0)
                })
            }
            print(result)
            XCTAssertNil(try? result.get())
        }
    }
}
