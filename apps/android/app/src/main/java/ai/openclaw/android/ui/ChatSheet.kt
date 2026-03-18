package ai.logica.android.ui

import androidx.compose.runtime.Composable
import ai.logica.android.MainViewModel
import ai.logica.android.ui.chat.ChatSheetContent

@Composable
fun ChatSheet(viewModel: MainViewModel) {
  ChatSheetContent(viewModel = viewModel)
}
