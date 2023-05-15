import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:recetas/firebase/firebase_auth.dart';
import 'package:recetas/firebase/firebase_storage.dart';
import 'package:recetas/controllers/general_controller.dart';
import 'package:recetas/controllers/account_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  AccountController _controller = AccountController();
  GeneralController _genController= GeneralController();
  FirebaseAuthMethods authMethods = FirebaseAuthMethods();
  void _openGallery(BuildContext context) async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    _controller.updateImage(File(pickedImage!.path));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    String? password;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(args);
    final isEmailAccount = args['isEmailAccount'] ?? false;
    final userCredential = args['user'] as UserCredential;
    if(args['pass']!=null){
      password= args['pass'] as String;
    }
    FirebaseAuthMethods authMethods = FirebaseAuthMethods();
    FireStorage _storage = FireStorage();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Edit profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body:Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SafeArea(
                          child: Container(
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.photo_library),
                                  title: Text('Galeria'),
                                  onTap: () {
                                    _openGallery(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                  title: Text('Cancel'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Obx(() {
                    if (_controller.isImage.value != null) {
                      return CircleAvatar(
                        radius: 60.0,
                        backgroundImage: FileImage(_controller.isImage.value!),
                        child: isEmailAccount
                            ? Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Icon(
                                      Icons.edit,
                                      size: 40.0,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                ],
                              )
                            : Icon(
                                Icons.verified,
                                color: Colors.blueAccent,
                              ),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                          userCredential.user!.providerData[0].photoURL != null
                              ? userCredential.user!.providerData[0].photoURL
                                  .toString()
                              : 'https://cadrre.org/wp-content/uploads/2018/04/social-hub-profile-default.jpg',
                        ),
                        child: isEmailAccount
                            ? Icon(
                                Icons.camera_alt,
                                size: 40.0,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.verified,
                                color: Colors.blueAccent,
                              ),
                      );
                    }
                  }),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: userCredential.user!.providerData[0].displayName
                              .toString()
                              .toUpperCase(),
                          enabled: false,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: userCredential.user!.providerData[0].email
                              .toString()
                              .toUpperCase(),
                          enabled: false,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (isEmailAccount) {
                            if (_controller.isImage.value != null) {
                              File? aux = _controller.isImage.value;
                              await _storage
                                  .uploadFile(
                                      aux!, userCredential.user!.uid.toString())
                                  .then((value) {
                                if (value != null) {
                                  authMethods
                                      .updateProfilePhoto(
                                          usuario: userCredential, url: value, pass: password.toString())
                                      .then((value) {
                                    if (value != null) {
                                      if (value.user!.photoURL !=
                                          userCredential.user!.photoURL) {
                                        AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.success,
                                            animType: AnimType.bottomSlide,
                                            title: "Success",
                                            desc:
                                                "Profile photo update successfuly",
                                            btnOkColor: Colors.orangeAccent,
                                            btnOkOnPress: () {
                                              value.user!.reload().then((valor) {
                                                Navigator.pushNamed(
                                                    context, '/home',
                                                    arguments: {
                                                      'user': value,
                                                      'isEmailAccount': true,
                                                      'password':password.toString(),
                                                    });
                                              });
                                            }).show();
                                      }
                                      else{
                                        print(value.user!.photoURL!=userCredential.user!.photoURL);
                                      }
                                    }
                                  });
                                } else {
                                  // handle the case where the upload fails
                                }
                              });
                            }
                          } else {
                            AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.leftSlide,
                                    title: "Error",
                                    desc:
                                        "You don't have permissions to update please contact to support",
                                    btnOkColor: Colors.orangeAccent,
                                    btnOkOnPress: () {})
                                .show();
                          }
                        },
                        child: Text('Update profile'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.0,
                            vertical: 15.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
