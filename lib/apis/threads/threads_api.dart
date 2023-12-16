import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/message_model.dart';
import '../../models/thread_model.dart';

class ThreadsApi{
  final String apiKey;
  final String apiUrl = 'https://api.openai.com/v1/threads';

  ThreadsApi(this.apiKey);

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
    'OpenAI-Beta': 'assistants=v1',
  };



  /// Creates a thread with the specified messages and metadata.
  ///
  /// [messages] (optional) - A list of [Message] objects to start the thread with.
  /// [metadata] (optional) - Set of key-value pairs that can be attached to the thread object.
  ///
  /// Returns a [Thread] object representing the created thread.
  ///
  /// Throws an exception if the operation fails.
  ///
  /// Example:
  /// ```dart
  /// final openai = OpenAIAssistant(apiKey: 'your_api_key_here');
  ///
  /// final messageThread = await openai.createThread(
  ///   messages: [
  ///     Message(
  ///       role: MessageRole.user,
  ///       content: 'Hello, what is AI?',
  ///       fileIds: ['file-abc123'],
  ///     ),
  ///     Message(
  ///       role: MessageRole.user,
  ///       content: 'How does AI work? Explain it in simple terms.',
  ///     ),
  ///   ],
  /// );
  ///
  /// print(messageThread);
  /// ```
  Future<Thread> createThread({
    List<Message> messages = const [],
    Map<String, dynamic> metadata = const {},
  }) async {
    final Map<String, dynamic> requestData = {
      'messages': messages.map((message) => message.toJson()).toList(),
      'metadata': metadata,
    };


    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Thread.fromJson(responseData);
    } else {
      // Handle errors here
      print('Error creating thread. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to create thread');
    }
  }
  /// Modifies a thread by updating its metadata.
  ///
  /// [threadId] (required) - The ID of the thread to modify.
  /// [metadata] (optional) - Set of key-value pairs that can be attached to the thread object.
  ///
  /// Returns a [Thread] object representing the modified thread.
  ///
  /// Throws an exception if the operation fails.
  ///
  /// Example:
  /// ```dart
  /// final openai = OpenAIAssistant(apiKey: 'your_api_key_here');
  ///
  /// final modifiedThread = await openai.modifyThread(
  ///   threadId: 'thread_abc123',
  ///   metadata: {
  ///     'modified': 'true',
  ///     'user': 'abc123',
  ///   },
  /// );
  ///
  /// print(modifiedThread);
  /// ```
  Future<Thread> modifyThread({
    required String threadId,
    Map<String, dynamic> metadata = const {},
  }) async {
    final Uri uri = Uri.parse('$apiUrl/$threadId');

    final Map<String, dynamic> requestData = {
      'metadata': metadata,
    };



    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Thread.fromJson(responseData);
    } else {
      // Handle errors here
      print('Error modifying thread. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to modify thread');
    }
  }
  /// Deletes a thread by its ID.
  ///
  /// [threadId] (required) - The ID of the thread to delete.
  ///
  /// Returns an [ThreadDeletionResponse] object representing the deletion status.
  ///
  /// Throws an exception if the operation fails.
  ///
  /// Example:
  /// ```dart
  /// final openai = OpenAIAssistant(apiKey: 'your_api_key_here');
  ///
  /// final deletedThread = await openai.deleteThread('thread_abc123');
  ///
  /// print(deletedThread);
  /// ```
  Future<ThreadDeletionResponse> deleteThread(String threadId) async {
    final Uri uri = Uri.parse('$apiUrl/$threadId');



    final response = await http.delete(
      uri,
      headers: headers,
    );

    if (response.statusCode == 204) {
      // Thread deleted successfully, return custom response
      return ThreadDeletionResponse(id: threadId, deleted: true);
    } else {
      // Handle errors here
      print('Error deleting thread. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to delete thread');
    }
  }
  /// Retrieves a thread by its ID.
  ///
  /// [threadId] (required) - The ID of the thread to retrieve.
  ///
  /// Returns the [Thread] object matching the specified ID.
  ///
  /// Throws an exception if the operation fails.
  ///
  /// Example:
  /// ```dart
  /// final openai = OpenAIAssistant(apiKey: 'your_api_key_here');
  ///
  /// final retrievedThread = await openai.retrieveThread('thread_abc123');
  ///
  /// print(retrievedThread);
  /// ```
  Future<Thread> retrieveThread(String threadId) async {
    final Uri uri = Uri.parse('$apiUrl/$threadId');

    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Thread.fromJson(responseData);
    } else {
      // Handle errors here
      print('Error retrieving thread. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to retrieve thread');
    }
  }

}
/// Represents the response for deleting a thread.
class ThreadDeletionResponse {
  /// The ID of the deleted thread.
  final String id;

  /// Indicates whether the thread was successfully deleted.
  final bool deleted;

  ThreadDeletionResponse({
    required this.id,
    required this.deleted,
  });

  /// Creates an instance of [ThreadDeletionResponse] from a JSON map.
  factory ThreadDeletionResponse.fromJson(Map<String, dynamic> json) {
    return ThreadDeletionResponse(
      id: json['id'] as String,
      deleted: json['deleted'] as bool,
    );
  }
}
