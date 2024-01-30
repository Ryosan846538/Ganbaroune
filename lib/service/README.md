# API Client ドキュメント

APIを呼ぶためのモジュールの作り方

①テーブル名の単数形_data_repository.dartを作成する

②このようにメソッドを呼び出す機構を各APIごとに作成する

```
 //getの例
 Future<dynamic> getUserData(String userId) async {
   return apiClient.get('users/$userId');
 } 
 
//post の例
Future<dynamic> createUserData(dynamic data) async {
    return apiClient.post('users', data);
  }
  
//putの例
 Future<dynamic> updateUserData(String userId, dynamic data) async {
    return apiClient.put('users/$userId', data);
 }
 
//deleteの例
 Future<dynamic> deleteUserData(String userId) async {
    return apiClient.delete('users/$userId');
 }
```

③このようにしてアプリで呼び出し、値を受け取ることができる

```
//getの例
Future<void> fetchUserData(String userId) async {
  try {
    final data = await userDataRepository.getUserData(userId);
    // データの受け取りと処理
    print('User Data: $data');
  } catch (error) {
    // エラーハンドリング
    print('Error: $error');
  }
}

// postの例
Future<void> createNewUserData() async {
  try {
    dynamic newData = {/* ポストするデータ */};
    final createdData = await userDataRepository.createUserData(newData);
    // データの受け取りと処理
    print('Created User Data: $createdData');
  } catch (error) {
    // エラーハンドリング
    print('Error: $error');
  }
}

// putの例
Future<void> updateExistingUserData(String userId) async {
  try {
    dynamic updatedData = {/* 更新するデータ */};
    final updatedUserData = await userDataRepository.updateUserData(userId, updatedData);
    // データの受け取りと処理
    print('Updated User Data: $updatedUserData');
  } catch (error) {
    // エラーハンドリング
    print('Error: $error');
  }
}

// deleteの例
Future<void> deleteUserData(String userId) async {
  try {
    final deletedData = await userDataRepository.deleteUserData(userId);
    // データの受け取りと処理
    print('Deleted User Data: $deletedData');
  } catch (error) {
    // エラーハンドリング
    print('Error: $error');
  }
}

```

