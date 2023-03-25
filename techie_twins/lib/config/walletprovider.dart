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
  final Web3Client _web3client = Web3Client("HTTP://192.168.43.59:7545", Client());
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
    etherAmount = await _web3client.getBalance(
        EthereumAddress.fromHex(ethereumAddress!.hex));
    accountBalance = etherAmount!.getInEther.toDouble();
    print("Account Balance: $accountBalance");
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
    print("object $privateKey");
    try {
      _credentials = _walletService.initializeWallet(
          "0x96eca8c00dab04d66ff5636f9058f0f5bc6644f0001eab5515ae3f62dfa056c2");
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
