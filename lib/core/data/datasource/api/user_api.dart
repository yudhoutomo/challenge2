import 'package:challenge2/core/data/model/profile/profile/profile.dart';
import 'package:challenge2/gen/core/data/model/addrequest/add_request/add_request.dart';
import 'package:challenge2/gen/core/data/model/note/note/note.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import '../../../../gen/core/data/model/login/login/login.dart';
import '../../model/api_response.dart';
import '../../model/user.dart';
part '../../../../gen/core/data/datasource/api/user_api.g.dart';

@RestApi()
@Injectable() // dependensi yang diperlukan oleh kelas dengan anotasi injectable akan diresolve otomatis
abstract class UserApi {
  @factoryMethod // diperlukan anotasi factoryMethod jika objek dibuat menggunakan factory
  factory UserApi(Dio dio) = _UserApi;

  // sisanya sama persis seperti retrofit di android
  @GET('/user/{id}')
  Future<ApiResponse<User>> getUser(@Path('id') String userId);

  @POST('/api/user/login?expired=0')
  @FormUrlEncoded()
  Future<ApiResponse<Login>> login(
      @Field('email') String email, @Field('password') String password);

  @GET('/api/note/')
  Future<ApiResponse<List<Note>>> getNote();

  @GET('/api/user/profile')
  Future<ApiResponse<Profile>> getProfile();

  @POST('/api/note/')
  @FormUrlEncoded()
  Future<ApiResponse<AddRequest>> addNote(
      @Field('title') String title, @Field('content') String content);

  @POST('/api/user')
  @FormUrlEncoded()
  Future<ApiResponse<AddRequest>> addUser(@Field('name') String name,
      @Field('email') String email, @Field('password') String password);

  @PATCH('/api/note/{id}')
  @FormUrlEncoded()
  Future<ApiResponse<AddRequest>> updateNote(@Path('id') String id,
      @Field('title') String title, @Field('content') String content);

  @DELETE('/api/note/{id}')
  @FormUrlEncoded()
  Future<ApiResponse<AddRequest>> deleteNote(@Path('id') String id);
}
