import 'package:json_annotation/json_annotation.dart';

/// An enum representing the roles of entities in messages.
///
/// - [user]: Represents the role of a user.
/// - [assistant]: Represents the role of an assistant.
enum Role {
  /// Represents the role of a user.
  @JsonValue('user')
  user,

  /// Represents the role of an assistant.
  @JsonValue('assistant')
  assistant,
}
