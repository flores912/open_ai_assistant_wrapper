

import 'package:json_annotation/json_annotation.dart';
part 'thread_model.g.dart';

/// Represents a thread that contains messages.
@JsonSerializable()
class Thread {
  /// The unique identifier for the thread.
  final String id;

  /// The object type, which is always "thread".
  final String object = 'thread';

  /// The Unix timestamp (in seconds) for when the thread was created.
  final int created_at;

  /// A set of key-value pairs that can be attached to the thread for additional information.
  final Map<String, dynamic> metadata;

  /// Creates a new [Thread] instance.
  ///
  /// [id] (required) - The unique identifier for the thread.
  /// [created_at] (required) - The Unix timestamp (in seconds) for when the thread was created.
  /// [metadata] (required) - A set of key-value pairs for additional information about the thread.
  Thread({
    required this.id,
    required this.created_at,
    required this.metadata,
  });

  /// Creates an instance of [Thread] from a JSON map.
  ///
  /// [json] - A JSON map representing the Thread object.
  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      id: json['id'],
      created_at: json['created_at'],
      metadata: json['metadata'],
    );
  }
}
