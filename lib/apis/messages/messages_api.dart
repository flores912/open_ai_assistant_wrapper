import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import '../../models/message_file_model.dart';
import '../../models/message_model.dart';
import '../threads/role_enum.dart';


part 'messages_api.g.dart';
/// A class for interacting with the OpenAI API to create a message in a thread.
@JsonSerializable()
class MessagesApi {
  final String apiKey;
  final String apiUrl = 'https://api.openai.com/v1/threads';

  MessagesApi(this.apiKey);

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
    'OpenAI-Beta': 'assistants=v1',
  };


  /// Creates a message in a thread.
  ///
  /// [threadId] (required) - The ID of the thread to create a message for.
  /// [role] (required) - The role of the entity that is creating the message.
  /// [content] (required) - The content of the message.
  /// [fileIds] (optional) - A list of File IDs that the message should use.
  /// [metadata] (optional) - Set of key-value pairs that can be attached to the message object.
  ///
  /// Returns a message object representing the created message.
  ///
  /// Throws an exception if the operation fails.
  Future<Message> createMessage({
    required String threadId,
    required Role role,
    required String content,
    List<String>? fileIds,
    Map<String, dynamic>? metadata,
  }) async {
    final Map<String, dynamic> requestData = {
      'role': role.name, // Use .name to get the enum value as a string
      'content': content,
      'file_ids': fileIds ?? [],
      'metadata': metadata ?? {},
    };


    final response = await http.post(
      Uri.parse('$apiUrl/$threadId/messages'),
      headers: headers,
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Message.fromJson(responseData);
    } else {
      // Handle errors here
      print('Error creating message. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to create message');
    }
  }

  /// Retrieves a message by its thread ID and message ID.
  ///
  /// [threadId] (required) - The ID of the thread to which the message belongs.
  /// [messageId] (required) - The ID of the message to retrieve.
  Future<Message> retrieveMessage(String threadId, String messageId) async {
    final Uri uri = Uri.parse('$apiUrl/$threadId/messages/$messageId');


    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Message.fromJson(responseData);
    } else {
      // Handle errors here
      print('Error retrieving message. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to retrieve message');
    }
  }

  /// Modifies a message by its thread ID and message ID.
  ///
  /// [threadId] (required) - The ID of the thread to which the message belongs.
  /// [messageId] (required) - The ID of the message to modify.
  /// [metadata] (optional) - Set of key-value pairs that can be attached to the message object.
  Future<Message> modifyMessage(String threadId, String messageId,
      Map<String, dynamic> metadata) async {
    final Uri uri = Uri.parse('$apiUrl/$threadId/messages/$messageId');


    final requestData = {
      'metadata': metadata,
    };

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Message.fromJson(responseData);
    } else {
      // Handle errors here
      print('Error modifying message. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to modify message');
    }
  }

  /// Retrieves a list of messages for a given thread by its thread ID.
  ///
  /// [threadId] (required) - The ID of the thread the messages belong to.
  /// [limit] (optional) - A limit on the number of objects to be returned.
  /// [order] (optional) - Sort order by the created_at timestamp of the objects.
  /// [after] (optional) - A cursor for use in pagination for fetching the next page of the list.
  /// [before] (optional) - A cursor for use in pagination for fetching the previous page of the list.
  ///
  /// Returns a [MessageList] object containing a list of [Message] objects and metadata.
  ///
  /// Throws an exception if the operation fails.
  /// Retrieves a list of messages for a given thread by its thread ID.
  ///
  /// [threadId] (required) - The ID of the thread the messages belong to.
  /// [limit] (optional) - A limit on the number of objects to be returned (default: 20).
  /// [order] (optional) - Sort order by the created_at timestamp of the objects (default: 'desc').
  /// [after] (optional) - A cursor for use in pagination for fetching the next page of the list.
  /// [before] (optional) - A cursor for use in pagination for fetching the previous page of the list.
  ///
  /// Returns a [MessageList] object containing a list of [Message] objects and metadata.
  ///
  /// Throws an exception if the operation fails.
  Future<MessageList> listMessages({
    required String threadId,
    int? limit,
    String? order,
    String? after,
    String? before,
  }) async {
    final Uri uri = Uri.parse('$apiUrl/$threadId/messages');

    final Map<String, dynamic> queryParams = {
      if (limit != null) 'limit': limit,
      if (order != null) 'order': order,
      if (after != null) 'after': after,
      if (before != null) 'before': before,
    };


    final response = await http.get(
      uri.replace(queryParameters: queryParams),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return MessageList.fromJson(responseData);
    } else {
      // Handle errors here
      print('Error listing messages. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to list messages');
    }
  }
  /// Retrieves a message file.
  ///
  /// [threadId] (required) - The ID of the thread to which the message and file belong.
  /// [messageId] (required) - The ID of the message the file belongs to.
  /// [fileId] (required) - The ID of the file being retrieved.
  ///
  /// Returns a [MessageFile] object representing the retrieved message file.
  ///
  /// Throws an exception if the operation fails.
  Future<MessageFile> retrieveMessageFile({
    required String threadId,
    required String messageId,
    required String fileId,
  }) async {
    final Uri uri = Uri.parse('$apiUrl/$threadId/messages/$messageId/files/$fileId');


    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return MessageFile.fromJson(responseData);
    } else {
      // Handle errors here
      print('Error retrieving message file. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to retrieve message file');
    }
  }

  /// Returns a list of message files.
  ///
  /// [threadId] (required) - The ID of the thread that the message and files belong to.
  /// [messageId] (required) - The ID of the message that the files belong to.
  /// [limit] (optional) - A limit on the number of objects to be returned.
  /// [order] (optional) - Sort order by the created_at timestamp of the objects.
  /// [after] (optional) - A cursor for use in pagination for fetching the next page of the list.
  /// [before] (optional) - A cursor for use in pagination for fetching the previous page of the list.
  ///
  /// Returns a [MessageFileList] object representing the list of message files.
  ///
  /// Throws an exception if the operation fails.
  Future<MessageFileList> listMessageFiles({
    required String threadId,
    required String messageId,
    int? limit,
    String? order,
    String? after,
    String? before,
  }) async {
    final Uri uri = Uri.parse('$apiUrl/$threadId/messages/$messageId/files');

    final Map<String, dynamic> queryParams = {
      if (limit != null) 'limit': limit,
      if (order != null) 'order': order,
      if (after != null) 'after': after,
      if (before != null) 'before': before,
    };


    final response = await http.get(
      uri.replace(queryParameters: queryParams),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return MessageFileList.fromJson(responseData);
    } else {
      // Handle errors here
      print('Error listing message files. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to list message files');
    }
  }

}

