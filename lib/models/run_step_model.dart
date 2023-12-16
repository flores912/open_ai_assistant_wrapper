import 'package:json_annotation/json_annotation.dart';

part 'run_step_model.g.dart';

@JsonSerializable()
class RunStep {
  final String id;
  final String object;
  final int created_at;
  final String run_id;
  final String assistant_id;
  final String thread_id;
  final String type;
  final String status;
  final int? cancelled_at;
  final int? completed_at;
  final int? expired_at;
  final int? failed_at;
  final Map<String, dynamic>? last_error;
  final StepDetails step_details;

  RunStep({
    required this.id,
    required this.object,
    required this.created_at,
    required this.run_id,
    required this.assistant_id,
    required this.thread_id,
    required this.type,
    required this.status,
    this.cancelled_at,
    this.completed_at,
    this.expired_at,
    this.failed_at,
    this.last_error,
    required this.step_details,
  });

  factory RunStep.fromJson(Map<String, dynamic> json) =>
      _$RunStepFromJson(json);

  Map<String, dynamic> toJson() => _$RunStepToJson(this);
}

@JsonSerializable()
class StepDetails {
  final String type;
  final MessageCreation? messageCreation;

  StepDetails({
    required this.type,
    this.messageCreation,
  });

  factory StepDetails.fromJson(Map<String, dynamic> json) =>
      _$StepDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$StepDetailsToJson(this);
}

@JsonSerializable()
class MessageCreation {
  final String message_id;

  MessageCreation({
    required this.message_id,
  });

  factory MessageCreation.fromJson(Map<String, dynamic> json) =>
      _$MessageCreationFromJson(json);

  Map<String, dynamic> toJson() => _$MessageCreationToJson(this);
}

@JsonSerializable()
class RunStepList {
  final String object;
  final List<RunStep> data;
  final String? first_id;
  final String? last_id;
  final bool? has_more;

  RunStepList({
    required this.object,
    required this.data,
    this.first_id,
    this.last_id,
    this.has_more,
  });

  factory RunStepList.fromJson(Map<String, dynamic> json) =>
      _$RunStepListFromJson(json);

  Map<String, dynamic> toJson() => _$RunStepListToJson(this);
}
