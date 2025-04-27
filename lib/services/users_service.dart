import 'package:chat_app_2/models/user.dart';
import 'package:chat_app_2/models/users_response.dart';
import 'package:chat_app_2/services/auth_service.dart';
import 'package:chat_app_2/services/environments.dart';
import 'package:http/http.dart' as http;

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse('${Environments.apiURL}/users'),
        headers: {'x-token': await AuthService.getToken() ?? ''},
      );

      return usersResponseFromJson(response.body).users;
    } catch (error) {
      return [];
    }
  }
}
