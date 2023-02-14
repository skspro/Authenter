import 'package:authenter/utils/constans.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');

  String contractAddress = contractAddress1;

  final contract = DeployedContract(ContractAbi.fromJson(abi, 'Authenter'),
      EthereumAddress.fromHex(contractAddress));

  return contract;
}

Future<String> callFunction(String funcname, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credential = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(funcname);
  final result = await ethClient.sendTransaction(
      credential,
      Transaction.callContract(
          contract: contract, function: ethFunction, parameters: args),
      chainId: null,
      fetchChainIdFromNetworkId: true);
  return result;
}

Future<String> addManufacturer(String email, String name, BigInt year,
    String address, BigInt role, Web3Client ethClient) async {
  var response = await callFunction('addManufacturer',
      [email, name, year, address, role], ethClient, Manufacturer_private_key);
  print('Manufacturer Added');
  return response;
}

Future<String> addProduct(
    String cmpnyName,
    BigInt estyear,
    String addrs,
    String name,
    String owner,
    String details,
    BigInt code,
    Web3Client ethClient) async {
  var response = await callFunction(
      'addProduct',
      [cmpnyName, estyear, addrs, name, owner, details, code],
      ethClient,
      Manufacturer_private_key);
  print('Product Added');
  return response;
}

Future<String> addSupplier(
    String name, String address, Web3Client ethClient) async {
  var response = await callFunction(
      'addSupplier', [name, address], ethClient, Supplier_private_key);
  print('Supplier Added');
  return response;
}

Future<List> checkAuthenticity(BigInt code, Web3Client ethClient) async {
  List<dynamic> result =
      await ask('checkProductAuthenticity', [code], ethClient);
  return result;
}

Future<List<dynamic>> ask(
    String funcName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result =
      ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future checkauth(BigInt code, Web3Client ethClient) async {
  // final result = await callFunction(
  //    'checkProductAuthenticity', [code], ethClient, Customer_private_key);
  ///  List<dynamic> res = result;
//  return res;
  final Contract = await loadContract();
  final etherFunction = Contract.function("checkProductAuthenticity");
  final result = await ethClient
      .call(contract: Contract, function: etherFunction, params: [code]);

  List<dynamic> res = result;
  return res[0];
}

Future<String> addrole(String email, BigInt role, Web3Client ethClient) async {
  var response = await callFunction(
      'addrole', [email, role], ethClient, Manufacturer_private_key);
  print('role added');
  return response;
}

Future getrole(String email, Web3Client ethClient) async {
  final Contract = await loadContract();
  final etherFunction = Contract.function("getrole");
  final result = await ethClient
      .call(contract: Contract, function: etherFunction, params: [email]);

  List<dynamic> res = result;
  return res[0];
}

List<String> details = ['nil', 'nil', 'nil', 'nil', 'nil'];
BigInt year = BigInt.one;

Future<String> getdetails(BigInt code, Web3Client ethClient) async {
  final Contract = await loadContract();
  final etherFunction = Contract.function("viewdetails");
  final result = await ethClient
      .call(contract: Contract, function: etherFunction, params: [code]);

  List<dynamic> res = result;
  details[0] = res[0];
  year = res[1];
  details[2] = res[2];
  details[3] = res[3];
  details[4] = res[4];
  return res[0];
}
