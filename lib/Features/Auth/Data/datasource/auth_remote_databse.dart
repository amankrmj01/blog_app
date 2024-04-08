import 'package:blog_app/Core/error/exceptionss.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithUsernameAndPassword({
    required String email,
    required String name,
    required String password,
  });

  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(password: password,email: email);
      return response.user!.id;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<String> signUpWithUsernameAndPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerException(message: 'User is null!');
      }
      return response.user!.id; // or return response.user!.email;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

}
