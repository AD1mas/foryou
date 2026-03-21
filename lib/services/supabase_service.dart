import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<void> saveMessage(String role, String content) async {
    await supabase.from('messages').insert({'role': role, 'content': content});
  }

  Future<List<Map<String, dynamic>>> getMessages() async {
    final data = await supabase
        .from('messages')
        .select()
        .order('created_at', ascending: true);

    return data;
  }

  Stream<List<Map<String, dynamic>>> subscribeToMessages() {
    return supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: true);
  }
}
