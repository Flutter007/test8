import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

final supaBase = Supabase.instance.client;

final selectedShopLogo = StateProvider<File?>((ref) => null);
final selectedCardFrontSide = StateProvider<File?>((ref) => null);
final selectedCardBackSide = StateProvider<File?>((ref) => null);

class ImageUploadProvider extends AsyncNotifier<void> {
  @override
  build() {}

  Future<void> uploadImage(File? image, String? fileName, String folder) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await supaBase.storage.from('images/$folder').update(fileName!, image!);
    });
  }

  String getImageURL(String folder, String fileName) {
    final url = supaBase.storage.from('images/$folder').getPublicUrl(fileName);
    return url;
  }
}

Future<void> upload(
  File? file,
  String folder,
  String? fileName,
  WidgetRef ref,
) async {
  await ref
      .read(imageUploadProvider.notifier)
      .uploadImage(file, fileName, folder);
}

final imageUploadProvider = AsyncNotifierProvider<ImageUploadProvider, void>(
  ImageUploadProvider.new,
);
String? fileNameGetter(File? file) {
  final now = DateTime.now();
  if (file == null) return null;
  return '${now.microsecondsSinceEpoch}${path.extension(file.path)}';
}
