import 'package:json_annotation/json_annotation.dart';

import '../apis/threads/role_enum.dart';

import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class Message {
  final String id;
  final String object;
  final int created_at;
  final String thread_id;
  final Role role;
  final List<MessageContent> content;
  final List<String> file_ids;
  final String? assistant_id;
  final String? run_id;
  final Map<String, dynamic> metadata;

  Message({
    required this.id,
    required this.object,
    required this.created_at,
    required this.thread_id,
    required this.role,
    required this.content,
    required this.file_ids,
    this.assistant_id,
    this.run_id,
    Map<String, dynamic>? metadata,
  }) : metadata = metadata ?? {};

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  // Getter to access the first text content (if it exists)
  TextContent? get firstTextContent {
    final textContents = content.where((c) => c.type == ContentType.text).toList();
    if (textContents.isNotEmpty) {
      return textContents[0].text;
    }
    return null;
  }
}

@JsonSerializable()
class MessageContent {
  final ContentType type;
  final TextContent? text; // Add this field

  MessageContent({
    required this.type,
    this.text, // Update the constructor
  });

  factory MessageContent.fromJson(Map<String, dynamic> json) {
    final String type = json['type'] as String;
    ContentType contentType;

    switch (type) {
      case 'text':
        contentType = ContentType.text;
        break;
      case 'image_file':
        contentType = ContentType.image_file;
        break;
      case 'file_citation':
        contentType = ContentType.file_citation;
        break;
      case 'file_path':
        contentType = ContentType.file_path;
        break;
      default:
        throw ArgumentError('Invalid content type: $type');
    }

    return MessageContent(
      type: contentType,
      text: json['text'] != null ? TextContent.fromJson(json['text'] as Map<String, dynamic>) : null, // Parse the 'text' field
    );
  }

  Map<String, dynamic> toJson() => _$MessageContentToJson(this);

  // Getter to access text content value (if applicable)
  String? get textValue => text?.value; // Access the 'value' property of 'text'
}

@JsonEnum()
enum ContentType {
  text,
  image_file,
  file_citation,
  file_path,
}

@JsonSerializable()
class TextContent {
  final String value;
  final List<Annotation> annotations;

  TextContent({
    required this.value,
    required this.annotations,
  });

  factory TextContent.fromJson(Map<String, dynamic> json) => _$TextContentFromJson(json);

  // Getter to access text content value
  String? get textValue => value;
}

@JsonSerializable()
class ImageFileContent {
  final String file_id;

  ImageFileContent({
    required this.file_id,
  });

  factory ImageFileContent.fromJson(Map<String, dynamic> json) => _$ImageFileContentFromJson(json);
}

@JsonSerializable()
class Annotation {
  final String type;
  final FileCitation citation;

  Annotation({
    required this.type,
    required this.citation,
  });

  factory Annotation.fromJson(Map<String, dynamic> json) => _$AnnotationFromJson(json);
}

@JsonSerializable()
class FileCitation {
  final String type;
  final String text;

  FileCitation({
    required this.type,
    required this.text,
  });

  factory FileCitation.fromJson(Map<String, dynamic> json) => _$FileCitationFromJson(json);
}
