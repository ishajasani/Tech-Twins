import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:web3dart/web3dart.dart';

import 'contractservice.dart';
import 'gaspriceservice.dart';

enum WalletState { empty, loading, loaded, success, error, logout }

class WalletProvider {
  final WalletService _walletService = WalletService();
  final Web3Client _web3client = Web3Client("HTTP://127.0.0.1:7546", Client());
  GasPriceService? _gasPriceService;
  ContractService? _contractService;

  WalletState state = WalletState.empty;
  String errMessage = "";
   double accountBalance = 0;
  Credentials? _credentials;
  EthereumAddress? ethereumAddress;
  EtherAmount? etherAmount;
  GasInfo? _gasInfo;
  Transaction? _transactionInfo;
  double totalAmount = 0;
  String lastTxHash = "";
  double maticPrice = 0;
  Function? onNetworkConfirmationRun;
  getBalance() async {
    etherAmount = await _web3client.getBalance(EthereumAddress.fromHex("0x28205E1bAdA92C5aA5C2b25f1b57fCBA9bDE0fD6"));
    accountBalance = etherAmount!.getInEther.toDouble();
    print("Account Balance: " + accountBalance.toString());
    _handleLoaded();
  }

  getTransactionFee(Transaction transaction) async {
    try {
      _transactionInfo = transaction;
      _gasInfo = null;
      _gasInfo = await _gasPriceService?.getGasInfo(transaction);
    } catch (e) {
      rethrow;
    }
  }

// 39bc2eb50999a396fa6ab7ff615bef86fb4cfe9bbd5d6c42bb0668c297a2eaa6
  Future<bool> initializeWallet(String privateKey) async {
    print(privateKey);
    try {
      _credentials = _walletService.initializeWallet(
          "0x731ea81acad629bab2fea7481127f965e830f9b84a448a2754fd3ebd9ff80a20");
      ethereumAddress = _credentials!.address;
      await _walletService.setPrivateKey(privateKey);
      getBalance();
      _handleSuccess();
      return true;
    } on FormatException catch (e) {
      debugPrint('Error: ${e.message}');
      _handleError('Invalid private key');
    } catch (e) {
      debugPrint('Error: $e');
      _handleError(e);
    }
    return false;
  }

  createWallet() {
    _handleLoading();
    _credentials = _walletService.generateRandomAccount();
    ethereumAddress = _credentials!.address;
    getBalance();
    _handleSuccess();
  }

  void _handleEmpty() {
    state = WalletState.empty;
    errMessage = '';
    // notifyListeners();
  }

  void _handleLoading() {
    state = WalletState.loading;
    errMessage = '';
    // notifyListeners();
  }

  void _handleLoaded() {
    state = WalletState.loaded;
    errMessage = '';
    // notifyListeners();
  }

  void _handleSuccess() {
    state = WalletState.success;
    errMessage = '';
    // notifyListeners();
    Timer(const Duration(milliseconds: 450), _handleEmpty);
  }

  void _handleError(e) {
    state = WalletState.error;
    errMessage = e.toString();
    // notifyListeners();
    // _gasInfo = null;
    // _gasInfo = await _gasPriceService.getGasInfo(transaction);
  }
}
