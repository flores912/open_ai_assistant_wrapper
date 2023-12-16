import 'package:json_annotation/json_annotation.dart';

enum Tool {
  @JsonValue('code_interpreter')
  /// Represents a code interpreter tool that can be used by the assistant.
  codeInterpreter,
  @JsonValue('retrieval')
  /// Represents a retrieval tool that can be used by the assistant.
  retrieval,
  @JsonValue('function')
  /// Represents a function tool that can be used by the assistant.
  function,
}