class MessageList {
  final List<Message> messages;
  final String? firstId;
  final String? lastId;
  final bool hasMore;

  MessageList({
    required this.messages,
    this.firstId,
    this.lastId,
    required this.hasMore,
  });

  factory MessageList.fromJson(Map<String, dynamic> json) {
    final List<dynamic> messageDataList = json['data'];

    return MessageList(
      messages: messageDataList.map((messageData) => Message.fromJson(messageData)).toList(),
      firstId: json['first_id'],
      lastId: json['last_id'],
      hasMore: json['has_more'],
    );
  }


  }/// Represents a list of message files.
class MessageFileList {
  /// The list of message file objects.
  final List<MessageFile> files;

  /// The ID of the first message file in the list.
  final String? firstId;

  /// The ID of the last message file in the list.
  final String? lastId;

  /// Indicates whether there are more message files to be fetched.
  final bool hasMore;

  MessageFileList({
    required this.files,
    this.firstId,
    this.lastId,
    required this.hasMore,
  });

  /// Creates a [MessageFileList] object from a JSON map.
  factory MessageFileList.fromJson(Map<String, dynamic> json) {
    final List<dynamic> fileDataList = json['data'];

    return MessageFileList(
      files: fileDataList.map((fileData) => MessageFile.fromJson(fileData)).toList(),
      firstId: json['first_id'],
      lastId: json['last_id'],
      hasMore: json['has_more'],
    );
  }
}
