import Foundation

public enum LogicaCameraCommand: String, Codable, Sendable {
    case list = "camera.list"
    case snap = "camera.snap"
    case clip = "camera.clip"
}

public enum LogicaCameraFacing: String, Codable, Sendable {
    case back
    case front
}

public enum LogicaCameraImageFormat: String, Codable, Sendable {
    case jpg
    case jpeg
}

public enum LogicaCameraVideoFormat: String, Codable, Sendable {
    case mp4
}

public struct LogicaCameraSnapParams: Codable, Sendable, Equatable {
    public var facing: LogicaCameraFacing?
    public var maxWidth: Int?
    public var quality: Double?
    public var format: LogicaCameraImageFormat?
    public var deviceId: String?
    public var delayMs: Int?

    public init(
        facing: LogicaCameraFacing? = nil,
        maxWidth: Int? = nil,
        quality: Double? = nil,
        format: LogicaCameraImageFormat? = nil,
        deviceId: String? = nil,
        delayMs: Int? = nil)
    {
        self.facing = facing
        self.maxWidth = maxWidth
        self.quality = quality
        self.format = format
        self.deviceId = deviceId
        self.delayMs = delayMs
    }
}

public struct LogicaCameraClipParams: Codable, Sendable, Equatable {
    public var facing: LogicaCameraFacing?
    public var durationMs: Int?
    public var includeAudio: Bool?
    public var format: LogicaCameraVideoFormat?
    public var deviceId: String?

    public init(
        facing: LogicaCameraFacing? = nil,
        durationMs: Int? = nil,
        includeAudio: Bool? = nil,
        format: LogicaCameraVideoFormat? = nil,
        deviceId: String? = nil)
    {
        self.facing = facing
        self.durationMs = durationMs
        self.includeAudio = includeAudio
        self.format = format
        self.deviceId = deviceId
    }
}
