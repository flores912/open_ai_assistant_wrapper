import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:open_ai_assistant_wrapper/tools/tool_enum.dart';

import '../../models/assistant_file_model.dart';
import '../../models/assistant_model.dart';

part 'assistants_api.g.dart';

/// A class for interacting with the OpenAI API to create assistants.
class AssistantsApi {
  final String apiKey;
  final String apiUrl = 'https://api.openai.com/v1/assistants';

  AssistantsApi(this.apiKey);


  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
    'OpenAI-Beta': 'assistants=v1',

  };


  /// Creates an assistant with the specified parameters.
  ///
  /// [model] (required) - ID of the model to use.
  /// [name] - The name of the assistant (optional).
  /// [description] - The description of the assistant (optional).
  /// [instructions] - The system instructions that the assistant uses (optional).
  /// [tools] - A list of tools enabled on the assistant (optional).
  Future<void> createAssistant({
    required String model,
    String? name,
    String? description,
    String? instructions,
    List<Tool> tools = const [],
  }) async {
    final Map<String, dynamic> requestData = {
      'model': model,
      'name': name,
      'description': description,
      'instructions': instructions,
      'tools': tools.map((tool) => tool.name).toList(),
    };



    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Handle the response data as needed
      print('Assistant created successfully: $responseData');
    } else {
      // Handle errors here
      print('Error creating assistant. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }


  /// Retrieves an assistant by its ID.
  ///
  /// [assistantId] (required) - The ID of the assistant to retrieve.
  Future<Assistant> retrieveAssistant(String assistantId) async {
    final Uri uri = Uri.parse('$apiUrl/$assistantId');



    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Assistant.fromJson(responseData);
    } else {
      // Handle errors here
      print('Error retrieving assistant. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to retrieve assistant');
    }
  }


  /// Modifies an assistant by its ID.
  ///
  /// [assistantId] (required) - The ID of the assistant to modify.
  /// [model] - ID of the model to use (optional).
  /// [name] - The name of the assistant (optional).
  /// [description] - The description of the assistant (optional).
  /// [instructions] - The system instructions that the assistant uses (optional).
  /// [tools] - A list of tools enabled on the assistant (optional).
  Future<Assistant> modifyAssistant(String assistantId, {
    String? model,
    String? name,
    String? description,
    String? instructions,
    List<Tool> tools = const [],
  }) async {
    final Uri uri = Uri.parse('$apiUrl/$assistantId');

    final Map<String, dynamic> requestData = {
      if (model != null) 'model': model,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (instructions != null) 'instructions': instructions,
      'tools': tools.map((tool) => tool.name).toList(),
    };



    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Assistant.fromJson(responseData);
    } else {
      // Handle errors here
      print('Error modifying assistant. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to modify assistant');
    }
  }

  /// Deletes an assistant by its ID.
  ///
  /// [assistantId] (required) - The ID of the assistant to delete.
  Future<AssistantDeletionResponse> deleteAssistant(String assistantId) async {
    final Uri uri = Uri.parse('$apiUrl/$assistantId');



    final response = await http.delete(
      uri,
      headers: headers,
    );

    if (response.statusCode == 204) {
      // Assistant deleted successfully, return custom response
      return AssistantDeletionResponse(id: assistantId, deleted: true);
    } else {
      // Handle errors here
      print('Error deleting assistant. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to delete assistant');
    }
  }

  /// Retrieves a list of assistants.
  ///
  /// [limit] - A limit on the number of objects to be returned (optional).
  /// [order] - Sort order by the created_at timestamp of the objects (optional).
  /// [after] - A cursor for use in pagination (optional).
  /// [before] - A cursor for use in pagination (optional).
  Future<AssistantListResponse> listAssistants({
    int limit = 20,
    String order = 'desc',
    String? after,
    String? before,
  }) async {
    final Map<String, String> queryParams = {
      'limit': limit.toString(),
      'order': order,
      if (after != null) 'after': after,
      if (before != null) 'before': before,
    };

    final Uri uri = Uri.https(apiUrl, '/v1/assistants', queryParams);



    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      final List<Assistant> assistants = (responseData['data'] as List)
          .map((assistantData) => Assistant.fromJson(assistantData))
          .toList();

      return AssistantListResponse(
        assistants: assistants,
        firstId: responseData['first_id'],
        lastId: responseData['last_id'],
        hasMore: responseData['has_more'],
      );
    } else {
      // Handle errors here
      print('Error listing assistants. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to list assistants');
    }
  }

  /// Creates an assistant file by attaching a File to an assistant.
  ///
  /// [assistantId] (required) - The ID of the assistant for which to create a File.
  /// [fileId] (required) - A File ID (with purpose="assistants") that the assistant should use.
  ///
  /// Returns an [AssistantFile] object representing the created assistant file.
  ///
  /// Throws an exception if the operation fails.
  Future<AssistantFile> createAssistantFile({
    required String assistantId,
    required String fileId,
  }) async {
    final Map<String, dynamic> requestData = {
      'file_id': fileId,
    };


    final response = await http.post(
      Uri.parse('$apiUrl/$assistantId/files'),
      headers: headers,
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Return the AssistantFile instance created from the response.
      return AssistantFile.fromJson(responseData);
    } else {
      // Handle errors here
      print(
          'Error creating assistant file. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to create assistant file');
    }
  }
  /// Retrieves an AssistantFile by its ID.
  ///
  /// [assistantId] (required) - The ID of the assistant who the file belongs to.
  /// [fileId] (required) - The ID of the file to retrieve.
  Future<AssistantFile> retrieveAssistantFile(
      String assistantId,
      String fileId,
      ) async {
    final Uri uri = Uri.parse('$apiUrl/$assistantId/files/$fileId');


    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return AssistantFile.fromJson(responseData);
    } else {
      // Handle errors here
      print('Error retrieving assistant file. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to retrieve assistant file');
    }
  }

  /// Deletes an AssistantFile by its ID.
  ///
  /// [assistantId] (required) - The ID of the assistant that the file belongs to.
  /// [fileId] (required) - The ID of the file to delete.
  ///
  /// Returns a [AssistantFileDeletionResponse] object representing the deletion status.
  ///
  /// Throws an exception if the operation fails.
  Future<AssistantFileDeletionResponse> deleteAssistantFile(
      String assistantId,
      String fileId,
      ) async {
    final Uri uri = Uri.parse('$apiUrl/$assistantId/files/$fileId');


    final response = await http.delete(
      uri,
      headers: headers,
    );

    if (response.statusCode == 204) {
      // Assistant file deleted successfully
      return AssistantFileDeletionResponse(
        id: fileId,
        object: 'assistant.file.deleted',
        deleted: true,
      );
    } else {
      // Handle errors here
      print('Error deleting assistant file. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to delete assistant file');
    }
  }
  /// List assistant files by assistant ID.
  ///
  /// [assistantId] (required) - The ID of the assistant to list files for.
  /// [limit] - A limit on the number of objects to be returned (optional).
  /// [order] - Sort order by the created_at timestamp of the objects (optional).
  /// [after] - A cursor for use in pagination (optional).
  /// [before] - A cursor for use in pagination (optional).
  Future<AssistantFileListResponse> listAssistantFiles({
    required String assistantId,
    int limit = 20,
    String order = 'desc',
    String? after,
    String? before,
  }) async {
    final Map<String, String> queryParams = {
      'limit': limit.toString(),
      'order': order,
      if (after != null) 'after': after,
      if (before != null) 'before': before,
    };

    final Uri uri = Uri.https('$apiUrl/$assistantId', '/files', queryParams);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      final List<AssistantFile> assistantFiles = (responseData['data'] as List)
          .map((assistantFileData) => AssistantFile.fromJson(assistantFileData))
          .toList();

      return AssistantFileListResponse(
        assistantFiles: assistantFiles,
        firstId: responseData['first_id'],
        lastId: responseData['last_id'],
        hasMore: responseData['has_more'],
      );
    } else {
      // Handle errors here
      print('Error listing assistant files. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to list assistant files');
    }
  }
}

