import Foundation

// Stable identifier used for both the macOS LaunchAgent label and Nix-managed defaults suite.
// nix-logica writes app defaults into this suite to survive app bundle identifier churn.
let launchdLabel = "ai.logica.mac"
let gatewayLaunchdLabel = "ai.logica.gateway"
let onboardingVersionKey = "logica.onboardingVersion"
let onboardingSeenKey = "logica.onboardingSeen"
let currentOnboardingVersion = 7
let pauseDefaultsKey = "logica.pauseEnabled"
let iconAnimationsEnabledKey = "logica.iconAnimationsEnabled"
let swabbleEnabledKey = "logica.swabbleEnabled"
let swabbleTriggersKey = "logica.swabbleTriggers"
let voiceWakeTriggerChimeKey = "logica.voiceWakeTriggerChime"
let voiceWakeSendChimeKey = "logica.voiceWakeSendChime"
let showDockIconKey = "logica.showDockIcon"
let defaultVoiceWakeTriggers = ["logica"]
let voiceWakeMaxWords = 32
let voiceWakeMaxWordLength = 64
let voiceWakeMicKey = "logica.voiceWakeMicID"
let voiceWakeMicNameKey = "logica.voiceWakeMicName"
let voiceWakeLocaleKey = "logica.voiceWakeLocaleID"
let voiceWakeAdditionalLocalesKey = "logica.voiceWakeAdditionalLocaleIDs"
let voicePushToTalkEnabledKey = "logica.voicePushToTalkEnabled"
let talkEnabledKey = "logica.talkEnabled"
let iconOverrideKey = "logica.iconOverride"
let connectionModeKey = "logica.connectionMode"
let remoteTargetKey = "logica.remoteTarget"
let remoteIdentityKey = "logica.remoteIdentity"
let remoteProjectRootKey = "logica.remoteProjectRoot"
let remoteCliPathKey = "logica.remoteCliPath"
let canvasEnabledKey = "logica.canvasEnabled"
let cameraEnabledKey = "logica.cameraEnabled"
let systemRunPolicyKey = "logica.systemRunPolicy"
let systemRunAllowlistKey = "logica.systemRunAllowlist"
let systemRunEnabledKey = "logica.systemRunEnabled"
let locationModeKey = "logica.locationMode"
let locationPreciseKey = "logica.locationPreciseEnabled"
let peekabooBridgeEnabledKey = "logica.peekabooBridgeEnabled"
let deepLinkKeyKey = "logica.deepLinkKey"
let modelCatalogPathKey = "logica.modelCatalogPath"
let modelCatalogReloadKey = "logica.modelCatalogReload"
let cliInstallPromptedVersionKey = "logica.cliInstallPromptedVersion"
let heartbeatsEnabledKey = "logica.heartbeatsEnabled"
let debugPaneEnabledKey = "logica.debugPaneEnabled"
let debugFileLogEnabledKey = "logica.debug.fileLogEnabled"
let appLogLevelKey = "logica.debug.appLogLevel"
let voiceWakeSupported: Bool = ProcessInfo.processInfo.operatingSystemVersion.majorVersion >= 26
