import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/services/shared_prefs.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _profilePicture;
  File? _bannerPicture;

  final picker = ImagePicker();
  final SharedPrefs _prefs = SharedPrefs();

  late String _name;
  final TextEditingController _nameController = TextEditingController(text: "");

  late String _bio;
  final TextEditingController _bioController = TextEditingController(text: "");

  late String _location;
  final TextEditingController _locationController =
      TextEditingController(text: "");

  late String _website;
  final TextEditingController _websiteController =
      TextEditingController(text: "");

  late String _birthdate;
  final TextEditingController _birthdateController =
      TextEditingController(text: "");

  Future getImage(int type, bool isCamera) async {
    if (isCamera) {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        if (pickedFile != null && type == 0) {
          _profilePicture = File(pickedFile.path);
        }
        if (pickedFile != null && type == 1) {
          _bannerPicture = File(pickedFile.path);
        }
      });
    } else {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null && type == 0) {
          _profilePicture = File(pickedFile.path);
        }
        if (pickedFile != null && type == 1) {
          _bannerPicture = File(pickedFile.path);
        }
      });
    }
  }

  showAlertDialog(BuildContext context, int type) {
    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.start,
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                await getImage(type, true);
                // TODO: Add Image Cropper
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Take photo"),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await getImage(type, false);
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Choose existing photo"),
              ),
            ),
          ],
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  getData() async {
    await _prefs.getNameFromSharedPref().then((value) {
      setState(() {
        _nameController.text = value;
        _name = value;
      });
    });
    await _prefs.getBioFromSharedPrefs().then((value) {
      setState(() {
        _bioController.text = value;
        _bio = value;
      });
    });
    await _prefs.getLocationFromSharedPrefs().then((value) {
      setState(() {
        _locationController.text = value;
        _location = value;
      });
    });
    await _prefs.getWebsiteFromSharedPrefs().then((value) {
      setState(() {
        _websiteController.text = value;
        _website = value;
      });
    });
    await _prefs.getBirthdateFromSharedPrefs().then((value) {
      setState(() {
        _birthdateController.text = value;
        _birthdate = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              size: 23,
              color: Colors.black,
            ),
          ),
        ),
        title: const Text(
          "Edit profile",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(0, 0, 0, 1))),
            onPressed: () {
              // TODO: Save profile data
              _prefs.setNameFromSharedPref(_name);
              _prefs.setBioFromSharedPrefs(_bio);
              _prefs.setLocationFromSharedPrefs(_location);
              _prefs.setWebsiteFromSharedPrefs(_website);
              _prefs.setBirthdateFromSharedPrefs(_birthdate);
            },
            child: const Text("Save"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                GestureDetector(
                  onTap: () {
                    showAlertDialog(context, 1);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: size.height / 4,
                    child: _bannerPicture != null
                        ? Image.file(
                            _bannerPicture!,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            "img/defaultBanner.png",
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: size.height / 13,
                ),
                GestureDetector(
                  onTap: () {
                    showAlertDialog(context, 0);
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: _profilePicture != null
                            ? Image.file(
                                _profilePicture!,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                "img/defaultPfp.jpg",
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      // TODO: Prepoulate with users name
                      controller: _nameController,
                      decoration: const InputDecoration(
                        label: Text(
                          "Name",
                          style: TextStyle(color: Colors.black54),
                        ),
                        hintText: "Name connot be blank",
                      ),
                      onChanged: (val) => setState(() {
                        _name = val;
                      }),
                    ),
                    TextFormField(
                      controller: _bioController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        label: Text(
                          "Bio",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      onChanged: (val) => setState(() {
                        _bio = val;
                      }),
                    ),
                    // TODO: Location dropdown selector
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        label: Text(
                          "Location",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      onChanged: (val) => setState(() {
                        _location = val;
                      }),
                    ),
                    TextFormField(
                      controller: _websiteController,
                      decoration: const InputDecoration(
                        label: Text(
                          "Website",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      onChanged: (val) => setState(() {
                        _website = val;
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _birthdateController,
                        decoration: const InputDecoration(
                          label: Text(
                            "Birth date",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        onChanged: (val) => setState(() {
                          _birthdate = val;
                        }),
                      ),
                    ),
                    // TODO: Add gesture detector to change values
                    const Text("Month and day: Your followers"),
                    const Text("Year: You follow each other"),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 15, 0, 15),
                      child: SizedBox(
                        width: size.width / 2.25,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text(
                            "Switch to Professional",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            fixedSize: MaterialStateProperty.all<Size>(
                                Size(size.width / 2, 40)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(
                                  color: Color.fromRGBO(29, 161, 242, 1),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(thickness: 1),
                    GestureDetector(
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(bottom: 2),
                              child: Text(
                                "Tips",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text("Off"),
                          ],
                        ),
                      ),
                    ),
                    const Divider(thickness: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
