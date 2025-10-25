import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/models.dart';

part 'api.g.dart';

@RestApi(baseUrl: '')
abstract class RhymerApiClient {
  factory RhymerApiClient(Dio dio, {String? baseUrl}) = _RhymerApiClient;

  factory RhymerApiClient.create({String? apiUrl, String? apiKey}) {
    // final apiURL = dotenv.env['API_URL'];
    //final apiKey = dotenv.env['API_KEY'];
    final dio = Dio(
      BaseOptions(
        headers: {'x-api-key': apiKey},
        responseType: ResponseType.json,
      ),
    );
    // используется, чтобы соответствовало API из видео
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          if (response.data is List) {
            response.data = {'words': response.data};
          }
          handler.next(response);
        },
      ),
    );
    if (apiUrl != null) {
      return RhymerApiClient(dio, baseUrl: apiUrl);
    }
    return RhymerApiClient(dio);
  }

  @GET('rhyme')
  Future<Rhymes> getRhymesList(@Query('word') String word);
}
