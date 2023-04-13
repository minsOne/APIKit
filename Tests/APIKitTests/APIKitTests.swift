import XCTest
@testable import APIKit

final class APIKitTests: XCTestCase {
    func testExample() async {
        let result1 = await HTTPBin.Get().request()
        print(result1)
        
        let result2 = await HTTPBin.Post(parameter: .init(name: "jungmin", age: "35")).request()
        print(result2)
    }
}
