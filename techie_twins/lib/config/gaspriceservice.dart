import 'dart:convert';

import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class GasPriceService {
  final Web3Client _web3client;
  final http.Client _httpClient;
  GasPriceService(this._httpClient, this._web3client);

  Future<GasInfo> getGasInfo(Transaction transaction) async {
    try {
      final estimatedGas = await _web3client.estimateGas(
          sender: transaction.from,
          to: transaction.to,
          value: transaction.value,
          data: transaction.data);

      final currentGasPrice = await _web3client.getGasPrice();
      final totalGasRequired =
          estimatedGas * currentGasPrice.getInWei / BigInt.from(10).pow(18);
      return GasInfo(
          gas: estimatedGas,
          currentGasPrice: currentGasPrice,
          totalGasRequired: totalGasRequired);
    } catch (e) {
      rethrow;
    }
  }

  Future<BigInt> getCurrentGasPrice() async {
    final body = {
      "jsonrpc": "2.0",
      "method": "eth_gasPrice",
      "params": [],
      "id": 1
    };
    try {
      final response = await _httpClient.post(
          Uri.parse('https://rpc-mumbai.maticvigil.com/'),
          body: jsonEncode(body));
      final data = jsonDecode(response.body);
      final amount = hexToInt(data['result']);
      return amount;
    } catch (e) {
      rethrow;
    }
  }
}

class GasInfo {
  final BigInt gas;
  final EtherAmount currentGasPrice;
  final double totalGasRequired;
  GasInfo(
      {required this.gas,
      required this.currentGasPrice,
      required this.totalGasRequired});

  @override
  String toString() {
    return 'GasInfo -> gas: $gas, currentGasPrice: $currentGasPrice, totalGasRequired: $totalGasRequired';
  }
}
