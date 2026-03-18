import Foundation

public enum LogicaRemindersCommand: String, Codable, Sendable {
    case list = "reminders.list"
    case add = "reminders.add"
}

public enum LogicaReminderStatusFilter: String, Codable, Sendable {
    case incomplete
    case completed
    case all
}

public struct LogicaRemindersListParams: Codable, Sendable, Equatable {
    public var status: LogicaReminderStatusFilter?
    public var limit: Int?

    public init(status: LogicaReminderStatusFilter? = nil, limit: Int? = nil) {
        self.status = status
        self.limit = limit
    }
}

public struct LogicaRemindersAddParams: Codable, Sendable, Equatable {
    public var title: String
    public var dueISO: String?
    public var notes: String?
    public var listId: String?
    public var listName: String?

    public init(
        title: String,
        dueISO: String? = nil,
        notes: String? = nil,
        listId: String? = nil,
        listName: String? = nil)
    {
        self.title = title
        self.dueISO = dueISO
        self.notes = notes
        self.listId = listId
        self.listName = listName
    }
}

public struct LogicaReminderPayload: Codable, Sendable, Equatable {
    public var identifier: String
    public var title: String
    public var dueISO: String?
    public var completed: Bool
    public var listName: String?

    public init(
        identifier: String,
        title: String,
        dueISO: String? = nil,
        completed: Bool,
        listName: String? = nil)
    {
        self.identifier = identifier
        self.title = title
        self.dueISO = dueISO
        self.completed = completed
        self.listName = listName
    }
}

public struct LogicaRemindersListPayload: Codable, Sendable, Equatable {
    public var reminders: [LogicaReminderPayload]

    public init(reminders: [LogicaReminderPayload]) {
        self.reminders = reminders
    }
}

public struct LogicaRemindersAddPayload: Codable, Sendable, Equatable {
    public var reminder: LogicaReminderPayload

    public init(reminder: LogicaReminderPayload) {
        self.reminder = reminder
    }
}
