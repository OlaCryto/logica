import Foundation

public enum LogicaChatTransportEvent: Sendable {
    case health(ok: Bool)
    case tick
    case chat(LogicaChatEventPayload)
    case agent(LogicaAgentEventPayload)
    case seqGap
}

public protocol LogicaChatTransport: Sendable {
    func requestHistory(sessionKey: String) async throws -> LogicaChatHistoryPayload
    func sendMessage(
        sessionKey: String,
        message: String,
        thinking: String,
        idempotencyKey: String,
        attachments: [LogicaChatAttachmentPayload]) async throws -> LogicaChatSendResponse

    func abortRun(sessionKey: String, runId: String) async throws
    func listSessions(limit: Int?) async throws -> LogicaChatSessionsListResponse

    func requestHealth(timeoutMs: Int) async throws -> Bool
    func events() -> AsyncStream<LogicaChatTransportEvent>

    func setActiveSessionKey(_ sessionKey: String) async throws
}

extension LogicaChatTransport {
    public func setActiveSessionKey(_: String) async throws {}

    public func abortRun(sessionKey _: String, runId _: String) async throws {
        throw NSError(
            domain: "LogicaChatTransport",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: "chat.abort not supported by this transport"])
    }

    public func listSessions(limit _: Int?) async throws -> LogicaChatSessionsListResponse {
        throw NSError(
            domain: "LogicaChatTransport",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: "sessions.list not supported by this transport"])
    }
}
