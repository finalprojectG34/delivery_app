import 'dart:io';

import 'package:delivery_app/src/app.dart';
import 'package:delivery_app/src/screens/home_page/AppCtx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../components/add_address.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AppController appController = Get.find();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _openImagePicker(String type) async {
    final XFile? pickedImage = await _picker.pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);
    if (pickedImage != null) {
      _image = File(pickedImage.path);
      appController.updateProfilePic(_image!);
      // setState(() {
      //   _image = File(pickedImage.path);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX<AppController>(builder: (ctx) {
      return ListView(
        children: [
          Wrap(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 70, bottom: 100),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 4),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(ctx
                                                .userImageLink.value ==
                                            ''
                                        ? "https://i.pinimg.com/564x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg"
                                        : ctx.userImageLink.value),
                                    radius: 70,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        context: context,
                                        builder: (context) => SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  onTap: () {
                                                    _openImagePicker('camera');
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            'Add from camera',
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Icon(
                                                            Icons.add_a_photo,
                                                            size: 30,
                                                          )
                                                        ],
                                                      )),
                                                ),
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  onTap: () {
                                                    _openImagePicker('gallery');
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(20),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                            'Add from gallery'),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Icon(
                                                          Icons.camera,
                                                          size: 30,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 26,
                                    ))
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              '${ctx.firstName} ${ctx.lastName}',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              ctx.phone.value,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 130),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [Container()],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 330,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: -6,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              // Navigator.pushNamed(
                              //   context,
                              //   UpdateProfile.pathName,
                              //   arguments: user,
                              // );
                              Get.to(() => UpdateProfile());
                            },
                            contentPadding: EdgeInsets.all(0),
                            leading: Icon(Icons.person),
                            title: Text("Update Profile"),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() => ChangePassword());
                            },
                            // onTap: () => Navigator.pushNamed(
                            //   context,
                            //   ChangePassword.pathName,
                            //   arguments: user,
                            // ),
                            contentPadding: EdgeInsets.all(0),
                            leading: Icon(Icons.edit),
                            title: Text("Change Password"),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() => AddAddress());
                            },
                            // onTap: () => Navigator.pushNamed(
                            //   context,
                            //   ChangePassword.pathName,
                            //   arguments: user,
                            // ),
                            contentPadding: EdgeInsets.all(0),
                            leading: Icon(Icons.location_on_outlined),
                            title: Text("Address"),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          ListTile(
                            onTap: () async {
                              // context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
                              // Navigator.pop(context);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Are you sure you want to log out?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Log out'),
                                        onPressed: () async {
                                          EasyLoading.instance.loadingStyle =
                                              EasyLoadingStyle.light;
                                          EasyLoading.show(
                                            status: 'Logging out ...',
                                            maskType: EasyLoadingMaskType.black,
                                          );
                                          await ctx.logout();
                                          ctx.isAuthenticated(false);
                                          ctx.changePage('Home', 0);
                                          EasyLoading.showSuccess('Logged out',
                                              dismissOnTap: true,
                                              maskType:
                                                  EasyLoadingMaskType.black);
                                          Get.offNamed('/');
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            contentPadding: EdgeInsets.all(0),
                            leading: Icon(Icons.logout),
                            title: Text("Logout"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      );
    });
  }
}
