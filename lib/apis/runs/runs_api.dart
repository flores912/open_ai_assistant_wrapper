import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:open_ai_assistant_wrapper/tools/tool_enum.dart';

import '../../models/message_model.dart';
import '../../models/run_model.dart';
import '../../models/run_step_model.dart';


part 'runs_api.g.dart';


/// Class for interacting with the OpenAI Runs API.
class RunsApi {
  final String apiKey;
  final String apiUrl;

  /// Creates a [RunsApi] instance with the provided API key and optional API URL.
  ///
  /// [apiKey] (required) - The API key for authentication.
  /// [apiUrl] (optional) - The base URL for the API (default is 'https://api.openai.com/v1/threads').
  RunsApi({
    required this.apiKey,
    this.apiUrl = 'https://api.openai.com/v1/threads',
  });

  /// Headers used for API requests, including 'Content-Type' and 'Authorization'.
  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
    'OpenAI-Beta': 'assistants=v1',
  };


  /// Creates a run on the specified thread.
  ///
  /// [threadId] (required) - The ID of the thread to run.
  /// [request] (required) - The request object for creating the run.
  Future<Run> createRun({
    required String threadId,
    required CreateRunRequest request,
  }) async {
    final Uri uri = Uri.parse('$apiUrl/$threadId/runs');
    final response = await _sendRequest('POST', uri, body: request.toJson());
    return Run.fromJson(response);
  }

  /// Retrieves a run based on the provided [threadId] and [runId].
  ///
  /// [threadId] (required) - The ID of the thread where the run occurred.
  /// [runId] (required) - The ID of the run to retrieve.
  Future<Run> retrieveRun({
    required String threadId,
    required String runId,
  }) async {
    final Uri uri = Uri.parse('$apiUrl/$threadId/runs/$runId');
    final response = await _sendRequest('GET', uri);
    return Run.fromJson(response);
  }


  /// Modifies a run based on the provided [threadId] and [runId].
  ///
  /// [threadId] (required) - The ID of the thread where the run occurred.
  /// [runId] (required) - The ID of the run to modify.
  /// [metadata] (optional) - A map of key-value pairs to attach additional information to the run.
  Future<Run> modifyRun({
    required String threadId,
    required String runId,
    Map<String, dynamic>? metadata,
  }) async {
    final Uri uri = Uri.parse('$apiUrl/$threadId/runs/$runId');
    final Map<String, dynamic> requestBody = {
      if (metadata != null) 'metadata': metadata,
    };
    final response = await _sendRequest('POST', uri, body: requestBody);
    return Run.fromJson(response);
  }

  /// List runs belonging to a thread.
  ///
  /// This method retrieves a list of runs associated with a specific thread.
  ///
  /// [threadId] (required): The ID of the thread for which you want to list runs.
  /// [limit] (optional): Limit the number of runs returned (default is 20, max is 100).
  /// [order] (optional): Sort order for the runs by created_at timestamp (default is "desc" for descending).
  /// [after] (optional): A cursor to fetch the next page of runs (pagination).
  /// [before] (optional): A cursor to fetch the previous page of runs (pagination).
  Future<ListRunsResponse> listRuns(
      String threadId, {
        int? limit,
        String? order,
        String? after,
        String? before,
      }) async {
    final queryParams = <String, dynamic>{};
    if (limit != null) queryParams['limit'] = limit;
    if (order != null) queryParams['order'] = order;
    if (after != null) queryParams['after'] = after;
    if (before != null) queryParams['before'] = before;

    final url = Uri.https('api.openai.com', 'v1/threads/$threadId/runs', queryParams);
    final response = await _sendRequest('GET', url);
    return ListRunsResponse.fromJson(response);
  }

  /// Submits tool outputs to a run with the specified `threadId` and `runId`.
  ///
  /// The `toolOutputs` parameter should be a list of [ToolOutput] instances.
  Future<SubmitToolOutputsResponse> submitToolOutputsToRun({
    required String threadId,
    required String runId,
    required List<ToolOutput> toolOutputs,
  }) async {
    final Uri uri = Uri.parse('$apiUrl/$threadId/runs/$runId/submit_tool_outputs');
    final List<Map<String, dynamic>> toolOutputsJson =
    toolOutputs.map((output) => output.toJson()).toList();
    final Map<String, dynamic> requestBody = {
      'tool_outputs': toolOutputsJson,
    };
    final response = await _sendRequest('POST', uri, body: requestBody);
    return SubmitToolOutputsResponse.fromJson(response);
  }

  /// Cancels a run that is in progress.
  ///
  /// This method sends a request to the OpenAI API to cancel a run in progress.
  ///
  /// [threadId] - The ID of the thread to which the run belongs.
  /// [runId] - The ID of the run to cancel.
  Future<Run> cancelRun(String threadId, String runId) async {
    final url = '$apiUrl/$threadId/runs/$runId/cancel';
    final response = await _sendRequest('POST', Uri.parse(url));
    return Run.fromJson(response);
  }

  Future<Map<String, dynamic>> _sendRequest(String method, Uri url, {dynamic body}) async {
    final response = method == 'GET'
        ? await http.get(url, headers: headers)
        : await http.post(url, headers: headers, body: body != null ? jsonEncode(body) : null);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error $method request. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to $method');
    }
  }

  /// Creates a thread and runs it using the OpenAI API.
  ///
  /// [assistantId] (required) - The ID of the assistant to use for the run.
  /// [messages] (optional) - A list of messages to start the thread with.
  /// [model] (optional) - The ID of the Model to be used to execute this run. If provided, it overrides the model associated with the assistant.
  /// [instructions] (optional) - Override the default system message of the assistant.
  /// [tools] (optional) - Override the tools the assistant can use for this run.
  /// [metadata] (optional) - Set of 16 key-value pairs that can be attached to the run.
  ///
  /// Returns a [Run] object representing the created run.
  Future<Run> createThreadAndRun({
    required String assistantId,
    List<Message>? messages,
    String? model,
    String? instructions,
    List<String>? tools,
    Map<String, dynamic>? metadata,
  }) async {
    final Uri uri = Uri.parse('$apiUrl/threads/runs');
    final List<Map<String, dynamic>> messagesJson = messages?.map((message) => message.toJson()).toList() ?? [];
    final Map<String, dynamic> requestBody = {
      'assistant_id': assistantId,
      'thread': {
        'messages': messagesJson,
      },
      if (model != null) 'model': model,
      if (instructions != null) 'instructions': instructions,
      if (tools != null) 'tools': tools,
      if (metadata != null) 'metadata': metadata,
    };
    final response = await _sendRequest('POST', uri, body: requestBody);
    return Run.fromJson(response);
  }
  /// Retrieves a run step based on the provided [threadId], [runId], and [stepId].
  ///
  /// [threadId] (required) - The ID of the thread to which the run and run step belongs.
  /// [runId] (required) - The ID of the run to which the run step belongs.
  /// [stepId] (required) - The ID of the run step to retrieve.
  ///
  /// Returns a [RunStep] object representing the retrieved run step.
  ///
  /// Throws an [Exception] if the retrieval fails, with details on the error.
  Future<RunStep> retrieveRunStep({
    required String threadId,
    required String runId,
    required String stepId,
  }) async {
    // Create a URI for the API endpoint by combining the [apiUrl], [threadId], [runId], and [stepId].
    final Uri uri = Uri.parse('$apiUrl/threads/$threadId/runs/$runId/steps/$stepId');


    // Send a GET request to retrieve the run step from the OpenAI API.
    final response = await http.get(
      uri,
      headers: headers,
    );

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and create a [RunStep] object from it.
      final responseData = jsonDecode(response.body);
      return RunStep.fromJson(responseData);
    } else {
      // Handle errors by printing the status code and response body.
      print('Error retrieving run step. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Throw an exception with a message indicating the failure.
      throw Exception('Failed to retrieve run step');
    }
  }
  /// Lists run steps belonging to a specific run in an OpenAI thread.
  ///
  /// This method retrieves a list of run steps associated with a particular thread and run.
  ///
  /// [threadId] (required): The ID of the thread to which the run and run steps belong.
  /// [runId] (required): The ID of the run for which you want to list the run steps.
  /// [limit] (optional): A limit on the number of run steps to be returned (default is 20, max is 100).
  /// [order] (optional): Sort order by the created_at timestamp of the run steps (default is "desc" for descending).
  /// [after] (optional): A cursor for use in pagination to fetch the next page of run steps.
  /// [before] (optional): A cursor for use in pagination to fetch the previous page of run steps.
  ///
  /// Returns a [RunStepList] object containing the list of run steps.
  ///
  /// Throws an [Exception] if the retrieval fails, with details on the error.
  Future<RunStepList> listRunSteps(
      String threadId,
      String runId, {
        int limit = 20,
        String order = 'desc',
        String? after,
        String? before,
      }) async {
    // Construct the URL for the API request
    final baseUrl = '$apiUrl/threads/$threadId/runs/$runId/steps';
    final url = Uri.parse(baseUrl);

    // Send a GET request to retrieve the list of run steps
    final response = await http.get(
      url,
      headers: headers,
    );

    // Handle the response and deserialize it into a RunStepList object
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final runStepList = RunStepList.fromJson(jsonData);
      return runStepList;
    } else {
      throw Exception('Failed to list run steps');
    }
  }

}

