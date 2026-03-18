import Foundation
import Testing
@testable import Logica

@Suite(.serialized)
struct LogicaConfigFileTests {
    @Test
    func configPathRespectsEnvOverride() async {
        let override = FileManager().temporaryDirectory
            .appendingPathComponent("logica-config-\(UUID().uuidString)")
            .appendingPathComponent("logica.json")
            .path

        await TestIsolation.withEnvValues(["LOGICA_CONFIG_PATH": override]) {
            #expect(LogicaConfigFile.url().path == override)
        }
    }

    @MainActor
    @Test
    func remoteGatewayPortParsesAndMatchesHost() async {
        let override = FileManager().temporaryDirectory
            .appendingPathComponent("logica-config-\(UUID().uuidString)")
            .appendingPathComponent("logica.json")
            .path

        await TestIsolation.withEnvValues(["LOGICA_CONFIG_PATH": override]) {
            LogicaConfigFile.saveDict([
                "gateway": [
                    "remote": [
                        "url": "ws://gateway.ts.net:19999",
                    ],
                ],
            ])
            #expect(LogicaConfigFile.remoteGatewayPort() == 19999)
            #expect(LogicaConfigFile.remoteGatewayPort(matchingHost: "gateway.ts.net") == 19999)
            #expect(LogicaConfigFile.remoteGatewayPort(matchingHost: "gateway") == 19999)
            #expect(LogicaConfigFile.remoteGatewayPort(matchingHost: "other.ts.net") == nil)
        }
    }

    @MainActor
    @Test
    func setRemoteGatewayUrlPreservesScheme() async {
        let override = FileManager().temporaryDirectory
            .appendingPathComponent("logica-config-\(UUID().uuidString)")
            .appendingPathComponent("logica.json")
            .path

        await TestIsolation.withEnvValues(["LOGICA_CONFIG_PATH": override]) {
            LogicaConfigFile.saveDict([
                "gateway": [
                    "remote": [
                        "url": "wss://old-host:111",
                    ],
                ],
            ])
            LogicaConfigFile.setRemoteGatewayUrl(host: "new-host", port: 2222)
            let root = LogicaConfigFile.loadDict()
            let url = ((root["gateway"] as? [String: Any])?["remote"] as? [String: Any])?["url"] as? String
            #expect(url == "wss://new-host:2222")
        }
    }

    @Test
    func stateDirOverrideSetsConfigPath() async {
        let dir = FileManager().temporaryDirectory
            .appendingPathComponent("logica-state-\(UUID().uuidString)", isDirectory: true)
            .path

        await TestIsolation.withEnvValues([
            "LOGICA_CONFIG_PATH": nil,
            "LOGICA_STATE_DIR": dir,
        ]) {
            #expect(LogicaConfigFile.stateDirURL().path == dir)
            #expect(LogicaConfigFile.url().path == "\(dir)/logica.json")
        }
    }
}
