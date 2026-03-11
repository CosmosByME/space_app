import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:space_app/domain/services/token_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  static const _folderUser = "user_images";
  static const _folderPost = "post_images";
  static const _bucketName = "images";

  static Future<String> uploadUserImage(File image) async {
    await dotenv.load(fileName: ".env");
    final storage = SupabaseClient(
      dotenv.env["SUPABASE_URL"]!,
      dotenv.env["SUPABASE_SERVICE_KEY"]!,
    ).storage;
    final String uid = await TokenService.readToken();
    final String imgPath =
        "$_folderUser/${uid}_${DateTime.now().toIso8601String()}";

    await storage
        .from(_bucketName)
        .upload(imgPath, image, fileOptions: const FileOptions(upsert: true));

    final String downloadUrl = storage.from(_bucketName).getPublicUrl(imgPath);

    print(downloadUrl);
    return downloadUrl;
  }

  static Future<String> uploadPostImage(File image) async {
    await dotenv.load(fileName: ".env");
    final storage = SupabaseClient(
      dotenv.env["SUPABASE_URL"]!,
      dotenv.env["SUPABASE_SERVICE_KEY"]!,
    ).storage;
    final String uid = await TokenService.readToken();
    final String imgPath =
        "$_folderPost/${uid}_${DateTime.now().millisecondsSinceEpoch}";

    await storage
        .from(_bucketName)
        .upload(imgPath, image, fileOptions: const FileOptions(upsert: false));

    final String downloadUrl = storage.from(_bucketName).getPublicUrl(imgPath);

    print(downloadUrl);
    return downloadUrl;
  }
}
