import 'package:json_annotation/json_annotation.dart';
part 'function_tool.g.dart';

@JsonSerializable()
class FunctionTool {
  /// Represents a function tool that can be used by the assistant.
  FunctionTool({
    required this.type,
    required this.description,
    required this.name,
    required this.parameters,
  });

  /// The type of tool being defined, which is "function".
  final String type;

  /// A description of what the function does, used by the model to choose when and how to call the function.
  final String description;

  /// The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64.
  final String name;

  /// The parameters the function accepts, described as a JSON Schema object.
  final Map<String, dynamic> parameters;

  factory FunctionTool.fromJson(Map<String, dynamic> json) =>
      _$FunctionToolFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionToolToJson(this);
}
