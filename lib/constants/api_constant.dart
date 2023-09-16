/// ApiConstant class making for web api constant key value store.

class ApiConstant {
  //Request timeouts
  static const int CONNECTION_TIMEOUT = 60; //in sec
  static const int READ_TIMEOUT = 60; //in sec

  ///Api Status codes
  static const int STATUS_CODE_OK = 200;
  static const int STATUS_CODE_OK_1 = 201;
  static const int STATUS_CODE_UNAUTHORIZED = 401;
  static const int STATUS_CODE_BAD_REQUEST = 403;
  static const int STATUS_CODE_NOT_FOUND = 404;
  static const int STATUS_CODE_CONNECTION_ERROR = -101;

  /// API Call Details
  static const String API_BASE_URL = "https://jsonplaceholder.typicode.com";

  ///request headers
  static const String HEADER_NAME_CONTENT_TYPE = "Content-Type";

  /// body parameters key for post comment
  static const String KEY_POSTID = "postId";

}