/// A class representing the request to create an assistant.
@JsonSerializable()
class CreateAssistantRequest {
  final String model;
  final String? name;
  final String? description;
  final String? instructions;
  final List<Tool> tools;

  CreateAssistantRequest({
    required this.model,
    this.name,
    this.description,
    this.instructions,
    List<Tool>? tools,
  }) : tools = tools ?? [];

  factory CreateAssistantRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAssistantRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAssistantRequestToJson(this);
}

/// A class representing the response received after creating an assistant.
@JsonSerializable()
class CreateAssistantResponse {
  final String id;
  final String object;
  final int createdAt;
  final String? name;
  final String? description;
  final String model;
  final String? instructions;
  final List<Tool> tools;
  final List<String> fileIds;
  final Map<String, dynamic> metadata;

  CreateAssistantResponse({
    required this.id,
    required this.object,
    required this.createdAt,
    this.name,
    this.description,
    required this.model,
    this.instructions,
    List<Tool>? tools,
    required this.fileIds,
    required this.metadata,
  }) : tools = tools ?? [];

  factory CreateAssistantResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAssistantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAssistantResponseToJson(this);
}
/// Represents the response when an assistant is deleted.
class AssistantDeletionResponse {
  final String id;      // The ID of the assistant that was deleted.
  final bool deleted;  // Indicates whether the assistant was successfully deleted (true) or not (false).

  AssistantDeletionResponse({
    required this.id,
    required this.deleted,
  });

  factory AssistantDeletionResponse.fromJson(Map<String, dynamic> json) =>
      AssistantDeletionResponse(
        id: json['id'] as String,
        deleted: json['deleted'] as bool,
      );
}

/// Represents the response when listing assistants.
class AssistantListResponse {
  final List<Assistant> assistants; // A list of assistant objects.
  final String? firstId;           // The ID of the first assistant in the list (nullable).
  final String? lastId;            // The ID of the last assistant in the list (nullable).
  final bool hasMore;             // Indicates whether there are more assistants to fetch (true) or not (false).

  AssistantListResponse({
    required this.assistants,
    this.firstId,
    this.lastId,
    required this.hasMore,
  });
}

/// Represents the response when an assistant file is deleted.
class AssistantFileDeletionResponse {
  final String id;       // The ID of the assistant file that was deleted.
  final String object;   // The type of object, which is always "assistant.file.deleted."
  final bool deleted;   // Indicates whether the assistant file was successfully deleted (true) or not (false).

  AssistantFileDeletionResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AssistantFileDeletionResponse.fromJson(Map<String, dynamic> json) {
    return AssistantFileDeletionResponse(
      id: json['id'],
      object: json['object'],
      deleted: json['deleted'],
    );
  }
}

/// Represents the response when listing assistant files.
class AssistantFileListResponse {
  final List<AssistantFile> assistantFiles; // A list of assistant file objects.
  final String? firstId;                   // The ID of the first assistant file in the list (nullable).
  final String? lastId;                    // The ID of the last assistant file in the list (nullable).
  final bool hasMore;                     // Indicates whether there are more assistant files to fetch (true) or not (false).

  AssistantFileListResponse({
    required this.assistantFiles,
    this.firstId,
    this.lastId,
    required this.hasMore,
  });
}
