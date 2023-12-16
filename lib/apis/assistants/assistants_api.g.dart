// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistants_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAssistantRequest _$CreateAssistantRequestFromJson(
        Map<String, dynamic> json) =>
    CreateAssistantRequest(
      model: json['model'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      instructions: json['instructions'] as String?,
      tools: (json['tools'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ToolEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$CreateAssistantRequestToJson(
        CreateAssistantRequest instance) =>
    <String, dynamic>{
      'model': instance.model,
      'name': instance.name,
      'description': instance.description,
      'instructions': instance.instructions,
      'tools': instance.tools.map((e) => _$ToolEnumMap[e]!).toList(),
    };

const _$ToolEnumMap = {
  Tool.codeInterpreter: 'code_interpreter',
  Tool.retrieval: 'retrieval',
  Tool.function: 'function',
};

CreateAssistantResponse _$CreateAssistantResponseFromJson(
        Map<String, dynamic> json) =>
    CreateAssistantResponse(
      id: json['id'] as String,
      object: json['object'] as String,
      createdAt: json['createdAt'] as int,
      name: json['name'] as String?,
      description: json['description'] as String?,
      model: json['model'] as String,
      instructions: json['instructions'] as String?,
      tools: (json['tools'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ToolEnumMap, e))
          .toList(),
      fileIds:
          (json['fileIds'] as List<dynamic>).map((e) => e as String).toList(),
      metadata: json['metadata'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CreateAssistantResponseToJson(
        CreateAssistantResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'createdAt': instance.createdAt,
      'name': instance.name,
      'description': instance.description,
      'model': instance.model,
      'instructions': instance.instructions,
      'tools': instance.tools.map((e) => _$ToolEnumMap[e]!).toList(),
      'fileIds': instance.fileIds,
      'metadata': instance.metadata,
    };
