
struct Report { }

struct SMS { }

typealias JSON = [String: Any]

struct ReportParser {
  static func fromJSON(_ json: JSON) throws -> Report {
    return Report()
  }

  static func fromSMS(_ sms: SMS) throws -> Report {
    return Report()
  }
}
