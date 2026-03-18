import CoreLocation
import Foundation
import LogicaKit
import UIKit

protocol CameraServicing: Sendable {
    func listDevices() async -> [CameraController.CameraDeviceInfo]
    func snap(params: LogicaCameraSnapParams) async throws -> (format: String, base64: String, width: Int, height: Int)
    func clip(params: LogicaCameraClipParams) async throws -> (format: String, base64: String, durationMs: Int, hasAudio: Bool)
}

protocol ScreenRecordingServicing: Sendable {
    func record(
        screenIndex: Int?,
        durationMs: Int?,
        fps: Double?,
        includeAudio: Bool?,
        outPath: String?) async throws -> String
}

@MainActor
protocol LocationServicing: Sendable {
    func authorizationStatus() -> CLAuthorizationStatus
    func accuracyAuthorization() -> CLAccuracyAuthorization
    func ensureAuthorization(mode: LogicaLocationMode) async -> CLAuthorizationStatus
    func currentLocation(
        params: LogicaLocationGetParams,
        desiredAccuracy: LogicaLocationAccuracy,
        maxAgeMs: Int?,
        timeoutMs: Int?) async throws -> CLLocation
}

protocol DeviceStatusServicing: Sendable {
    func status() async throws -> LogicaDeviceStatusPayload
    func info() -> LogicaDeviceInfoPayload
}

protocol PhotosServicing: Sendable {
    func latest(params: LogicaPhotosLatestParams) async throws -> LogicaPhotosLatestPayload
}

protocol ContactsServicing: Sendable {
    func search(params: LogicaContactsSearchParams) async throws -> LogicaContactsSearchPayload
    func add(params: LogicaContactsAddParams) async throws -> LogicaContactsAddPayload
}

protocol CalendarServicing: Sendable {
    func events(params: LogicaCalendarEventsParams) async throws -> LogicaCalendarEventsPayload
    func add(params: LogicaCalendarAddParams) async throws -> LogicaCalendarAddPayload
}

protocol RemindersServicing: Sendable {
    func list(params: LogicaRemindersListParams) async throws -> LogicaRemindersListPayload
    func add(params: LogicaRemindersAddParams) async throws -> LogicaRemindersAddPayload
}

protocol MotionServicing: Sendable {
    func activities(params: LogicaMotionActivityParams) async throws -> LogicaMotionActivityPayload
    func pedometer(params: LogicaPedometerParams) async throws -> LogicaPedometerPayload
}

extension CameraController: CameraServicing {}
extension ScreenRecordService: ScreenRecordingServicing {}
extension LocationService: LocationServicing {}
