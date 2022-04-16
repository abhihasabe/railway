import 'package:encrypt/encrypt.dart';

class EncryptData{
//for AES Algorithms

  static Encrypted? encrypted;
  static var decrypted;

  static encryptAES(plainText){
    final key = Key.fromUtf8('82a645babc5cd41c9a2cb4d0d3ba17ad');
    final iv = IV.fromLength(16);
    final encryptor = Encrypter(AES(key));
    encrypted = encryptor.encrypt(plainText, iv: iv);
    return encrypted!.base64;
  }

  static decryptAES(plainText){
    final key = Key.fromUtf8('82a645babc5cd41c9a2cb4d0d3ba17ad');
    final iv = IV.fromLength(16);
    final encryptor = Encrypter(AES(key));
    decrypted = encryptor.decrypt64(plainText, iv: iv);
    return decrypted;
  }
}