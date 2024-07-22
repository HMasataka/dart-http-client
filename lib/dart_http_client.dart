import 'dart:convert';
import 'package:http/http.dart' as http;

sealed class Result<S, E extends Exception> {
  const Result();
}

final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;
}

Future<Result<Map<String, dynamic>, Exception>> getTest() async {
  var client = http.Client();

  var data = {'title': 'My first post'};

  try {
    var response = await client.post(
      Uri.parse('http://localhost:8080/'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(data),
    );
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    return Success(decodedResponse);
  } on Exception catch (e) {
    return Failure(e);
  } finally {
    client.close();
  }
}
