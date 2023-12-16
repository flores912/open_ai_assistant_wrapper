import 'package:json_annotation/json_annotation.dart';


part 'retrieval_tool.g.dart';
@JsonSerializable()
class RetrievalTool {
  /// Represents a retrieval tool that can be used by the assistant.
  RetrievalTool({required this.type});

  /// The type of tool being defined, which is "retrieval".
  final String type;

  factory RetrievalTool.fromJson(Map<String, dynamic> json) =>
      _$RetrievalToolFromJson(json);

  Map<String, dynamic> toJson() => _$RetrievalToolToJson(this);
}
