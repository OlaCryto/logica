package ai.logica.android

import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

class WakeWordsTest {
  @Test
  fun parseCommaSeparatedTrimsAndDropsEmpty() {
    assertEquals(listOf("logica", "claude"), WakeWords.parseCommaSeparated("  logica , claude, ,  "))
  }

  @Test
  fun sanitizeTrimsCapsAndFallsBack() {
    val defaults = listOf("logica", "claude")
    val long = "x".repeat(WakeWords.maxWordLength + 10)
    val words = listOf(" ", "  hello  ", long)

    val sanitized = WakeWords.sanitize(words, defaults)
    assertEquals(2, sanitized.size)
    assertEquals("hello", sanitized[0])
    assertEquals("x".repeat(WakeWords.maxWordLength), sanitized[1])

    assertEquals(defaults, WakeWords.sanitize(listOf(" ", ""), defaults))
  }

  @Test
  fun sanitizeLimitsWordCount() {
    val defaults = listOf("logica")
    val words = (1..(WakeWords.maxWords + 5)).map { "w$it" }
    val sanitized = WakeWords.sanitize(words, defaults)
    assertEquals(WakeWords.maxWords, sanitized.size)
    assertEquals("w1", sanitized.first())
    assertEquals("w${WakeWords.maxWords}", sanitized.last())
  }

  @Test
  fun parseIfChangedSkipsWhenUnchanged() {
    val current = listOf("logica", "claude")
    val parsed = WakeWords.parseIfChanged(" logica , claude ", current)
    assertNull(parsed)
  }

  @Test
  fun parseIfChangedReturnsUpdatedList() {
    val current = listOf("logica")
    val parsed = WakeWords.parseIfChanged(" logica , jarvis ", current)
    assertEquals(listOf("logica", "jarvis"), parsed)
  }
}
