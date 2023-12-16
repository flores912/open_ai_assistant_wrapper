// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_step_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunStep _$RunStepFromJson(Map<String, dynamic> json) => RunStep(
      id: json['id'] as String,
      object: json['object'] as String,
      created_at: json['created_at'] as int,
      run_id: json['run_id'] as String,
      assistant_id: json['assistant_id'] as String,
      thread_id: json['thread_id'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      cancelled_at: json['cancelled_at'] as int?,
      completed_at: json['completed_at'] as int?,
      expired_at: json['expired_at'] as int?,
      failed_at: json['failed_at'] as int?,
      last_error: json['last_error'] as Map<String, dynamic>?,
      step_details:
          StepDetails.fromJson(json['step_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RunStepToJson(RunStep instance) => <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created_at': instance.created_at,
      'run_id': instance.run_id,
      'assistant_id': instance.assistant_id,
      'thread_id': instance.thread_id,
      'type': instance.type,
      'status': instance.status,
      'cancelled_at': instance.cancelled_at,
      'completed_at': instance.completed_at,
      'expired_at': instance.expired_at,
      'failed_at': instance.failed_at,
      'last_error': instance.last_error,
      'step_details': instance.step_details,
    };

StepDetails _$StepDetailsFromJson(Map<String, dynamic> json) => StepDetails(
      type: json['type'] as String,
      messageCreation: json['messageCreation'] == null
          ? null
          : MessageCreation.fromJson(
              json['messageCreation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StepDetailsToJson(StepDetails instance) =>
    <String, dynamic>{
      'type': instance.type,
      'messageCreation': instance.messageCreation,
    };

MessageCreation _$MessageCreationFromJson(Map<String, dynamic> json) =>
    MessageCreation(
      message_id: json['message_id'] as String,
    );

Map<String, dynamic> _$MessageCreationToJson(MessageCreation instance) =>
    <String, dynamic>{
      'message_id': instance.message_id,
    };

RunStepList _$RunStepListFromJson(Map<String, dynamic> json) => RunStepList(
      object: json['object'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => RunStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      first_id: json['first_id'] as String?,
      last_id: json['last_id'] as String?,
      has_more: json['has_more'] as bool?,
    );

Map<String, dynamic> _$RunStepListToJson(RunStepList instance) =>
    <String, dynamic>{
      'object': instance.object,
      'data': instance.data,
      'first_id': instance.first_id,
      'last_id': instance.last_id,
      'has_more': instance.has_more,
    };
