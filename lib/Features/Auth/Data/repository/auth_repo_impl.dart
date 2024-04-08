import 'package:blog_app/Core/error/exceptionss.dart';
import 'package:blog_app/Core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../../Domain/repository/auth_repository.dart';
import '../datasource/auth_remote_databse.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, String>> signInWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final userId = await authRemoteDataSource.signUpWithUsernameAndPassword(
        email: email,
        name: name,
        password: password,
      );
      return right(userId);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
