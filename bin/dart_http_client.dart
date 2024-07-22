import 'package:dart_http_client/dart_http_client.dart' as dart_world;

Future<void> main(List<String> arguments) async {
  var response = await dart_world.getTest();

  final value = switch (response) {
    dart_world.Success(value: final value) => value,
    dart_world.Failure(exception: final e) => throw e,
  };

  print(value);
}
