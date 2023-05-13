import 'package:flutter_project_app/features/users/domain/repositories/firebase_repository.dart';

class GetCurrentUidUseCase {
  final FirebaseRepository repository;

  GetCurrentUidUseCase({required this.repository});

  Future<String> call() async => await repository.getCurrentUid();
}
