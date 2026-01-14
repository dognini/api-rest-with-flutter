import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_test_fiap/app/features/home/controller/home_cubit.dart';
import 'package:app_test_fiap/app/features/home/model/product_model.dart';
import 'package:app_test_fiap/app/features/home/view/widgets/use_dev_appbar_widget.dart';
import 'package:app_test_fiap/app/features/home/view/widgets/footer_widget.dart';
import 'package:app_test_fiap/app/features/home/view/widgets/disclaimer_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Carregar os dados quando a página inicializar
    context.read<HomeCubit>().getHomeData();
  }

  void _navigateToCreateProduct(BuildContext context, state) {
    context.push('/product-form');
  }

  void _navigateToEditProduct(
      BuildContext context, ProductModel product, state) {
    context.push('/product-form/${product.id}', extra: {'product': product});
  }

  void _showDeleteConfirmation(BuildContext context, ProductModel product) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: Text(
              'Tem certeza que deseja excluir o produto "${product.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<HomeCubit>().deleteProduct(product.id!);
              },
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const UseDevAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToCreateProduct(context, null),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Novo Produto'),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeProductDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Produto excluído com sucesso!')),
            );
          } else if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return switch (state) {
            HomeLoading() => const Center(child: CircularProgressIndicator()),
            HomeLoaded() => CustomScrollView(
                slivers: [
                  // Header com título
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Text(
                            'Gerenciar Produtos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: GoogleFonts.orbitron().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Total: ${state.products.length} produtos',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Lista de produtos com design similar ao home
                  state.products.isEmpty
                      ? const SliverToBoxAdapter(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(50.0),
                              child: Column(
                                children: [
                                  Icon(Icons.inventory_2_outlined,
                                      size: 64, color: Colors.grey),
                                  SizedBox(height: 16),
                                  Text(
                                    'Nenhum produto encontrado',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              final product = state.products[index];
                              return Card(
                                margin: const EdgeInsets.all(20),
                                color: const Color(0xFFEFEFEF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                elevation: 5,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Stack(
                                      children: [
                                        Image.network(
                                          product.images?.isNotEmpty == true
                                              ? product.images!.first
                                              : '',
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              height: 200,
                                              color: Colors.grey[300],
                                              child: const Icon(
                                                Icons.image_not_supported,
                                                size: 64,
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                        ),
                                        // Botões de ação no canto superior direito
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.blue,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: IconButton(
                                                  onPressed: () =>
                                                      _navigateToEditProduct(
                                                          context,
                                                          product,
                                                          state),
                                                  icon: const Icon(Icons.edit,
                                                      color: Colors.white),
                                                  tooltip: 'Editar',
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: IconButton(
                                                  onPressed: () =>
                                                      _showDeleteConfirmation(
                                                          context, product),
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.white),
                                                  tooltip: 'Excluir',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title ?? 'Sem título',
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontFamily: GoogleFonts.orbitron()
                                                  .fontFamily,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          if (product.description != null)
                                            Text(
                                              product.description!,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        bottom: 20,
                                      ),
                                      child: Text(
                                        'R\$ ${product.price ?? 0}',
                                        style: const TextStyle(
                                          fontSize: 31,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            childCount: state.products.length,
                          ),
                        ),

                  // Footer
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 40),
                  ),
                  const SliverToBoxAdapter(
                    child: FooterWidget(),
                  ),
                  const SliverToBoxAdapter(
                    child: DisclaimerWidget(),
                  ),
                ],
              ),
            HomeError() => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<HomeCubit>().getHomeData(),
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              ),
            _ => const Center(child: Text('Estado desconhecido')),
          };
        },
      ),
    );
  }
}
