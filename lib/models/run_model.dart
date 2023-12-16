import 'package:json_annotation/json_annotation.dart';

import '../tools/tool_enum.dart';

part 'run_model.g.dart';

@JsonSerializable()
class Run {
  /// The identifier of the run.
  final String id;

  /// The object type, which is always thread.run.
  final String object;

  /// The Unix timestamp (in seconds) for when the run was created.
  final int created_at;

  /// The ID of the thread that was executed on as a part of this run.
  final String thread_id;

  /// The ID of the assistant used for execution of this run.
  final String assistant_id;

  /// The status of the run, which can be one of the following:
  /// queued, in_progress, requires_action, cancelling, cancelled, failed, completed, or expired.
  final String status;

  /// Details on the action required to continue the run. Will be null if no action is required.
  final RequiredAction? required_action;

  /// The last error associated with this run. Will be null if there are no errors.
  final LastError? last_error;

  /// The Unix timestamp (in seconds) for when the run will expire.
  final int? expires_at;

  /// The Unix timestamp (in seconds) for when the run was started.
  final int? started_at;

  /// The Unix timestamp (in seconds) for when the run was cancelled.
  final int? cancelled_at;

  /// The Unix timestamp (in seconds) for when the run failed.
  final int? failed_at;

  /// The Unix timestamp (in seconds) for when the run was completed.
  final int? completed_at;

  /// The model that the assistant used for this run.
  final String model;

  /// The instructions that the assistant used for this run.
  final String? instructions;

  /// The list of tools that the assistant used for this run.
  final List<Tool> tools;

  /// The list of File IDs the assistant used for this run.
  final List<String> file_ids;

  /// Set of 16 key-value pairs that can be attached to an object.
  /// This can be useful for storing additional information about the object in a structured format.
  /// Keys can be a maximum of 64 characters long, and values can be a maximum of 512 characters long.
  final Map<String, dynamic> metadata;

  Run({
    required this.id,
    this.object = 'thread.run',
    required this.created_at,
    required this.thread_id,
    required this.assistant_id,
    required this.status,
    required this.required_action,
    required this.last_error,
    this.expires_at,
    this.started_at,
    this.cancelled_at,
    this.failed_at,
    this.completed_at,
    required this.model,
    this.instructions,
    required this.tools,
    required this.file_ids,
    required this.metadata,
  });

  factory Run.fromJson(Map<String, dynamic> json) {
    final toolsJson = json['tools'] as List<dynamic>?;

    final List<Tool> tools = toolsJson?.map((toolJson) {
      final toolType = toolJson['type'] as String?;
      if (toolType != null) {
        switch (toolType) {
          case 'code_interpreter':
            return Tool.codeInterpreter;
          case 'retrieval':
            return Tool.retrieval;
          case 'function':
            return Tool.function;
          default:
            return null; // Default to codeInterpreter for unknown tool types
        }
      }
      return null;
    }).where((tool) => tool != null).cast<Tool>().toList() ?? [];

    return Run(
      id: json['id'] as String,
      object: json['object'] as String,
      created_at: json['created_at'] as int,
      thread_id: json['thread_id'] as String,
      assistant_id: json['assistant_id'] as String,
      status: json['status'] as String,
      required_action: json['required_action'] == null
          ? null
          : RequiredAction.fromJson(json['required_action'] as Map<String, dynamic>),
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
      tools: tools,
      file_ids: (json['file_ids'] as List<dynamic>).map((e) => e as String).toList(),
      metadata: json['metadata'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() => _$RunToJson(this);
}



@JsonSerializable()
class RequiredAction {
  /// The type of required action, which is always "submit_tool_outputs" for now.
  final String type;

  /// Details on the tool outputs needed for this run to continue.
  final SubmitToolOutputs submitToolOutputs;

  RequiredAction({
    required this.type,
    required this.submitToolOutputs,
  });

  factory RequiredAction.fromJson(Map<String, dynamic> json) =>
      _$RequiredActionFromJson(json);

  Map<String, dynamic> toJson() => _$RequiredActionToJson(this);
}

@JsonSerializable()
class SubmitToolOutputs {
  /// The last error associated with this run. Will be null if there are no errors.
  final LastError? lastError;

  SubmitToolOutputs({
    this.lastError,
  });

  factory SubmitToolOutputs.fromJson(Map<String, dynamic> json) =>
      _$SubmitToolOutputsFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitToolOutputsToJson(this);
}

@JsonSerializable()
class LastError {
  /// The type of the last error, which can be "server_error" or "rate_limit_exceeded."
  final String code;

  /// A human-readable description of the error.
  final String message;

  LastError({
    required this.code,
    required this.message,
  });

  factory LastError.fromJson(Map<String, dynamic> json) =>
      _$LastErrorFromJson(json);

  Map<String, dynamic> toJson() => _$LastErrorToJson(this);
}
