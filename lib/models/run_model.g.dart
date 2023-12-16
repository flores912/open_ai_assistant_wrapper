// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Run _$RunFromJson(Map<String, dynamic> json) => Run(
      id: json['id'] as String,
      object: json['object'] as String? ?? 'thread.run',
      created_at: json['created_at'] as int,
      thread_id: json['thread_id'] as String,
      assistant_id: json['assistant_id'] as String,
      status: json['status'] as String,
      required_action: json['required_action'] == null
          ? null
          : RequiredAction.fromJson(
              json['required_action'] as Map<String, dynamic>),
      last_error: json['last_error'] == null
          ? null
          : LastError.fromJson(json['last_error'] as Map<String, dynamic>),
      expires_at: json['expires_at'] as int?,
      started_at: json['started_at'] as int?,
      cancelled_at: json['cancelled_at'] as int?,
      failed_at: json['failed_at'] as int?,
      completed_at: json['completed_at'] as int?,
      model: json['model'] as String,
      instructions: json['instructions'] as String?,
      tools: (json['tools'] as List<dynamic>)
          .map((e) => $enumDecode(_$ToolEnumMap, e))
          .toList(),
      file_ids:
          (json['file_ids'] as List<dynamic>).map((e) => e as String).toList(),
      metadata: json['metadata'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$RunToJson(Run instance) => <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created_at': instance.created_at,
      'thread_id': instance.thread_id,
      'assistant_id': instance.assistant_id,
      'status': instance.status,
      'required_action': instance.required_action,
      'last_error': instance.last_error,
      'expires_at': instance.expires_at,
      'started_at': instance.started_at,
      'cancelled_at': instance.cancelled_at,
      'failed_at': instance.failed_at,
      'completed_at': instance.completed_at,
      'model': instance.model,
      'instructions': instance.instructions,
      'tools': instance.tools.map((e) => _$ToolEnumMap[e]!).toList(),
      'file_ids': instance.file_ids,
      'metadata': instance.metadata,
    };

const _$ToolEnumMap = {
  Tool.codeInterpreter: 'code_interpreter',
  Tool.retrieval: 'retrieval',
  Tool.function: 'function',
};

RequiredAction _$RequiredActionFromJson(Map<String, dynamic> json) =>
    RequiredAction(
      type: json['type'] as String,
      submitToolOutputs: SubmitToolOutputs.fromJson(
          json['submitToolOutputs'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequiredActionToJson(RequiredAction instance) =>
    <String, dynamic>{
      'type': instance.type,
      'submitToolOutputs': instance.submitToolOutputs,
    };

SubmitToolOutputs _$SubmitToolOutputsFromJson(Map<String, dynamic> json) =>
    SubmitToolOutputs(
      lastError: json['lastError'] == null
          ? null
          : LastError.fromJson(json['lastError'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubmitToolOutputsToJson(SubmitToolOutputs instance) =>
    <String, dynamic>{
      'lastError': instance.lastError,
    };

LastError _$LastErrorFromJson(Map<String, dynamic> json) => LastError(
      code: json['code'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$LastErrorToJson(LastError instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
