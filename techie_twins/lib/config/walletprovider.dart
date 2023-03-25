
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:web3dart/web3dart.dart';

import 'gaspriceservice.dart';

enum WalletState { empty, loading, loaded, success, error, logout }

class WalletProvider {
  final WalletService _walletService = WalletService();
  final Web3Client _web3client =
      Web3Client("HTTP://192.168.43.59:7545", Client());
  GasPriceService? _gasPriceService;
  // ContractService? _contractService;

  WalletState state = WalletState.empty;
  String errMessage = "";
  double accountBalance = 0.0;
  late Credentials _credentials;
  EthereumAddress? ethereumAddress;
  late EtherAmount etherAmount;
  GasInfo? gasInfo;
  Transaction? transactionInfo;
  double totalAmount = 0;
  String lastTxHash = "";
  double maticPrice = 0;
  Function? onNetworkConfirmationRun;
  getBalance() async {
    etherAmount = await _web3client
        .getBalance(EthereumAddress.fromHex(ethereumAddress!.hex));
    accountBalance = etherAmount.getInEther.toDouble();
    if (kDebugMode) {
      print("Account Balance: $accountBalance");
    }
  }

  getTransactionFee(Transaction transaction) async {
    try {
      transactionInfo = transaction;
      gasInfo = null;
      gasInfo = await _gasPriceService?.getGasInfo(transaction);
    } catch (e) {
      rethrow;
    }
  }

  initializeWallet() async {
    _credentials = await _walletService.initializeWalletAgain();
    ethereumAddress = _credentials.address;
    getBalance();
  }

  initializeFromKey(String privateKey) {
    try {
      _credentials = _walletService.initializeWallet(privateKey);
      ethereumAddress = _credentials.address;
      _walletService.setPrivateKey(privateKey);
      getBalance();

      return true;
    } on FormatException catch (e) {
      debugPrint('Error: ${e.message}');
    } catch (e) {
      debugPrint('Error: $e');
    }
    return false;
  }

  createWallet() {
    _credentials = _walletService.generateRandomAccount();
    ethereumAddress = _credentials.address;
    getBalance();
  }
}
