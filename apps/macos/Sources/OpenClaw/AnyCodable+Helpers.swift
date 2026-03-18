import LogicaKit
import LogicaProtocol
import Foundation

// Prefer the LogicaKit wrapper to keep gateway request payloads consistent.
typealias AnyCodable = LogicaKit.AnyCodable
typealias InstanceIdentity = LogicaKit.InstanceIdentity

extension AnyCodable {
    var stringValue: String? { self.value as? String }
    var boolValue: Bool? { self.value as? Bool }
    var intValue: Int? { self.value as? Int }
    var doubleValue: Double? { self.value as? Double }
    var dictionaryValue: [String: AnyCodable]? { self.value as? [String: AnyCodable] }
    var arrayValue: [AnyCodable]? { self.value as? [AnyCodable] }

    var foundationValue: Any {
        switch self.value {
        case let dict as [String: AnyCodable]:
            dict.mapValues { $0.foundationValue }
        case let array as [AnyCodable]:
            array.map(\.foundationValue)
        default:
            self.value
        }
    }
}

extension LogicaProtocol.AnyCodable {
    var stringValue: String? { self.value as? String }
    var boolValue: Bool? { self.value as? Bool }
    var intValue: Int? { self.value as? Int }
    var doubleValue: Double? { self.value as? Double }
    var dictionaryValue: [String: LogicaProtocol.AnyCodable]? { self.value as? [String: LogicaProtocol.AnyCodable] }
    var arrayValue: [LogicaProtocol.AnyCodable]? { self.value as? [LogicaProtocol.AnyCodable] }

    var foundationValue: Any {
        switch self.value {
        case let dict as [String: LogicaProtocol.AnyCodable]:
            dict.mapValues { $0.foundationValue }
        case let array as [LogicaProtocol.AnyCodable]:
            array.map(\.foundationValue)
        default:
            self.value
        }
    }
}
