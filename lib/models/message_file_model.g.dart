// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageFile _$MessageFileFromJson(Map<String, dynamic> json) => MessageFile(
      id: json['id'] as String,
      object: json['object'] as String,
      created_at: json['created_at'] as int,
      message_id: json['message_id'] as String,
    );

Map<String, dynamic> _$MessageFileToJson(MessageFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created_at': instance.created_at,
      'message_id': instance.message_id,
    };
