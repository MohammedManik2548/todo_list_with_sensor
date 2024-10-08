import 'app_exception.dart';

class InvalidUrlException extends AppException {
  InvalidUrlException([String? message])
      : super(message, "Request URL is not valid!");
}
