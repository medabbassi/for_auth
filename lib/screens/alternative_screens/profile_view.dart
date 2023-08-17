import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String _photoUrl = '';

  @override
  void initState() {
    super.initState();
    User? user = auth.currentUser;
    _nameController.text = user?.displayName ?? '';
    _emailController.text = user?.email ?? '';
    _phoneNumberController.text = user?.phoneNumber ?? '';
    _photoUrl = user?.photoURL ?? '';
  }

  Future<void> _pickAndSetImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final String imagePath = pickedImage.path;

      // Upload the selected image to Firebase Storage
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${auth.currentUser!.uid}.jpg');

      firebase_storage.UploadTask uploadTask =
          storageReference.putFile(File(imagePath));
      await uploadTask.whenComplete(() async {
        String imageUrl = await storageReference.getDownloadURL();

        // Update the user's photoURL
        await auth.currentUser!.updatePhotoURL(imageUrl);

        setState(() {
          _photoUrl = imageUrl;
          print(_photoUrl);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                await _pickAndSetImage();
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(_photoUrl),
                    radius: 50.0,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.camera),
                      onPressed: () async {
                        await _pickAndSetImage();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Update user data
                await auth.currentUser?.updateDisplayName(_nameController.text);
                await auth.currentUser?.updateEmail(_emailController.text);
                /*  await auth.currentUser?.updatePhoneNumber(
                    _phoneNumberController.text as PhoneAuthCredential); */
                // You can add more validation and error handling here
                // For simplicity, you can display a success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Data updated successfully"),
                  ),
                );
              },
              child: Text("Save Changes"),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () async {
                await googleSignIn.signOut();
                await auth.signOut();
                Navigator.of(context).pop();
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