class CreateRunRequest {
  final String assistantId;
  final String? model;
  final String? instructions;
  final List<Tool>? tools;
  final Map<String, dynamic>? metadata;

  CreateRunRequest({
    required this.assistantId,
    this.model,
    this.instructions,
    this.tools,
    this.metadata,
  });

  /// Converts this instance of [CreateRunRequest] to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'assistant_id': assistantId,
      if (model != null) 'model': model,
      if (instructions != null) 'instructions': instructions,
      if (tools != null) 'tools': tools!.map((tool) => toolToJson(tool)).toList(),
      if (metadata != null) 'metadata': metadata,
    };
    return data;
  }

  Map<String, dynamic> toolToJson(Tool tool) {
    switch (tool) {
      case Tool.codeInterpreter:
        return {'type': 'code_interpreter'};
      case Tool.retrieval:
        return {'type': 'retrieval'};
      case Tool.function:
        return {'type': 'function'};
    }
  }
}

@JsonSerializable()
/// Represents the response object for listing runs.
class ListRunsResponse {
  /// The object type, which is always "list".
  final String object;

  /// A list of run objects.
  final List<Run> data;

  /// The ID of the first run in the list.
  final String firstId;

  /// The ID of the last run in the list.
  final String lastId;

  /// Indicates if there are more runs available.
  final bool hasMore;

  ListRunsResponse({
    required this.object,
    required this.data,
    required this.firstId,
    required this.lastId,
    required this.hasMore,
  });

  /// Factory method to create a ListRunsResponse from a JSON map.
  factory ListRunsResponse.fromJson(Map<String, dynamic> json) =>
      _$ListRunsResponseFromJson(json);

  /// Convert this instance of ListRunsResponse to a JSON map.
  Map<String, dynamic> toJson() => _$ListRunsResponseToJson(this);
}
/// Represents a response object for submitting tool outputs.
/// Represents a response object for submitting tool outputs.
class SubmitToolOutputsResponse {
  final Run run;

  SubmitToolOutputsResponse({required this.run});

  factory SubmitToolOutputsResponse.fromJson(Map<String, dynamic> json) {
    return SubmitToolOutputsResponse(run: Run.fromJson(json));
  }
}



/// Represents a tool output item.
class ToolOutput {
  final String? toolCallId;
  final String? output;

  ToolOutput({
    this.toolCallId,
    this.output,
  });

  factory ToolOutput.fromJson(Map<String, dynamic> json) {
    return ToolOutput(
      toolCallId: json['tool_call_id'],
      output: json['output'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tool_call_id': toolCallId,
      'output': output,
    };
  }
}