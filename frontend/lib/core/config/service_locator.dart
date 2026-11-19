import 'package:get_it/get_it.dart';
import '../network/api_client.dart';
import 'env_config.dart';
import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/mock_auth_repository.dart';
import '../../features/auth/data/repositories/remote_auth_repository.dart';
import '../../features/catalog/cubit/catalog_cubit.dart';
import '../../features/catalog/data/repositories/catalog_repository.dart';
import '../../features/catalog/data/repositories/mock_catalog_repository.dart';
import '../../features/catalog/data/repositories/remote_catalog_repository.dart';
import '../../features/inventory/cubit/inventory_cubit.dart';
import '../../features/inventory/data/repositories/inventory_repository.dart';
import '../../features/inventory/data/repositories/mock_inventory_repository.dart';
import '../../features/inventory/data/repositories/remote_inventory_repository.dart';
import '../../features/procurement/cubit/procurement_cubit.dart';
import '../../features/procurement/data/repositories/mock_procurement_repository.dart';
import '../../features/procurement/data/repositories/procurement_repository.dart';
import '../../features/procurement/data/repositories/remote_procurement_repository.dart';
import '../../features/sales/cubit/sales_cubit.dart';
import '../../features/sales/data/repositories/mock_sales_repository.dart';
import '../../features/sales/data/repositories/remote_sales_repository.dart';
import '../../features/sales/data/repositories/sales_repository.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  if (sl.isRegistered<ApiClient>()) return;

  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  // Automatically switches between Mock and Remote repositories based on EnvConfig.useMockData
  if (EnvConfig.useMockData) {
    sl.registerLazySingleton<AuthRepository>(() => MockAuthRepository());
    sl.registerLazySingleton<CatalogRepository>(() => MockCatalogRepository());
    sl.registerLazySingleton<InventoryRepository>(() => MockInventoryRepository());
    sl.registerLazySingleton<SalesRepository>(() => MockSalesRepository());
    sl.registerLazySingleton<ProcurementRepository>(() => MockProcurementRepository());
  } else {
    // TODO [BACKEND API]: Ensure all Remote*Repository methods are implemented before setting USE_MOCK_DATA=false
    sl.registerLazySingleton<AuthRepository>(() => RemoteAuthRepository(sl()));
    sl.registerLazySingleton<CatalogRepository>(() => RemoteCatalogRepository(sl()));
    sl.registerLazySingleton<InventoryRepository>(() => RemoteInventoryRepository(sl()));
    sl.registerLazySingleton<SalesRepository>(() => RemoteSalesRepository(sl()));
    sl.registerLazySingleton<ProcurementRepository>(() => RemoteProcurementRepository(sl()));
  }

  // Cubits
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(sl()));
  sl.registerFactory<CatalogCubit>(() => CatalogCubit(sl()));
  sl.registerFactory<InventoryCubit>(() => InventoryCubit(sl()));
  sl.registerFactory<SalesCubit>(() => SalesCubit(sl()));
  sl.registerFactory<ProcurementCubit>(() => ProcurementCubit(sl()));
}
