import 'package:app_test_fiap/app/core/network/response_types/response.dart';
import 'package:app_test_fiap/app/features/home/model/product_model.dart';

abstract class ProductsService {
  Future<({Response result, List<ProductModel> products})> getProducts();
  Future<({Response result, ProductModel? product})> createProduct(
      ProductModel product);
  Future<({Response result, ProductModel? product})> updateProduct(
      int id, ProductModel product);
  Future<({Response result, bool success})> deleteProduct(int id);
  Future<({Response result, ProductModel? product})> getProduct(int id);
}
