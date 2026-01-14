import 'package:app_test_fiap/app/core/network/response_types/response.dart';
import 'package:app_test_fiap/app/features/home/model/product_model.dart';
import 'package:app_test_fiap/app/features/home/services/products/products_service.dart';
import 'package:app_test_fiap/app/features/home/services/upload/upload_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.productsService,
    required this.uploadService,
  }) : super(HomeInitial());

  final ProductsService productsService;
  final UploadService uploadService;

  Future<void> getHomeData() async {
    if (isClosed) return;
    emit(HomeLoading());
    final responseProducts = await productsService.getProducts();
    if (responseProducts.result is Success) {
      if (!isClosed) emit(HomeLoaded(products: responseProducts.products));
    } else {
      final error = responseProducts.result;
      if (!isClosed)
        emit(HomeError(
          message: error is ConnectionFailure
              ? 'Verifique sua conexão'
              : error.message ?? 'Ocorreu um erro inesperado',
        ));
    }
  }

  Future<void> createProduct(ProductModel product,
      {List<File>? imageFiles}) async {
    if (isClosed) return;
    emit(HomeLoading());

    try {
      // Upload das imagens se fornecidas
      if (imageFiles != null && imageFiles.isNotEmpty) {
        final imageUrls = <String>[];
        for (final imageFile in imageFiles) {
          final uploadResponse = await uploadService.uploadImage(imageFile);
          if (uploadResponse.result is Success &&
              uploadResponse.imageUrl != null) {
            imageUrls.add(uploadResponse.imageUrl!);
          } else {
            if (!isClosed)
              emit(HomeError(message: 'Erro ao fazer upload da imagem'));
            return;
          }
        }
        product = ProductModel(
          title: product.title,
          price: product.price,
          description: product.description,
          images: imageUrls,
        );
      }

      final response = await productsService.createProduct(product);
      if (response.result is Success) {
        if (!isClosed) emit(HomeProductCreated(product: response.product!));
        if (!isClosed) getHomeData(); // Recarregar a lista
      } else {
        final error = response.result;
        if (!isClosed)
          emit(HomeError(
            message: error is ConnectionFailure
                ? 'Verifique sua conexão'
                : 'Erro ao criar produto',
          ));
      }
    } catch (e) {
      if (!isClosed) emit(HomeError(message: 'Erro inesperado: $e'));
    }
  }

  Future<void> updateProduct(int id, ProductModel product,
      {List<File>? imageFiles}) async {
    if (isClosed) return;
    emit(HomeLoading());

    try {
      // Upload das imagens se fornecidas
      if (imageFiles != null && imageFiles.isNotEmpty) {
        final imageUrls = <String>[];
        for (final imageFile in imageFiles) {
          final uploadResponse = await uploadService.uploadImage(imageFile);
          if (uploadResponse.result is Success &&
              uploadResponse.imageUrl != null) {
            imageUrls.add(uploadResponse.imageUrl!);
          } else {
            if (!isClosed)
              emit(HomeError(message: 'Erro ao fazer upload da imagem'));
            return;
          }
        }
        // Adicionar às imagens existentes ou substituir
        product = ProductModel(
          id: product.id,
          title: product.title,
          price: product.price,
          description: product.description,
          images: [...(product.images ?? []), ...imageUrls],
          slug: product.slug,
          creationAt: product.creationAt,
          updatedAt: product.updatedAt,
        );
      }

      final response = await productsService.updateProduct(id, product);
      if (response.result is Success) {
        if (!isClosed) emit(HomeProductUpdated(product: response.product!));
        if (!isClosed) getHomeData(); // Recarregar a lista
      } else {
        final error = response.result;
        if (!isClosed)
          emit(HomeError(
            message: error is ConnectionFailure
                ? 'Verifique sua conexão'
                : 'Erro ao atualizar produto',
          ));
      }
    } catch (e) {
      if (!isClosed) emit(HomeError(message: 'Erro inesperado: $e'));
    }
  }

  Future<void> deleteProduct(int id) async {
    if (isClosed) return;
    emit(HomeLoading());

    final response = await productsService.deleteProduct(id);
    if (response.result is Success) {
      if (!isClosed) emit(HomeProductDeleted());
      if (!isClosed) getHomeData(); // Recarregar a lista
    } else {
      final error = response.result;
      if (!isClosed)
        emit(HomeError(
          message: error is ConnectionFailure
              ? 'Verifique sua conexão'
              : 'Erro ao deletar produto',
        ));
    }
  }

  Future<void> getProduct(int id) async {
    if (isClosed) return;
    emit(HomeLoading());

    final response = await productsService.getProduct(id);
    if (response.result is Success) {
      if (!isClosed) emit(HomeProductLoaded(product: response.product!));
    } else {
      final error = response.result;
      if (!isClosed)
        emit(HomeError(
          message: error is ConnectionFailure
              ? 'Verifique sua conexão'
              : 'Erro ao carregar produto',
        ));
    }
  }
}
