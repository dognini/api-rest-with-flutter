part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeLoaded extends HomeState {
  final List<ProductModel> products;

  const HomeLoaded({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}

final class HomeError extends HomeState {
  final String message;

  const HomeError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class HomeProductCreated extends HomeState {
  final ProductModel product;

  const HomeProductCreated({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

final class HomeProductUpdated extends HomeState {
  final ProductModel product;

  const HomeProductUpdated({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

final class HomeProductDeleted extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeProductLoaded extends HomeState {
  final ProductModel product;

  const HomeProductLoaded({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}
