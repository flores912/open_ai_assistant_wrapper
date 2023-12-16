import 'package:json_annotation/json_annotation.dart';

part 'code_interpreter_tool.g.dart';

@JsonSerializable()
class CodeInterpreterTool {
  /// Represents a code interpreter tool that can be used by the assistant.
  CodeInterpreterTool({required this.type});

  /// The type of tool being defined, which is "code_interpreter".
  final String type;

  factory CodeInterpreterTool.fromJson(Map<String, dynamic> json) =>
      _$CodeInterpreterToolFromJson(json);

  Map<String, dynamic> toJson() => _$CodeInterpreterToolToJson(this);
}
