import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

final selectedShopLogo = StateProvider<File?>((ref) => null);
final selectedCardFrontSide = StateProvider<File?>((ref) => null);
final selectedCardBackSide = StateProvider<File?>((ref) => null);
String getImageURL(String table, String fileName) {
  final supaBase = Supabase.instance.client;
  final url = supaBase.storage.from('images/$table').getPublicUrl(fileName);
  return url;
}

String? fileNameGetter(File? file) {
  final now = DateTime.now();
  if (file == null) return null;
  return '${now.microsecondsSinceEpoch}${path.extension(file.path)}';
}
