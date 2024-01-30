import '/service/api_client.dart';
class UserDataRepository {
  final ApiClient apiClient;

  UserDataRepository(this.apiClient);

  Future<dynamic> createUserData(dynamic data) async {
    return apiClient.post('users', data);
  }


}