import 'package:ab_project/models/message.dart';
import 'package:ab_project/models/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: 'http://flutterapi.local/api/')

abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/user')
  Future<Message> register(@Body() User user);
}
