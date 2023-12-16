// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'function_tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FunctionTool _$FunctionToolFromJson(Map<String, dynamic> json) => FunctionTool(
      type: json['type'] as String,
      description: json['description'] as String,
      name: json['name'] as String,
      parameters: json['parameters'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$FunctionToolToJson(FunctionTool instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'name': instance.name,
      'parameters': instance.parameters,
    };
