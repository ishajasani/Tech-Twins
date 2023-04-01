import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../constants.dart';

class ContractLinking extends ChangeNotifier {
  final String privateKey =
      "005cef10e1b23162c2865c9a809dfac4d8b19e04be692d448944b814a5de4045";

  Web3Client? _client;
  bool isLoading = true;

  String? abiCode;
  EthereumAddress? contractAddress;

  Credentials? credentials;

  DeployedContract? contract;
  ContractFunction? _userdata;
  ContractFunction? _setUserData;

  String? deployedName;

  ContractLinking() {
    setup();
  }

  setup() async {
    _client = Web3Client(rpcUrl, Client());
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringfile = await rootBundle.loadString(
        "/Users/ishajasani/Desktop/Isha/GFG_TECHIE TWINS/Techie-Twins/src/abis/test.json");
    final jsonAbi = jsonDecode(abiStringfile);
    abiCode = jsonEncode(jsonAbi['abi']);
    contractAddress =
        EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
    // print(contractAddress);
  }

  Future<void> getCredentials() async {
    credentials = EthPrivateKey.fromHex(privateKey);
  }

  Future<void> getDeployedContract() async {
    contract = DeployedContract(
        ContractAbi.fromJson(abiCode!, "test"), contractAddress!);
    _userdata = contract!.function('userdata');
    _setUserData = contract!.function('setUserData');
  }

  void setData(String username, EthereumAddress walletAdrress, String pin) async {
    isLoading = true;
    notifyListeners();
    await _client!.sendTransaction(
        credentials!,
        Transaction.callContract(
            contract: contract!,
            function: _setUserData!,
            parameters: [username, walletAdrress, pin]));
  }

  getUserData(EthereumAddress walletAdrress) async {
    // ignore: no_leading_underscores_for_local_identifiers
    var _username = await _client!.call(
        contract: contract!, function: _userdata!, params: [walletAdrress]);
    deployedName = _username[0];
    isLoading = false;
    notifyListeners();
  }
}
