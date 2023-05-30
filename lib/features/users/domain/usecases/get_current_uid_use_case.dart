import 'package:flutter_project_app/features/users/domain/repositories/user_firebase_repository.dart';

class GetCurrentUidUseCase {
  final UserFirebaseRepository repository;

  GetCurrentUidUseCase({required this.repository});

  Future<String> call() async {
    return repository.getCurrentUid();
  }
}
