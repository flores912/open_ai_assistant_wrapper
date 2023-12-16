// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thread _$ThreadFromJson(Map<String, dynamic> json) => Thread(
      id: json['id'] as String,
      created_at: json['created_at'] as int,
      metadata: json['metadata'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ThreadToJson(Thread instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at,
      'metadata': instance.metadata,
    };
