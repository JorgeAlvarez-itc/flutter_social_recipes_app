import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountSettings{
  final _getStorage=GetStorage();
  final storageKey="isEmailAccount";
  final storageKeyUser="user";
  final storageKeyPassword="user";

  bool isEmailAccount(){
    return _getStorage.read(storageKey)??false;
  }

  bool isPassword(){
    return _getStorage.read(storageKeyPassword)??false;
  }

  bool isUserCredential(){
    return _getStorage.read(storageKeyUser)??false;
  }

  void saveIsEmailMode(bool isEmailAccount){
    _getStorage.write(storageKey, isEmailAccount);
  }

  void saveUser(UserCredential user){
    _getStorage.write(storageKeyUser, user);
  }

  void savePass(String pass){
    _getStorage.write(storageKeyPassword, pass);
  }

  Future <void> saveCredentials(bool isEmailAccount, UserCredential userCredential, String? pass) async{
    print({
      'user':userCredential,
      'isEmail':isEmailAccount,
      'pass':pass
    });
    saveUser(userCredential);
    saveIsEmailMode(isEmailAccount);
    if(pass!=null){
      savePass(pass);
    }
  }

  UserCredential? getUser() {
    return _getStorage.read(storageKeyUser);
  }

  String? getPassword(){
    return _getStorage.read(storageKeyPassword);
  }

  bool? getIsEmail(){
    return _getStorage.read(storageKey);
  }

}