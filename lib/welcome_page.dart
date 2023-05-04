import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_project_app/auth_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  String email = '';
  String username = '';
  String imageUrl = '';
  final usernameController = TextEditingController();
  late Future _fetchFuture;

  @override
  void initState() {
    super.initState();
    _fetchFuture = _fetch();
  }

  _fetch() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((fs) => {
              email = fs.get('email'),
              username = fs.get('username'),
              usernameController.text = fs.get('username'),
              imageUrl = fs.get('image'),
            });
  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   usernameController.dispose();
  //   super.dispose();
  // }

  Future pickCameraImage(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'image': imageUrl});
      setState(() {
        imageUrl = imageUrl;
      });
      Get.snackbar(
        "Aviso",
        "Mensaje usuario",
        backgroundColor: Colors.greenAccent[700],
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        titleText: const Text(
          "Completado éxitosamente",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        messageText: const Text(
          "Imagen de usuario actualizada",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Mensaje",
        "Ha ocurrido un error",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(20),
        titleText: Text(
          "Error al actualizar la imagen de usuario",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  Future pickGalleryImage(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'image': imageUrl});
      setState(() {
        imageUrl = imageUrl;
      });
      Get.snackbar(
        "Aviso",
        "Mensaje usuario",
        backgroundColor: Colors.greenAccent[700],
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        titleText: const Text(
          "Completado éxitosamente",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        messageText: const Text(
          "Imagen de usuario actualizada",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Mensaje",
        "Ha ocurrido un error",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(20),
        titleText: Text(
          "Error al actualizar la imagen de usuario",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  Future deleteImage(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'image': ''});
      setState(() {
        imageUrl = imageUrl;
      });
      Get.snackbar(
        "Aviso",
        "Mensaje usuario",
        backgroundColor: Colors.greenAccent[700],
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        titleText: const Text(
          "Completado éxitosamente",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        messageText: const Text(
          "Imagen de usuario eliminada",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Mensaje",
        "Ha ocurrido un error",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(20),
        titleText: Text(
          "Error al eliminar la imagen de usuario",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  Future<void> _updateUsername() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'username': usernameController.text.trim()});
      setState(() {
        username = username;
      });
      Get.snackbar(
        "Aviso",
        "Mensaje usuario",
        backgroundColor: Colors.greenAccent[700],
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        titleText: const Text(
          "Completado éxitosamente",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        messageText: const Text(
          "Nombre de usuario actualizado",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Mensaje",
        "Ha ocurrido un error",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(20),
        titleText: Text(
          "Error actualizar el nombre de usuario",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: h,
            maxHeight: h,
          ),
          child: FutureBuilder(
            future: _fetchFuture,
            builder: ((context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Scaffold(
                    backgroundColor: Colors.white,
                    body: Column(
                      children: [
                        Container(
                          width: w,
                          height: h * 0.3,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("img/signup.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                        ),
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ));
              } else {
                return Column(
                  children: [
                    Container(
                      width: w,
                      height: h * 0.3,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("img/signup.png"),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: h * 0.16,
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white70,
                                child: ClipOval(
                                  child: imageUrl != '' && imageUrl.isNotEmpty
                                      ? Image.network(
                                          imageUrl,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        Colors.lightBlueAccent),
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          'img/profile3.png',
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Container(
                                              height: 170,
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    onTap: () {
                                                      pickCameraImage(context);
                                                      Navigator.pop(context);
                                                    },
                                                    leading: Icon(
                                                      Icons.camera,
                                                      color: Colors.grey[500],
                                                    ),
                                                    title: const Text('Cámara'),
                                                  ),
                                                  ListTile(
                                                    onTap: () {
                                                      pickGalleryImage(context);
                                                      Navigator.pop(context);
                                                    },
                                                    leading: Icon(
                                                      Icons.image,
                                                      color: Colors.grey[500],
                                                    ),
                                                    title:
                                                        const Text('Galería'),
                                                  ),
                                                  ListTile(
                                                    onTap: () {
                                                      deleteImage(context);
                                                      Navigator.pop(context);
                                                    },
                                                    leading: Icon(
                                                      Icons.delete,
                                                      color: Colors.redAccent,
                                                    ),
                                                    title: const Text(
                                                      'Eliminar',
                                                      style: TextStyle(
                                                        color: Colors.redAccent,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.grey[500],
                                    child: const Icon(
                                      Icons.edit,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: w,
                      margin: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Bienvenido",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.person,
                                      size: 20,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: username,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              title: const Text(
                                                  "Actualizar nombre de usuario"),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    TextField(
                                                      controller:
                                                          usernameController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Nuevo nombre de usuario",
                                                        prefixIcon: const Icon(
                                                          Icons.person,
                                                          color:
                                                              Colors.deepPurple,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancelar',
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    _updateUsername();
                                                    Navigator.pop(context);
                                                    _fetch();
                                                  },
                                                  child: Text('Hecho'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.email,
                                      size: 20,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: email,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    GestureDetector(
                      onTap: () {
                        AuthController.instance.logOut();
                      },
                      child: Container(
                        width: w * 0.5,
                        height: h * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: AssetImage("img/loginbtn.png"),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Cerrar sesión",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Icon(
                                      Icons.logout,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
