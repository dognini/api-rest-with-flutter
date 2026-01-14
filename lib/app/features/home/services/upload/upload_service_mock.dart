import 'dart:io';
import 'dart:math';

import 'package:app_test_fiap/app/core/network/response_types/response.dart';
import 'package:app_test_fiap/app/features/home/services/upload/upload_service.dart';

class UploadServiceMock implements UploadService {
  // Lista de URLs de imagens de exemplo do Unsplash para simular uploads
  static final List<String> _mockImageUrls = [
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
    'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=400',
    'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
    'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=400',
    'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400',
    'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
    'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400',
    'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=400',
    'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=400',
    'https://images.unsplash.com/photo-1571415060382-e2feee14a51e?w=400',
    'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=400',
    'https://images.unsplash.com/photo-1607853202273-797f1c22a38e?w=400',
    'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400',
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
    'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400',
    'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400',
    'https://images.unsplash.com/photo-1503602642458-232111445657?w=400',
    'https://images.unsplash.com/photo-1526947425960-945c6e72858f?w=400',
    'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400',
  ];

  @override
  Future<({Response result, String? imageUrl})> uploadImage(
      File imageFile) async {
    // Simula delay de upload (mais longo que operações normais)
    await Future.delayed(const Duration(milliseconds: 1500));

    try {
      // Verifica se o arquivo existe (validação básica)
      if (!imageFile.existsSync()) {
        return (
          result: GeneralFailure(message: 'Arquivo de imagem não encontrado'),
          imageUrl: null
        );
      }

      // Simula validação de tipo de arquivo
      final fileName = imageFile.path.toLowerCase();
      final validExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];
      final hasValidExtension =
          validExtensions.any((ext) => fileName.endsWith(ext));

      if (!hasValidExtension) {
        return (
          result: GeneralFailure(
              message:
                  'Formato de arquivo não suportado. Use: ${validExtensions.join(', ')}'),
          imageUrl: null
        );
      }

      // Simula verificação de tamanho do arquivo (máximo 5MB)
      final fileSizeInBytes = await imageFile.length();
      const maxSizeInBytes = 5 * 1024 * 1024; // 5MB

      if (fileSizeInBytes > maxSizeInBytes) {
        return (
          result: GeneralFailure(
              message: 'Arquivo muito grande. Tamanho máximo: 5MB'),
          imageUrl: null
        );
      }

      // Simula 90% de taxa de sucesso para uploads
      if (_shouldSimulateSuccess()) {
        // Retorna uma URL aleatória da lista de imagens mock
        final randomIndex = Random().nextInt(_mockImageUrls.length);
        final mockImageUrl = _mockImageUrls[randomIndex];

        // Adiciona um timestamp para simular uma URL única
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final finalUrl = '$mockImageUrl&t=$timestamp';

        return (result: Success(), imageUrl: finalUrl);
      } else {
        // Simula diferentes tipos de falha
        final failureType = Random().nextInt(3);
        switch (failureType) {
          case 0:
            return (result: ConnectionFailure(), imageUrl: null);
          case 1:
            return (
              result:
                  GeneralFailure(message: 'Erro no servidor durante upload'),
              imageUrl: null
            );
          default:
            return (
              result: GeneralFailure(
                  message: 'Tempo limite excedido durante upload'),
              imageUrl: null
            );
        }
      }
    } catch (e) {
      return (
        result: GeneralFailure(
            message: 'Erro inesperado durante upload: ${e.toString()}'),
        imageUrl: null
      );
    }
  }

  // Métodos auxiliares

  /// Simula 90% de taxa de sucesso para uploads
  bool _shouldSimulateSuccess() {
    return DateTime.now().millisecond % 100 < 90;
  }

  // Métodos para simulação adicional

  /// Simula upload com progresso (para futuras implementações)
  Stream<double> uploadImageWithProgress(File imageFile) async* {
    const int totalSteps = 10;

    for (int i = 1; i <= totalSteps; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      yield i / totalSteps;
    }
  }

  /// Simula upload múltiplo de imagens
  Future<({Response result, List<String> imageUrls})> uploadMultipleImages(
      List<File> imageFiles) async {
    final List<String> uploadedUrls = [];

    for (final file in imageFiles) {
      final result = await uploadImage(file);

      if (result.result is Success && result.imageUrl != null) {
        uploadedUrls.add(result.imageUrl!);
      } else {
        // Se algum upload falha, retorna erro
        return (result: result.result, imageUrls: <String>[]);
      }
    }

    return (result: Success(), imageUrls: uploadedUrls);
  }

  /// Simula validação de arquivo antes do upload
  ({bool isValid, String? error}) validateImageFile(File imageFile) {
    if (!imageFile.existsSync()) {
      return (isValid: false, error: 'Arquivo não encontrado');
    }

    final fileName = imageFile.path.toLowerCase();
    final validExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];
    final hasValidExtension =
        validExtensions.any((ext) => fileName.endsWith(ext));

    if (!hasValidExtension) {
      return (
        isValid: false,
        error: 'Formato não suportado. Use: ${validExtensions.join(', ')}'
      );
    }

    return (isValid: true, error: null);
  }

  // Métodos para testes e demonstração

  /// Retorna uma URL de imagem aleatória (sem simular upload)
  static String getRandomMockImageUrl() {
    final randomIndex = Random().nextInt(_mockImageUrls.length);
    return _mockImageUrls[randomIndex];
  }

  /// Retorna todas as URLs de imagens mock disponíveis
  static List<String> getAllMockImageUrls() {
    return List.from(_mockImageUrls);
  }
}
