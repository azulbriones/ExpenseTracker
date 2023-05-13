import 'package:flutter_project_app/features/users/domain/repositories/firebase_repository.dart';

class GetCreateCurrentUser {
  final FirebaseRepository firebaseRepository;

  GetCreateCurrentUser({required this.firebaseRepository});

  Future<void> call(String email, String username, String image) async {
    firebaseRepository.getCreateCurrentUser(email, username, image);
  }
}
