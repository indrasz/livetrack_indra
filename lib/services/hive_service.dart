// ignore_for_file: cascade_invocations

import 'package:hive_flutter/hive_flutter.dart';
import 'package:livetrack_indra/models/mobile_config.dart';
import 'package:livetrack_indra/models/user.dart';

/// Container for store data in local storage.
class HiveService {
  HiveService(HiveInterface hive) : _hive = hive;

  final HiveInterface _hive;

  final _boxUser = 'user';
  final _boxMobileConfig = 'mobile-config';

  final _keyUser = 'key-user';
  final _keyMobileConfig = 'key-mobile-config';

  /// Initial HiveFlutter, used in MainRepository
  Future init() async {
    await _hive.initFlutter();
    await _openBoxes();
  }

  /// Initial Open data from local storage.
  Future _openBoxes() async {
    if (!_hive.isBoxOpen(_boxMobileConfig)) {
      _hive.registerAdapter<MobileConfig>(MobileConfigAdapter());
      await _hive.openBox<MobileConfig>(_boxMobileConfig);
    }

    if (!_hive.isBoxOpen(_boxUser)) {
      _hive.registerAdapter<User>(UserAdapter());
      await _hive.openBox<User>(_boxUser);
    }
  }

  /// Get User from local storage.
  User? getUser() {
    if (!_hive.isBoxOpen(_boxUser)) return null;

    return _hive.box<User>(_boxUser).get(_keyUser);
  }

  /// Store user to local storage.
  void storeUser(User data) {
    _hive.box<User>(_boxUser).put(_keyUser, data);
  }

  Future deleteUser() {
    return _hive.box<User>(_boxUser).delete(_keyUser);
  }

  /// Get MobileConfig from local storage.
  MobileConfig? getMobileConfig() {
    return _hive.box<MobileConfig>(_boxMobileConfig).get(_keyMobileConfig);
  }

  /// Store MobileConfig to local storage.
  void storeMobileConfig(MobileConfig data) {
    _hive.box<MobileConfig>(_boxMobileConfig).put(_keyMobileConfig, data);
  }
}
