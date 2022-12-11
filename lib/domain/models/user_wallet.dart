import 'package:equatable/equatable.dart';

class UserWallet extends Equatable {
  final String privateKey;
  final String publicAddress;

  const UserWallet(this.privateKey, this.publicAddress);

  @override
  List<Object?> get props => [privateKey, publicAddress];
}
