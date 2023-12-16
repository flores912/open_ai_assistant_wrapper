import 'package:json_annotation/json_annotation.dart';

part 'assistant_file_model.g.dart';


/// A class representing an assistant file attached to an assistant.
@JsonSerializable()
class AssistantFile {
  /// The unique identifier for the assistant file.
  final String id;

  /// The object type, which is always "assistant.file".
  final String object;

  /// The Unix timestamp (in seconds) when the assistant file was created.
  final int createdAt;

  /// The ID of the assistant to which this file is attached.
  final String assistantId;

  /// Creates an instance of [AssistantFile].
  ///
  /// [id] (required) - The unique identifier for the assistant file.
  /// [createdAt] (required) - The Unix timestamp (in seconds) when the assistant file was created.
  /// [assistantId] (required) - The ID of the assistant to which this file is attached.
  AssistantFile({
    required this.id,
    required this.createdAt,
    required this.assistantId,
  }) : object = 'assistant.file'; // Specify the object type as "assistant.file"

  /// Creates an instance of [AssistantFile] from a JSON map.
  factory AssistantFile.fromJson(Map<String, dynamic> json) =>
      _$AssistantFileFromJson(json);

  /// Converts this instance of [AssistantFile] to a JSON map.
  Map<String, dynamic> toJson() => _$AssistantFileToJson(this);
}
