
/// ServerResponseListener for handle server response by error code and message
class ServerResponseListener {
  /// when getting -101 code to fire this method
  final void Function(String message) onConnectionError;

  /// when getting 200 or 201 code to fire this method
  final void Function(dynamic response) onResponse;

  /// not sure for status code to fire this method
  final void Function(dynamic response) onFailure;

  /// when getting 403 code to fire this method
  final void Function(dynamic response) onError;

  /// when getting 401 code to fire this method
  final void Function(dynamic response) onUnauthorizedError;

  ServerResponseListener(
      {required this.onConnectionError,
      required this.onResponse,
      required this.onFailure,
      required this.onError,
      required this.onUnauthorizedError});
}
