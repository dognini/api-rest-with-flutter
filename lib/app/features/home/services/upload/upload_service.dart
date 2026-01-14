import 'dart:io';
import 'package:app_test_fiap/app/core/network/response_types/response.dart';

abstract class UploadService {
  Future<({Response result, String? imageUrl})> uploadImage(File imageFile);
}
