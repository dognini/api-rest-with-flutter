import 'package:app_test_fiap/app/core/api/api_adapter.dart';
import 'package:app_test_fiap/app/core/api/dio_api_adapter.dart';
import 'package:app_test_fiap/app/features/home/controller/home_cubit.dart';
import 'package:app_test_fiap/app/core/injector_adapter/injection_adapter.dart';
import 'package:app_test_fiap/app/features/home/services/upload/upload_service.dart';
import 'package:app_test_fiap/app/features/home/services/products/products_service.dart';
import 'package:app_test_fiap/app/features/home/services/upload/upload_service_remote.dart';
import 'package:app_test_fiap/app/features/home/services/products/product_service_remote.dart';

class HomeInjectionContainer {
  void call(InjectionAdapter dependency) {
    dependency.registerFactory<ApiClientAdapter>(
        DioClientAdapter(baseUrl: 'https://api.escuelajs.co'));

    dependency.registerFactory<ProductsService>(
      ProductServiceRemote(client: dependency.get<ApiClientAdapter>()),
    );

    dependency.registerFactory<UploadService>(
      UploadServiceRemote(client: dependency.get<ApiClientAdapter>()),
    );

    dependency.registerLazySingleton<HomeCubit>(
      HomeCubit(
        productsService: dependency.get<ProductsService>(),
        uploadService: dependency.get<UploadService>(),
      ),
    );
  }
}
