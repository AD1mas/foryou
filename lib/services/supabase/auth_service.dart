import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Session? get session => supabase.auth.currentSession;
  User? get user => supabase.auth.currentUser;

  Stream<AuthState> get onAuthStateChange => supabase.auth.onAuthStateChange;

  Future<void> signUp(String email, String password) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
