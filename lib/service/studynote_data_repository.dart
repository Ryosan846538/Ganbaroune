import '/service/api_client.dart';
class StudyNoteDataRepository {
  final ApiClient apiClient;

  StudyNoteDataRepository(this.apiClient);

  Future<dynamic> postStudyNoteAdd(dynamic data) async {
    return apiClient.post('studynote/add', data);
  }

  Future<dynamic> getStudyNoteShow(String username) async {
    return apiClient.get('studynote/show/$username');
  }
}