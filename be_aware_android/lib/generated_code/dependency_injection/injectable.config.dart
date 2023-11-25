// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../src/repos/auth_repo.dart' as _i3;
import '../../src/services/api.dart' as _i4;
import '../../src/services/auth_service.dart' as _i5;
import '../../src/services/events_service.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AuthRepo>(() => _i3.AuthRepo());
    gh.factory<_i4.Api>(() => _i4.Api(gh<_i3.AuthRepo>()));
    gh.factory<_i5.AuthService>(() => _i5.AuthService(
          gh<_i4.Api>(),
          gh<_i3.AuthRepo>(),
        ));
    gh.factory<_i6.EventsService>(() => _i6.EventsService(gh<_i4.Api>()));
    return this;
  }
}
