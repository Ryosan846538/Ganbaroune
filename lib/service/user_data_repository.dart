import '/service/api_client.dart';
class UserDataRepository {
  final ApiClient apiClient;

  UserDataRepository(this.apiClient);

  Future<dynamic> createUserData(dynamic data) async {
    return apiClient.post('user/create', data);
  }

  Future<dynamic> getFriendName(String name) async {
    return apiClient.get('user/friend/$name');
  }

  Future<dynamic> postLogin(dynamic data) async {
    return apiClient.post('user/login', data);
  }

  Future<dynamic> postLoginStatus(dynamic data) async {
    return apiClient.post('user/login/status', data);
  }

  Future<dynamic> postLoginTime(dynamic data) async {
    return apiClient.post('user/login/time', data);
  }
}