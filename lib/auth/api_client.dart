import 'package:ab_project/models/message.dart';
import 'package:ab_project/models/post.dart';
import 'package:ab_project/models/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: 'http://flutterapi.local/api/')

abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/user')
  Future<Message> register(@Body() User user);

  @POST('/login')
  Future<Message> login(@Body() User user);

  @GET('/posts')
  Stream<List<Post>> getAllPosts(@Header('Authorization') String authApi);

  @POST('/post')
  Future<Message> createPost(@Header('Authorization') String authApi , @Body() Post post);

  @GET('/post/{id}')
  Future<Post> getPostById(@Header('Authorization') String authApi, @Path() int id);

  @POST('/posts/{id}')
  Future<Message> updatePost(@Header('Authorization') String authApi, @Body() Post post, @Path() int id);
}
