import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locator.iconfig.dart';

final GetIt locator = GetIt.instance;

@injectableInit
void setupLocator() => $initGetIt(locator);
