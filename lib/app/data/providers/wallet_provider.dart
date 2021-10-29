import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/firestoration.dart';
import 'package:keepital/app/data/services/auth_service.dart';

class WalletProvider implements Firestoration<String, Wallet> {
  @override
  String get collectionPath => AppValue.walletCollectionPath;

  @override
  Future<Wallet> add(Wallet obj) {
    throw UnimplementedError();
  }

  @override
  Future<Wallet> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Wallet> fetch(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Wallet> update(String id, Wallet obj) {
    throw UnimplementedError();
  }

  Future<Map<String, Wallet>> fetchAll() async {
    Map<String, Wallet> wallets = {};
    final userPath = await _getUserPath();
    final userWalletCollection = await userPath.collection(AppValue.walletCollectionPath).get();
    for (var rawWallet in userWalletCollection.docs) {
      Map<String, dynamic> rawWalletMap = rawWallet.data();
      rawWalletMap['id'] = rawWallet.id;
      Wallet w = Wallet.fromMap(rawWalletMap);
      wallets[rawWallet.id] = w;
    }
    return wallets;
  }

  Future<DocumentReference<Object?>> _getUserPath() async => FirebaseFirestore.instance.collection(AppValue.userCollectionPath).doc(AuthService.instance.currentUser!.uid);
}
