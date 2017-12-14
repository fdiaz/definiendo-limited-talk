
@testable import demo

class InternetConnectivity: ConnectivityListener {
  let isConnected: Bool

  init(isConnected: Bool) {
    self.isConnected = isConnected
  }
}

class APIRequesterMock: APIRequester {
  var createReportCalled: Bool = false

  func createReport() throws -> JSON {
    createReportCalled = true
    return [:]
  }
}

class SMSHandlerMock: SMSHandler {
  var sendSMSCalled: Bool = false

  func sendSMS() throws -> SMS {
    sendSMSCalled = true
    return SMS()
  }
}
