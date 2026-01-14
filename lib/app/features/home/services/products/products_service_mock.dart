import 'package:app_test_fiap/app/core/network/response_types/response.dart';
import 'package:app_test_fiap/app/features/home/model/product_model.dart';
import 'package:app_test_fiap/app/features/home/services/products/products_service.dart';

class ProductsServiceMock implements ProductsService {
  // Lista simulada de produtos para persistir dados entre chamadas
  static final List<ProductModel> _products = [
    ProductModel(
      id: 1,
      title: 'Smartphone Samsung Galaxy S23',
      slug: 'smartphone-samsung-galaxy-s23',
      price: 299999, // Preço em centavos
      description:
          'Smartphone Samsung Galaxy S23 com 128GB de armazenamento, tela de 6.1 polegadas e câmera tripla de alta qualidade.',
      images: [
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
        'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400'
      ],
      creationAt: '2024-01-15T10:30:00Z',
      updatedAt: '2024-01-15T10:30:00Z',
    ),
    ProductModel(
      id: 2,
      title: 'Notebook Dell Inspiron 15',
      slug: 'notebook-dell-inspiron-15',
      price: 189999,
      description:
          'Notebook Dell Inspiron 15 com processador Intel Core i5, 8GB RAM e SSD 256GB. Ideal para trabalho e estudos.',
      images: [
        'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
        'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400'
      ],
      creationAt: '2024-01-14T08:20:00Z',
      updatedAt: '2024-01-14T08:20:00Z',
    ),
    ProductModel(
      id: 3,
      title: 'Fone de Ouvido Sony WH-1000XM4',
      slug: 'fone-ouvido-sony-wh-1000xm4',
      price: 79999,
      description:
          'Fone de ouvido wireless com cancelamento de ruído ativo, bateria de até 30 horas e qualidade de áudio premium.',
      images: [
        'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=400',
        'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=400'
      ],
      creationAt: '2024-01-13T16:45:00Z',
      updatedAt: '2024-01-13T16:45:00Z',
    ),
    ProductModel(
      id: 4,
      title: 'Smart TV LG 55" 4K',
      slug: 'smart-tv-lg-55-4k',
      price: 149999,
      description:
          'Smart TV LG 55 polegadas com resolução 4K, WebOS, HDR10 e acesso a principais plataformas de streaming.',
      images: [
        'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=400',
        'https://images.unsplash.com/photo-1571415060382-e2feee14a51e?w=400'
      ],
      creationAt: '2024-01-12T12:15:00Z',
      updatedAt: '2024-01-12T12:15:00Z',
    ),
    ProductModel(
      id: 5,
      title: 'Console PlayStation 5',
      slug: 'console-playstation-5',
      price: 399999,
      description:
          'Console PlayStation 5 com SSD ultra-rápido, gráficos em 4K, controle DualSense com feedback tátil.',
      images: [
        'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=400',
        'https://images.unsplash.com/photo-1607853202273-797f1c22a38e?w=400'
      ],
      creationAt: '2024-01-11T14:30:00Z',
      updatedAt: '2024-01-11T14:30:00Z',
    ),
  ];

  static int _nextId = 6; // Próximo ID disponível

