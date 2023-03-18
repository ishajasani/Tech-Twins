import 'dart:async';

import 'package:flutter/material.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:web3dart/web3dart.dart';

import 'contractservice.dart';
import 'gaspriceservice.dart';

enum WalletState { empty, loading, loaded, success, error, logout }

class WalletProvider with ChangeNotifier {
  final WalletService _walletService;
  final Web3Client _web3client;
  final GasPriceService _gasPriceService;
  final ContractService _contractService;

  WalletProvider(
    this._web3client,
    // this._walletService,
    // this._gasPriceService,
    // this._contractService
  );
  WalletState state = WalletState.empty;
  String errMessage = "";
  late Credentials _credentials;
  late EthereumAddress _ethereumAddress;
  EtherAmount? _etherAmount;
  GasInfo? _gasInfo;
  Transaction? _transactionInfo;
  double totalAmount = 0;
  String lastTxHash = "";
  double maticPrice = 0;
  Function? onNetworkConfirmationRun;
  getBalance() async {
    _etherAmount = await _web3client.getBalance(_ethereumAddress);
    _handleLoaded();
  }

  getTransactionFee(Transaction transaction) async {
    try {
      _transactionInfo = transaction;
      // _gasInfo = null;
      // _gasInfo = await _gasPriceService.getGasInfo(transaction);
      
    } catch (e) {}
  }
}
