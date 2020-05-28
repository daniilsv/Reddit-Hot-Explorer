// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:reddit_explorer/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:reddit_explorer/services/posts_service.dart';
import 'package:reddit_explorer/services/reddit.dart';
import 'package:reddit_explorer/services/subreddits.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<PostsService>(() => PostsService());
  g.registerLazySingletonAsync<RedditService>(RedditService.create);
  g.registerLazySingleton<SubredditsService>(() => SubredditsService());
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}
