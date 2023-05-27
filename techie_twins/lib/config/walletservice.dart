import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class WalletService {
  SharedPreferences? prefs;
  Credentials generateRandomAccount() {
    final cred = EthPrivateKey.createRandom(Random.secure());
    final key = bytesToHex(cred.privateKey, padToEvenLength: true);
    setPrivateKey(key);
    return cred;
  }
   Credentials generateRandomAccountLab() {
    final cred = EthPrivateKey.createRandom(Random.secure());
    final key = bytesToHex(cred.privateKey, padToEvenLength: true);
    setPrivateKeyLab(key);
    return cred;
  }

  Credentials initializeWallet(String key) {
    return EthPrivateKey.fromHex(key);
  }

  Future<Credentials> initializeWalletAgain() async {
    return EthPrivateKey.fromHex(await getPrivateKey());
  }

  Future<Credentials> initializeWalletAgainLab() async {
    return EthPrivateKey.fromHex(await getPrivateKeyLab());
  }

  Future<String> getPrivateKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_private_key') ?? "";
  }

  Future<String> getPrivateKeyLab() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('lab_private_key') ?? "";
  }

  Future<bool> removePrivateKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  setPrivateKey(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('user_private_key', value);
  }

  setPrivateKeyLab(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('lab_private_key', value);
  }
}
