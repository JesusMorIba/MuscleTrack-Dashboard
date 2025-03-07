import 'dart:typed_data';
import 'package:cloudinary/cloudinary.dart';
import 'package:muscletrack_admin_dashboard/models/local/upload_preset.dart';
import 'package:muscletrack_admin_dashboard/services/environment_service.dart';

class CloudinaryApi {
  static Cloudinary? cloudinary;

  static void configureCloudinary() {
    final String cloudName = Environment.cloudName;

    cloudinary = Cloudinary.unsignedConfig(cloudName: cloudName);
  }

  static Future<String> uploadImage(
      Uint8List imageBytes, UploadPreset preset) async {
    try {
      if (cloudinary == null) {
        throw Exception('Cloudinary not configured.');
      }

      CloudinaryResponse response = await cloudinary!.unsignedUpload(
        fileBytes: imageBytes,
        resourceType: CloudinaryResourceType.image,
        uploadPreset: preset.name,
      );

      if (response.isSuccessful) {
        return response.secureUrl!;
      } else {
        throw Exception('Image upload failed: ${response.error}');
      }
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  static Future<void> deleteImage(String publicId) async {
    try {
      if (cloudinary == null) {
        throw Exception('Cloudinary not configured.');
      }

      CloudinaryResponse response = await cloudinary!.destroy(publicId);

      if (!response.isSuccessful) {
        throw Exception('Image deletion failed: ${response.error}');
      }
    } catch (e) {
      throw Exception('Error deleting image: $e');
    }
  }
}
