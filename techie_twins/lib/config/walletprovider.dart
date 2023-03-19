import 'dart:async';

import 'package:flutter/material.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:web3dart/web3dart.dart';

import 'contractservice.dart';
import 'gaspriceservice.dart';

enum WalletState { empty, loading, loaded, success, error, logout }

class WalletProvider {
  final WalletService _walletService = WalletService();
  Web3Client? _web3client;
  GasPriceService? _gasPriceService;
  ContractService? _contractService;

  // WalletProvider(
  //   // this._web3client,
  //   // this._walletService,
  //   // this._gasPriceService,
  //   // this._contractService,
  //   // this._walletService,
  //   // this._gasPriceService,
  //   // this._contractService
  // );
  WalletState state = WalletState.empty;
  String errMessage = "";
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
    etherAmount = await _web3client?.getBalance(ethereumAddress!);
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

  initializeWallet() async {
    _credentials = _walletService.initializeWallet();
    ethereumAddress = _credentials?.address;
    getBalance();
  }

// 39bc2eb50999a396fa6ab7ff615bef86fb4cfe9bbd5d6c42bb0668c297a2eaa6
  initializeFromKey(String privateKey) async {
    try {
      _credentials = _walletService.initializeWallet(privateKey);
      ethereumAddress = _credentials!.address;
      await _walletService.setPrivateKey(privateKey);
      getBalance();
      _handleSuccess();
      print("Successfull login");
    } on FormatException catch (e) {
      debugPrint('Error: ${e.message}');
      _handleError('Invalid private key');
    } catch (e) {
      debugPrint('Error: $e');
      _handleError(e);
    }
  }

  createWallet() {
    print("object");
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
