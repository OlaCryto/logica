import Testing
@testable import Logica

@Suite(.serialized)
@MainActor
struct OnboardingCoverageTests {
    @Test func exerciseOnboardingPages() {
        OnboardingView.exerciseForTesting()
    }
}
