package ai.logica.android.protocol

import org.junit.Assert.assertEquals
import org.junit.Test

class LogicaProtocolConstantsTest {
  @Test
  fun canvasCommandsUseStableStrings() {
    assertEquals("canvas.present", LogicaCanvasCommand.Present.rawValue)
    assertEquals("canvas.hide", LogicaCanvasCommand.Hide.rawValue)
    assertEquals("canvas.navigate", LogicaCanvasCommand.Navigate.rawValue)
    assertEquals("canvas.eval", LogicaCanvasCommand.Eval.rawValue)
    assertEquals("canvas.snapshot", LogicaCanvasCommand.Snapshot.rawValue)
  }

  @Test
  fun a2uiCommandsUseStableStrings() {
    assertEquals("canvas.a2ui.push", LogicaCanvasA2UICommand.Push.rawValue)
    assertEquals("canvas.a2ui.pushJSONL", LogicaCanvasA2UICommand.PushJSONL.rawValue)
    assertEquals("canvas.a2ui.reset", LogicaCanvasA2UICommand.Reset.rawValue)
  }

  @Test
  fun capabilitiesUseStableStrings() {
    assertEquals("canvas", LogicaCapability.Canvas.rawValue)
    assertEquals("camera", LogicaCapability.Camera.rawValue)
    assertEquals("screen", LogicaCapability.Screen.rawValue)
    assertEquals("voiceWake", LogicaCapability.VoiceWake.rawValue)
  }

  @Test
  fun screenCommandsUseStableStrings() {
    assertEquals("screen.record", LogicaScreenCommand.Record.rawValue)
  }
}
