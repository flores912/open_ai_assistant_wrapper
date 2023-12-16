// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runs_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListRunsResponse _$ListRunsResponseFromJson(Map<String, dynamic> json) =>
    ListRunsResponse(
      object: json['object'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Run.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstId: json['firstId'] as String,
      lastId: json['lastId'] as String,
      hasMore: json['hasMore'] as bool,
    );

Map<String, dynamic> _$ListRunsResponseToJson(ListRunsResponse instance) =>
    <String, dynamic>{
      'object': instance.object,
      'data': instance.data,
      'firstId': instance.firstId,
      'lastId': instance.lastId,
      'hasMore': instance.hasMore,
    };
