import '/service/api_client.dart';
class StudyNoteDataRepository {
  final ApiClient apiClient;

  StudyNoteDataRepository(this.apiClient);

  Future<dynamic> postStudyNoteAdd(dynamic data) async {
    return apiClient.post('studynote/add', data);
  }

  Future<dynamic> postStudyNoteDate(dynamic data) async {
    return apiClient.post('studynote/date', data);
  }

  Future<dynamic> postStudyNoteTime(dynamic data) async {
    return apiClient.post('studynote/time', data);
  }

  Future<dynamic> postStudyNoteGoal(dynamic data) async {
    return apiClient.post('studynote/goal', data);
  }
}