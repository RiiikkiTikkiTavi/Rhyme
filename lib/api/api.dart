import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/models.dart';

part 'api.g.dart';

@RestApi(baseUrl: '')
abstract class RhymerApiClient {
  factory RhymerApiClient(Dio dio, {String? baseUrl}) = _RhymerApiClient;

  @GET('/rhymes/get')
  Future<List<Rhymes>> getRhymesList(@Query('word') String word);
}
