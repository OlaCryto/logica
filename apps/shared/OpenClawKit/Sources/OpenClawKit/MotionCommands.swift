import Foundation

public enum LogicaMotionCommand: String, Codable, Sendable {
    case activity = "motion.activity"
    case pedometer = "motion.pedometer"
}

public struct LogicaMotionActivityParams: Codable, Sendable, Equatable {
    public var startISO: String?
    public var endISO: String?
    public var limit: Int?

    public init(startISO: String? = nil, endISO: String? = nil, limit: Int? = nil) {
        self.startISO = startISO
        self.endISO = endISO
        self.limit = limit
    }
}

public struct LogicaMotionActivityEntry: Codable, Sendable, Equatable {
    public var startISO: String
    public var endISO: String
    public var confidence: String
    public var isWalking: Bool
    public var isRunning: Bool
    public var isCycling: Bool
    public var isAutomotive: Bool
    public var isStationary: Bool
    public var isUnknown: Bool

    public init(
        startISO: String,
        endISO: String,
        confidence: String,
        isWalking: Bool,
        isRunning: Bool,
        isCycling: Bool,
        isAutomotive: Bool,
        isStationary: Bool,
        isUnknown: Bool)
    {
        self.startISO = startISO
        self.endISO = endISO
        self.confidence = confidence
        self.isWalking = isWalking
        self.isRunning = isRunning
        self.isCycling = isCycling
        self.isAutomotive = isAutomotive
        self.isStationary = isStationary
        self.isUnknown = isUnknown
    }
}

public struct LogicaMotionActivityPayload: Codable, Sendable, Equatable {
    public var activities: [LogicaMotionActivityEntry]

    public init(activities: [LogicaMotionActivityEntry]) {
        self.activities = activities
    }
}

public struct LogicaPedometerParams: Codable, Sendable, Equatable {
    public var startISO: String?
    public var endISO: String?

    public init(startISO: String? = nil, endISO: String? = nil) {
        self.startISO = startISO
        self.endISO = endISO
    }
}

public struct LogicaPedometerPayload: Codable, Sendable, Equatable {
    public var startISO: String
    public var endISO: String
    public var steps: Int?
    public var distanceMeters: Double?
    public var floorsAscended: Int?
    public var floorsDescended: Int?

    public init(
        startISO: String,
        endISO: String,
        steps: Int?,
        distanceMeters: Double?,
        floorsAscended: Int?,
        floorsDescended: Int?)
    {
        self.startISO = startISO
        self.endISO = endISO
        self.steps = steps
        self.distanceMeters = distanceMeters
        self.floorsAscended = floorsAscended
        self.floorsDescended = floorsDescended
    }
}
