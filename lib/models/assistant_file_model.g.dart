// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssistantFile _$AssistantFileFromJson(Map<String, dynamic> json) =>
    AssistantFile(
      id: json['id'] as String,
      createdAt: json['createdAt'] as int,
      assistantId: json['assistantId'] as String,
    );

Map<String, dynamic> _$AssistantFileToJson(AssistantFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'assistantId': instance.assistantId,
    };