  @override
  Future<({Response result, List<ProductModel> products})> getProducts() async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      // Simula 95% de sucesso
      if (_shouldSimulateSuccess()) {
        return (
          result: Success(),
          products: List<ProductModel>.from(_products)
        );
      } else {
        return (
          result: GeneralFailure(message: 'Erro simulado ao buscar produtos'),
          products: <ProductModel>[]
        );
      }
    } catch (e) {
      return (
        result: GeneralFailure(message: 'Erro inesperado: ${e.toString()}'),
        products: <ProductModel>[]
      );
    }
  }

  @override
  Future<({Response result, ProductModel? product})> createProduct(
      ProductModel product) async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      if (_shouldSimulateSuccess()) {
        // Cria um novo produto com ID gerado
        final newProduct = ProductModel(
          id: _nextId++,
          title: product.title,
          slug: _generateSlug(product.title ?? ''),
          price: product.price,
          description: product.description,
          images: product.images,
          creationAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );

        _products.add(newProduct);

        return (result: Success(), product: newProduct);
      } else {
        return (
          result: GeneralFailure(message: 'Erro simulado ao criar produto'),
          product: null
        );
      }
    } catch (e) {
      return (
        result: GeneralFailure(message: 'Erro inesperado: ${e.toString()}'),
        product: null
      );
    }
  }

  @override
  Future<({Response result, ProductModel? product})> updateProduct(
      int id, ProductModel product) async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 700));

    try {
      if (_shouldSimulateSuccess()) {
        final index = _products.indexWhere((p) => p.id == id);

        if (index != -1) {
          final existingProduct = _products[index];
          final updatedProduct = ProductModel(
            id: existingProduct.id,
            title: product.title ?? existingProduct.title,
            slug: product.title != null
                ? _generateSlug(product.title!)
                : existingProduct.slug,
            price: product.price ?? existingProduct.price,
            description: product.description ?? existingProduct.description,
            images: product.images ?? existingProduct.images,
            creationAt: existingProduct.creationAt,
            updatedAt: DateTime.now().toIso8601String(),
          );

          _products[index] = updatedProduct;

          return (result: Success(), product: updatedProduct);
        } else {
          return (
            result:
                GeneralFailure(message: 'Produto com ID $id não encontrado'),
            product: null
          );
        }
      } else {
        return (
          result: GeneralFailure(message: 'Erro simulado ao atualizar produto'),
          product: null
        );
      }
    } catch (e) {
      return (
        result: GeneralFailure(message: 'Erro inesperado: ${e.toString()}'),
        product: null
      );
    }
  }

  @override
  Future<({Response result, bool success})> deleteProduct(int id) async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 600));

    try {
      if (_shouldSimulateSuccess()) {
        final index = _products.indexWhere((p) => p.id == id);

        if (index != -1) {
          _products.removeAt(index);
          return (result: Success(), success: true);
        } else {
          return (
            result:
                GeneralFailure(message: 'Produto com ID $id não encontrado'),
            success: false
          );
        }
      } else {
        return (
          result: GeneralFailure(message: 'Erro simulado ao deletar produto'),
          success: false
        );
      }
    } catch (e) {
      return (
        result: GeneralFailure(message: 'Erro inesperado: ${e.toString()}'),
        success: false
      );
    }
  }

  @override
  Future<({Response result, ProductModel? product})> getProduct(int id) async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 400));

    try {
      if (_shouldSimulateSuccess()) {
        final product = _products.firstWhere(
          (p) => p.id == id,
          orElse: () => ProductModel(),
        );

        if (product.id != null) {
          return (result: Success(), product: product);
        } else {
          return (
            result:
                GeneralFailure(message: 'Produto com ID $id não encontrado'),
            product: null
          );
        }
      } else {
        return (
          result: GeneralFailure(message: 'Erro simulado ao buscar produto'),
          product: null
        );
      }
    } catch (e) {
      return (
        result: GeneralFailure(message: 'Erro inesperado: ${e.toString()}'),
        product: null
      );
    }
  }

  // Métodos auxiliares

  /// Simula 95% de taxa de sucesso
  bool _shouldSimulateSuccess() {
    return DateTime.now().millisecond % 100 < 95;
  }

  /// Gera um slug a partir de um título
  String _generateSlug(String title) {
    return title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .trim();
  }

  // Métodos para testes e demonstração

  /// Limpa todos os produtos (útil para testes)
  static void clearProducts() {
    _products.clear();
    _nextId = 1;
  }

  /// Adiciona produtos iniciais (útil para testes)
  static void resetToInitialData() {
    clearProducts();
    _nextId = 6;
    // Os produtos iniciais já estão definidos na declaração da lista
  }

  /// Retorna o número atual de produtos
  static int get productCount => _products.length;
}
