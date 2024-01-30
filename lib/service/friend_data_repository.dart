import '/service/api_client.dart';
class FriendDataRepository {
  final ApiClient apiClient;

  FriendDataRepository(this.apiClient);

  Future<dynamic> getFriendName(String myName) async {
    return apiClient.get('friend/search/$myName');
  }

  Future<dynamic> postFriendDelete(dynamic data) async {
    return apiClient.post('friend/delete', data);
  }

  Future<dynamic> postFriendAdd(dynamic data) async {
    return apiClient.post('friend/add', data);
  }
}