import 'dart:convert';
import 'package:http/http.dart';
import 'package:bloc_test/models/api_model.dart';

class UserRepository {
  final String url = 'https://reqres.in/api/users?page=2';

  Future<List<UserModel>> fetchPosts() async {
    var response = await get(Uri.parse(url));
    try {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } catch (error) {
      throw Exception(response.reasonPhrase);
    }
  }
}
