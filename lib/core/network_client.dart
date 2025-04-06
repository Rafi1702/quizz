import 'package:http/http.dart' as http;
import 'package:quizz/core/const.dart';

class MyClient extends http.BaseClient {
  final http.Client _httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    var defaultHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-api-key': key ?? 'none',
    };

    request.headers.addAll(defaultHeaders);

    return _httpClient.send(request).timeout(const Duration(seconds: 3));
  }
}
