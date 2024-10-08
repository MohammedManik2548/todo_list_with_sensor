// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:dokan/core/common/models/models.dart';
// import 'package:dokan/data/exceptions/exceptions.dart';
// import 'package:dokan/data/network/networks.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
//
// class NetworkApiService extends BaseApiServices {
//   final _deviceStorage = GetStorage();
//
//   @override
//   Future getApi(String url, {bool isUrlEncoded = false, bool passToken = false,}) async {
//     dynamic responseJson;
//     Map<String, String>? headers;
//
//     try {
//       headers = await returnHeaders(
//         passToken: passToken,
//         isUrlEncoded: isUrlEncoded,
//       );
//
//       final response = await http
//           .get(
//             Uri.parse(url),
//             headers: headers,
//           )
//           .timeout(const Duration(seconds: 10));
//
//       responseJson = returnResponse(response);
//     } on SocketException {
//       throw InternetException(
//           'Please enable data or wifi connection to continue!');
//     } on RequestTimeoutException {
//       throw RequestTimeoutException('Request Timeout!');
//     } on FormatException catch (e) {
//       throw AppFormatException(e.message);
//     } on PlatformException catch (e) {
//       throw AppPlatformException(e.code).message;
//     }
//
//     return responseJson;
//   }
//
//   @override
//   Future postApi(String url, dynamic data, {bool isUrlEncoded = false, bool passToken = false,}) async {
//     dynamic responseJson;
//
//     Map<String, String>? headers;
//
//     try {
//       headers = await returnHeaders(
//         passToken: passToken,
//         isUrlEncoded: isUrlEncoded,
//       );
//
//       final response = await http
//           .post(
//             Uri.parse(url),
//             body: returnConvertedData(data: data, isUrlEncoded: isUrlEncoded),
//             headers: headers,
//           )
//           .timeout(const Duration(seconds: 10));
//
//       responseJson = returnResponse(response);
//     } on SocketException {
//       throw InternetException(
//           'Please enable data or wifi connection to continue!');
//     } on RequestTimeoutException {
//       throw RequestTimeoutException('Request Timeout!');
//     } on FormatException catch (e) {
//       throw AppFormatException(e.message);
//     } on PlatformException catch (e) {
//       throw AppPlatformException(e.code).message;
//     }
//
//     return responseJson;
//   }
//
//   @override
//   Future putApi(String url, dynamic data, {bool isUrlEncoded = false, bool passToken = false,}) async {
//     dynamic responseJson;
//
//     Map<String, String>? headers;
//
//     try {
//       headers = await returnHeaders(
//         passToken: passToken,
//         isUrlEncoded: isUrlEncoded,
//       );
//
//       final response = await http
//           .put(
//             Uri.parse(url),
//             body: returnConvertedData(data: data, isUrlEncoded: isUrlEncoded),
//             headers: headers,
//           )
//           .timeout(const Duration(seconds: 10));
//
//       responseJson = returnResponse(response);
//     } on SocketException {
//       throw InternetException(
//         'Please enable data or wifi connection to continue!',
//       );
//     } on RequestTimeoutException {
//       throw RequestTimeoutException('Request Timeout!');
//     } on FormatException catch (e) {
//       throw AppFormatException(e.message);
//     } on PlatformException catch (e) {
//       throw AppPlatformException(e.code).message;
//     }
//
//     return responseJson;
//   }
//
//   dynamic returnResponse(http.Response response) {
//     if (kDebugMode) {
//       log(' - ${response.request?.method} : ${response.request?.url} : ${response.statusCode}',
//           name: 'API');
//     }
//
//     switch (response.statusCode) {
//       case 200:
//         dynamic responseJson = jsonDecode(response.body);
//         return responseJson;
//       case 400:
//         dynamic responseJson = jsonDecode(response.body);
//         CommonErrorResponseModel responseModel =
//             CommonErrorResponseModel.fromJson(responseJson);
//         throw BadRequestExceptions(responseModel.message);
//       case 401:
//         dynamic responseJson = jsonDecode(response.body);
//         CommonErrorResponseModel responseModel =
//             CommonErrorResponseModel.fromJson(responseJson);
//         throw BadRequestExceptions(responseModel.message);
//       default:
//         throw FetchDataException(
//           'Error occurred while communicating with server: ${response.statusCode}',
//         );
//     }
//   }
//
//   dynamic returnConvertedData({dynamic data, bool isUrlEncoded = false,}) {
//     return data != null ? (isUrlEncoded ? data : jsonEncode(data)) : null;
//   }
//
//   dynamic returnHeaders({
//     bool passToken = false,
//     bool isUrlEncoded = false,
//   }) async {
//     Map<String, String> headers = {};
//
//     if (passToken) {
//       String? token = _deviceStorage.read('token');
//       if (token != null && token != '') {
//         headers["Authorization"] = 'Bearer $token';
//       }
//     }
//
//     if (isUrlEncoded) {
//       headers['Content-Type'] = 'application/x-www-form-urlencoded';
//       headers['Accept'] = 'application/json';
//     } else {
//       headers['Content-Type'] = 'application/json';
//       headers['Accept'] = 'application/json';
//     }
//
//     /*headers['User-Agent'] = Platform.isAndroid
//         ? 'AndOS-App'
//         : Platform.isIOS
//             ? 'IOS-App'
//             : '';*/
//
//     return headers;
//   }
// }
