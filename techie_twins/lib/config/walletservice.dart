import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class WalletService {
  final SharedPreferences _sharedPreferences;
  WalletService(this._sharedPreferences);
  Credentials generateRandomAccount() {
    final cred = EthPrivateKey.createRandom(Random.secure());
    final key = bytesToHex(cred.privateKey, padToEvenLength: true);
    setPrivateKey(key);
    return cred;
  }

  Credentials initializeWallet([String? key]) =>
      EthPrivateKey.fromHex(key ?? getPrivateKey());

  String getPrivateKey() =>
      _sharedPreferences.getString('user_private_key') ?? "";

  Future<void> setPrivateKey(String value) async =>
      await _sharedPreferences.setString('user_private_key',value);
}
