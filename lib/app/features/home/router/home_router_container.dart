import 'package:app_test_fiap/app/core/containers/injection_container.dart';
import 'package:app_test_fiap/app/features/home/controller/home_cubit.dart';
import 'package:app_test_fiap/app/features/home/view/pages/home_page.dart';
import 'package:app_test_fiap/app/features/home/view/pages/product_form_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Instância global do cubit para compartilhar entre as páginas
final _globalHomeCubit = dependency.get<HomeCubit>();

final getRouterContainer = [
  GoRoute(
    path: '/',
    builder: (context, state) => BlocProvider<HomeCubit>.value(
      value: _globalHomeCubit..getHomeData(),
      child: const HomePage(),
    ),
  ),
  GoRoute(
    path: '/product-form',
    builder: (context, state) {
      return BlocProvider<HomeCubit>.value(
        value: _globalHomeCubit,
        child: const ProductFormPage(),
      );
    },
  ),
  GoRoute(
    path: '/product-form/:id',
    builder: (context, state) {
      final extras = state.extra as Map<String, dynamic>? ?? {};
      final product = extras['product'];

      return BlocProvider<HomeCubit>.value(
        value: _globalHomeCubit,
        child: ProductFormPage(
          product: product,
        ),
      );
    },
  ),
];
