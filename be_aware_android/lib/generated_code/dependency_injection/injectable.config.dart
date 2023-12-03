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
import '../../src/services/api.dart' as _i5;
import '../../src/services/auth_service.dart' as _i6;
import '../../src/services/events_service.dart' as _i7;
import '../../src/services/localization_service.dart' as _i4;
import '../../src/services/streams_service.dart' as _i8;

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
    gh.factory<_i4.LocalizationService>(() => _i4.LocalizationService());
    gh.factory<_i5.Api>(() => _i5.Api(gh<_i3.AuthRepo>()));
    gh.factory<_i6.AuthService>(() => _i6.AuthService(
          gh<_i5.Api>(),
          gh<_i3.AuthRepo>(),
        ));
    gh.factory<_i7.EventsService>(() => _i7.EventsService(gh<_i5.Api>()));
    gh.factory<_i8.StreamsService>(() => _i8.StreamsService(gh<_i5.Api>()));
    return this;
  }
}
