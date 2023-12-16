import 'package:open_ai_assistant_wrapper/apis/assistants/assistants_api.dart';
import 'package:open_ai_assistant_wrapper/apis/messages/messages_api.dart';
import 'package:open_ai_assistant_wrapper/apis/runs/runs_api.dart';
import 'package:open_ai_assistant_wrapper/apis/threads/threads_api.dart';

/// A client class for interacting with OpenAI's Assistant service.
class OpenAIAssistantClient {
  /// The API key used for authentication with OpenAI services.
  final String apiKey;

  /// API instance for interacting with Assistants API.
  final AssistantsApi assistants;

  /// API instance for interacting with Messages API.
  final MessagesApi messages;

  /// API instance for interacting with Threads API.
  final ThreadsApi threads;

  /// API instance for interacting with Runs API.
  final RunsApi runs;

  /// Creates a new instance of the OpenAI Assistant client.
  ///
  /// [apiKey]: The API key for authentication.
  OpenAIAssistantClient(this.apiKey)
      : assistants = AssistantsApi(apiKey),
        messages = MessagesApi(apiKey),
        threads = ThreadsApi(apiKey),
        runs = RunsApi(apiKey: apiKey);

/// Example usage:
///
/// ```dart
/// final client = OpenAIAssistantClient('YOUR_API_KEY_HERE');
///
/// // Access the assistants API
/// final assistant = client.assistants.createAssistant(...);
///
/// // Access the messages API
/// final message = client.messages.sendMessage(...);
///
/// // Access the threads API
/// final thread = client.threads.createThread(...);
///
/// // Access the runs API
/// final run = client.runs.createRun(...);
/// ```
}
