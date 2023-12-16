
import 'package:json_annotation/json_annotation.dart';

import '../tools/tool_enum.dart';



part 'assistant_model.g.dart';

@JsonSerializable()
class Assistant {
  /// Represents an assistant that can call the model and use tools.
  ///
  /// An instance of this class can be used to interact with the assistant API.
  Assistant({
    required this.id,
    required this.object,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.model,
    this.instructions,
    required this.tools,
    required this.fileIds,
    required this.metadata,
  });

  /// The unique identifier of the assistant.
  final String id;

  /// The object type, which is always "assistant".
  final String object;

  /// The Unix timestamp (in seconds) for when the assistant was created.
  final int? createdAt;

  /// The name of the assistant.
  final String name;

  /// The description of the assistant.
  final String? description;

  /// ID of the model to use for the assistant.
  final String model;

  /// The system instructions that the assistant uses.
  final String? instructions;

  /// A list of tools enabled on the assistant.
  final List<Tool> tools;

  /// A list of file IDs attached to this assistant.
  final List<String> fileIds;

  /// Set of key-value pairs that can be attached to the assistant for metadata.
  final Map<String, dynamic> metadata;

  factory Assistant.fromJson(Map<String, dynamic> json) {
    final toolsList = (json['tools'] as List<dynamic>);
    final List<Tool> tools = toolsList
        .map((toolJson) {
      final toolType = toolJson['type'] as String?;
      if (toolType == 'code_interpreter') {
        return Tool.codeInterpreter;
      } else if (toolType == 'retrieval') {
        return Tool.retrieval;
      } else if (toolType == 'function') {
        return Tool.function;
      }
      // Handle unknown tool types or null values here
      return Tool.codeInterpreter; // Default to codeInterpreter
    })
        .toList();

    final fileIdsList = json['fileIds'] as List<dynamic>?;

    return Assistant(
      id: json['id'] as String,
      object: json['object'] as String,
      createdAt: json['created_at'] as int?,
      name: json['name'] as String,
      description: json['description'] as String?,
      model: json['model'] as String,
      instructions: json['instructions'] as String?,
      tools: tools,
      fileIds: fileIdsList != null ? fileIdsList.map((e) => e as String).toList() : [],
      metadata: json['metadata'] as Map<String, dynamic>,
    );
  }
}




