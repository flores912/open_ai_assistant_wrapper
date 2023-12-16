import 'package:json_annotation/json_annotation.dart';

part 'message_file_model.g.dart';

/// Represents a file attached to a message.
@JsonSerializable()
class MessageFile {
  /// The identifier of the message file.
  final String id;

  /// The object type, which is always thread.message.file.
  final String object;

  /// The Unix timestamp (in seconds) for when the message file was created.
  final int created_at;

  /// The ID of the message that the file is attached to.
  final String message_id;

  /// Creates a new instance of [MessageFile].
  ///
  /// [id] (required) - The identifier of the message file.
  /// [object] (required) - The object type, which is always "thread.message.file".
  /// [created_at] (required) - The Unix timestamp (in seconds) for when the message file was created.
  /// [message_id] (required) - The ID of the message that the file is attached to.
  MessageFile({
    required this.id,
    required this.object,
    required this.created_at,
    required this.message_id,
  });

  /// Creates a [MessageFile] instance from a JSON map.
  factory MessageFile.fromJson(Map<String, dynamic> json) =>
      _$MessageFileFromJson(json);

  /// Converts this [MessageFile] instance to a JSON map.
  Map<String, dynamic> toJson() => _$MessageFileToJson(this);
}
