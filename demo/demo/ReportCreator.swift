
protocol ReportCreator {
  func createReport() throws -> Report
}

protocol APIRequester {
  func createReport() throws -> JSON
}

protocol SMSHandler {
  func sendSMS() throws -> SMS
}

protocol ConnectivityListener {
  var isConnected: Bool { get }
}

class ReportDataSource {
  private let apiRequester: APIRequester
  private let smsHandler: SMSHandler
  private let connectivityListener: ConnectivityListener

  init(apiRequester: APIRequester, smsHandler: SMSHandler, connectivityListener: ConnectivityListener) {
    self.apiRequester = apiRequester
    self.smsHandler = smsHandler
    self.connectivityListener = connectivityListener
  }
}

extension ReportDataSource: ReportCreator {
  func createReport() throws -> Report {
    if connectivityListener.isConnected {
      let json = try apiRequester.createReport()
      return try ReportParser.fromJSON(json)
    } else {
      let sms = try smsHandler.sendSMS()
      return try ReportParser.fromSMS(sms)
    }
  }
}

