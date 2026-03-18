import Foundation
import Testing
@testable import Logica

@Suite struct GatewayLaunchAgentManagerTests {
    @Test func launchAgentPlistSnapshotParsesArgsAndEnv() throws {
        let url = FileManager().temporaryDirectory
            .appendingPathComponent("logica-launchd-\(UUID().uuidString).plist")
        let plist: [String: Any] = [
            "ProgramArguments": ["logica", "gateway-daemon", "--port", "18789", "--bind", "loopback"],
            "EnvironmentVariables": [
                "LOGICA_GATEWAY_TOKEN": " secret ",
                "LOGICA_GATEWAY_PASSWORD": "pw",
            ],
        ]
        let data = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try data.write(to: url, options: [.atomic])
        defer { try? FileManager().removeItem(at: url) }

        let snapshot = try #require(LaunchAgentPlist.snapshot(url: url))
        #expect(snapshot.port == 18789)
        #expect(snapshot.bind == "loopback")
        #expect(snapshot.token == "secret")
        #expect(snapshot.password == "pw")
    }

    @Test func launchAgentPlistSnapshotAllowsMissingBind() throws {
        let url = FileManager().temporaryDirectory
            .appendingPathComponent("logica-launchd-\(UUID().uuidString).plist")
        let plist: [String: Any] = [
            "ProgramArguments": ["logica", "gateway-daemon", "--port", "18789"],
        ]
        let data = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try data.write(to: url, options: [.atomic])
        defer { try? FileManager().removeItem(at: url) }

        let snapshot = try #require(LaunchAgentPlist.snapshot(url: url))
        #expect(snapshot.port == 18789)
        #expect(snapshot.bind == nil)
    }
}
