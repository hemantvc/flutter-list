import 'package:uno_project/constants/api_constant.dart';
import 'package:uno_project/listener/server_response_listener.dart';
import 'package:http/http.dart';
import 'package:uno_project/constants/app_constant.dart';

/// HttpService for all web api calling, web api related root path, headers pass from here

class HttpService {
  static const String _baseUrl = ApiConstant.API_BASE_URL;

  static const String _contentTypeApplicationJson = 'application/json';

  // device related web api
  static const String _allPosts = "/posts";
  static const String _postsComments = "/comments?postId=:postId";

  static _getHeader() {
    Map<String, String> headers = {
      ApiConstant.HEADER_NAME_CONTENT_TYPE: _contentTypeApplicationJson,
    };
    return headers;
  }

  /// all post web api call
  /// [listener] server response listener for separated response by status code
  static callAllPost(ServerResponseListener listener) async {
    var url = Uri.parse(_baseUrl + _allPosts);
    Response response = await get(url, headers: _getHeader());
    _handleResponseByError(response, null, listener);
  }

  /// posts comments web api call
  ///
  /// [listener] server response listener for separated response by status code
  static callPostsComments(int postId, ServerResponseListener listener) async {
    var url =
        Uri.parse(_baseUrl + _postsComments.replaceAll(":postId", "$postId"));
    Response response = await get(url, headers: _getHeader());
    _handleResponseByError(response, null, listener);
  }

  /// handle response by error
  /// [response] response from web api
  /// [response] requestBody sent on web api
  /// [listener] server response listener for separated response by status code
  static _handleResponseByError(
      Response response, String? requestBody, ServerResponseListener listener) {
    // print request response in log
    printMessage("/////////// Request ///////////");
    printMessage("url : ${response.request!.url}");
    printMessage("method : ${response.request!.method}");
    printMessage("headers : ${response.request!.headers}");
    printMessage("body : ${requestBody == null ? "" : requestBody}");
    printMessage("/////////// Request ///////////");

    printMessage("/////////// Response ///////////");
    printMessage("url : ${response.request!.url}");
    printMessage("status code : ${response.statusCode}");
    printMessage("body : ${response.body != null ? response.body.toString() : ""}");
    printMessage("/////////// Response ///////////");

    if (response.statusCode == ApiConstant.STATUS_CODE_OK ||
        response.statusCode == ApiConstant.STATUS_CODE_OK_1) {
      if (listener != null) {
        try {
          listener.onResponse(response.body);
        } catch (e) {
          printMessage(e);
        }
      }
    } else if (response.statusCode == ApiConstant.STATUS_CODE_UNAUTHORIZED) {
      if (listener != null) {
        try {
          listener.onUnauthorizedError(response.body);
        } catch (e) {
          printMessage(e);
        }
      }
    } else if (response.statusCode == ApiConstant.STATUS_CODE_BAD_REQUEST) {
      if (listener != null) {
        try {
          listener.onError(response.body);
        } catch (e) {
          printMessage(e);
        }
      }
    } else if (response.statusCode == ApiConstant.STATUS_CODE_NOT_FOUND) {
      if (listener != null) {
        try {
          listener.onError(response.body);
        } catch (e) {
          printMessage(e);
        }
      }
    } else if (response.statusCode ==
        ApiConstant.STATUS_CODE_CONNECTION_ERROR) {
      if (listener != null) {
        try {
          listener.onConnectionError(
              "No Internet. Please check your network status and try again.");
        } catch (e) {
          printMessage(e);
        }
      }
    } else {
      if (listener != null) {
        try {
          listener.onFailure(response.body);
        } catch (e) {
          printMessage(e);
        }
      }
    }
  }
}

printMessage(Object message) {
  if (AppConstant.IS_DEBUG) {
    print(message);
  } 
}
