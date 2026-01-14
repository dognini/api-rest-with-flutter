import 'package:app_test_fiap/app/core/injector_adapter/injection_adapter.dart';

import 'package:app_test_fiap/app/features/home/injection/home_injection_container.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

const environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'DEV');
const secureStorageInstance = FlutterSecureStorage();
final getIt = GetIt.instance;
final dependency = InjectionAdapter(getIt);

Future<void> init() async {
  final homeInjectionContainer = HomeInjectionContainer();
  homeInjectionContainer(dependency);
}
