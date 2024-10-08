import 'app_exception.dart';

class RequestTimeoutException extends AppException {
  RequestTimeoutException([String? message])
      : super(message, "Request Timeout");
}
