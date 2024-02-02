import '/service/api_client.dart';
class ReactionDataRepository {
  final ApiClient apiClient;

  ReactionDataRepository(this.apiClient);

  Future<dynamic> getReactionName(String myName) async {
    return apiClient.get('reaction/search/$myName');
  }

  Future<dynamic> postReactionAdd(dynamic data) async {
    return apiClient.post('reaction/add', data);
  }
}