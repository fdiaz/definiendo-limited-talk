
import XCTest
@testable import demo

class demoTests: XCTestCase {
  var smsMock: SMSHandlerMock!
  var apiMock: APIRequesterMock!

  override func setUp() {
    super.setUp()
    smsMock = SMSHandlerMock()
    apiMock = APIRequesterMock()
  }

  override func tearDown() {
    super.tearDown()
    smsMock = nil
    apiMock = nil
  }

  func testReportDataSource_SendsSMS_WhenDisconnected() {
    let connectivityFake = InternetConnectivity(isConnected: false)

    let reportCreator = ReportDataSource(apiRequester: apiMock,
                                         smsHandler: smsMock,
                                         connectivityListener: connectivityFake)

    let _ = try? reportCreator.createReport()

    XCTAssertEqual(smsMock.sendSMSCalled, true)
  }

  func testReportDataSource_SendsAPIRequest_WhenConnected() {
    let connectivityFake = InternetConnectivity(isConnected: true)

    let reportCreator = ReportDataSource(apiRequester: apiMock,
                                         smsHandler: smsMock,
                                         connectivityListener: connectivityFake)

    let _ = try? reportCreator.createReport()

    XCTAssertEqual(apiMock.createReportCalled, true)
  }

}
