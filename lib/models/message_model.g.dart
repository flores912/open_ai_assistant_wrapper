// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String,
      object: json['object'] as String,
      created_at: json['created_at'] as int,
      thread_id: json['thread_id'] as String,
      role: $enumDecode(_$RoleEnumMap, json['role']),
      content: (json['content'] as List<dynamic>)
          .map((e) => MessageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      file_ids:
          (json['file_ids'] as List<dynamic>).map((e) => e as String).toList(),
      assistant_id: json['assistant_id'] as String?,
      run_id: json['run_id'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created_at': instance.created_at,
      'thread_id': instance.thread_id,
      'role': _$RoleEnumMap[instance.role]!,
      'content': instance.content,
      'file_ids': instance.file_ids,
      'assistant_id': instance.assistant_id,
      'run_id': instance.run_id,
      'metadata': instance.metadata,
    };

const _$RoleEnumMap = {
  Role.user: 'user',
  Role.assistant: 'assistant',
};

MessageContent _$MessageContentFromJson(Map<String, dynamic> json) =>
    MessageContent(
      type: $enumDecode(_$ContentTypeEnumMap, json['type']),
      text: json['text'] == null
          ? null
          : TextContent.fromJson(json['text'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageContentToJson(MessageContent instance) =>
    <String, dynamic>{
      'type': _$ContentTypeEnumMap[instance.type]!,
      'text': instance.text,
    };

const _$ContentTypeEnumMap = {
  ContentType.text: 'text',
  ContentType.image_file: 'image_file',
  ContentType.file_citation: 'file_citation',
  ContentType.file_path: 'file_path',
};

TextContent _$TextContentFromJson(Map<String, dynamic> json) => TextContent(
      value: json['value'] as String,
      annotations: (json['annotations'] as List<dynamic>)
          .map((e) => Annotation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TextContentToJson(TextContent instance) =>
    <String, dynamic>{
      'value': instance.value,
      'annotations': instance.annotations,
    };

ImageFileContent _$ImageFileContentFromJson(Map<String, dynamic> json) =>
    ImageFileContent(
      file_id: json['file_id'] as String,
    );

Map<String, dynamic> _$ImageFileContentToJson(ImageFileContent instance) =>
    <String, dynamic>{
      'file_id': instance.file_id,
    };

Annotation _$AnnotationFromJson(Map<String, dynamic> json) => Annotation(
      type: json['type'] as String,
      citation: FileCitation.fromJson(json['citation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnnotationToJson(Annotation instance) =>
    <String, dynamic>{
      'type': instance.type,
      'citation': instance.citation,
    };

FileCitation _$FileCitationFromJson(Map<String, dynamic> json) => FileCitation(
      type: json['type'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$FileCitationToJson(FileCitation instance) =>
    <String, dynamic>{
      'type': instance.type,
      'text': instance.text,
    };
