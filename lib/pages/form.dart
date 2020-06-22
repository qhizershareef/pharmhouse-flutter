import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:fluttertoast/fluttertoast.dart';

//final FirebaseStorage _storage = FirebaseStorage.instance;
//bool _isUploading = false;
//bool _isCompletedUploading = false;
final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

class Forme extends StatefulWidget {
  @override
  _FormeState createState() => _FormeState();
}

class _FormeState extends State<Forme> {
  File _image = null;
  File _image2 = null;
  // File _image;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        FormBuilder(
          key: _fbKey,
          initialValue: {
            'date': DateTime.now(),
            'accept_terms': false,
          },
          autovalidate: true,
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                attribute: "name",
                decoration: InputDecoration(
                    labelText: "Name", prefixIcon: Icon(Icons.person)),
                validators: [FormBuilderValidators.required()],
              ),
              FormBuilderTextField(
                attribute: "phone",
                decoration: InputDecoration(
                    labelText: "Phone", prefixIcon: Icon(Icons.phone)),
                validators: [
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.required(),
                  FormBuilderValidators.pattern('[1-9]{1}[0-9]{9}',
                      errorText: 'Please enter 10 digit number!')
                ],
                maxLength: 10,
              ),
              FormBuilderTextField(
                attribute: "optional",
                decoration: InputDecoration(
                    labelText: "Optional Phone", prefixIcon: Icon(Icons.phone)),
                validators: [
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.pattern('[1-9]{1}[0-9]{9}',
                      errorText: 'Please enter 10 digit number!')
                ],
                maxLength: 10,
              ),
              FormBuilderTextField(
                attribute: "email",
                decoration: InputDecoration(
                    labelText: "E-mail", prefixIcon: Icon(Icons.email)),
                validators: [FormBuilderValidators.required(),
                FormBuilderValidators.email()
                ],
              ),
              FormBuilderTextField(
                attribute: "referral",
                decoration: InputDecoration(
                    labelText: "Referral Number",
                    prefixIcon: Icon(Icons.people)),
                validators: [
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.pattern('[1-9]{1}[0-9]{9}',
                      errorText: 'Please enter 10 digit number!')
                ],
                maxLength: 10,
              ),
              FormBuilderTextField(
                attribute: "address",
                decoration: InputDecoration(
                    labelText: "Address", prefixIcon: Icon(Icons.home)),
                validators: [FormBuilderValidators.required()],
              ),
              FormBuilderDropdown(
                attribute: "selected",
                decoration: InputDecoration(
                    labelText: "Select Mode of Payment",
                    prefixIcon: Icon(Icons.payment)),
                hint: Text('Choose one'),
                validators: [FormBuilderValidators.required()],
                items: ['UPI', 'Net Banking', 'Cash on Delivery']
                    .map((selected) => DropdownMenuItem(
                        value: selected, child: Text("$selected")))
                    .toList(),
              ),
              SizedBox(height: 20),
              Text("Upload Prescription"),
              MaterialButton(
                color: Colors.red[800],
                textColor: Colors.white,
                child: Text("Upload"),
                onPressed: () {
                  _loadImage();
                },
              ),
              Text("Upload Prescription 2"),
              MaterialButton(
                color: Colors.red[800],
                textColor: Colors.white,
                child: Text("Upload"),
                onPressed: () {
                  _loadImage2();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 25),
        Row(
          children: <Widget>[
            SizedBox(width: 100),
            MaterialButton(
              color: Colors.red[800],
              textColor: Colors.white,
              child: Text("Submit"),
              onPressed: () {
                _submitButton();
              },
            ),
            SizedBox(width: 20),
            MaterialButton(
              child: Text("Reset"),
              color: Colors.red[800],
              textColor: Colors.white,
              onPressed: () {
                _fbKey.currentState.reset();
              },
            ),
          ],
        )
      ],
    );
  }

  void _loadImage() async {
    var image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 70);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      Fluttertoast.showToast(
          msg: "Image 1 Selected",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.blue,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white);
    } else {
      Fluttertoast.showToast(
          msg: "Please Select Image",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red[800],
          gravity: ToastGravity.CENTER,
          textColor: Colors.white);
    }
  }

  void _loadImage2() async {
    var image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 70);
    if (image != null) {
      setState(() {
        _image2 = File(image.path);
      });

      Fluttertoast.showToast(
          msg: "Image 2 Selected",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.blue,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white);
    } else {
      Fluttertoast.showToast(
          msg: "Please Select Image",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red[800],
          gravity: ToastGravity.CENTER,
          textColor: Colors.white);
    }
  }

  void _submitButton() async {
    var currDt = DateTime.now();
    String formatted = '${currDt.day}/${currDt.month}/${currDt.year}';
    //uploading to firestore
    if (_fbKey.currentState.saveAndValidate() &&
        (_image != null || _image2 != null)) {
      Fluttertoast.showToast(
          msg: "Please Wait...",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 55,
          backgroundColor: Colors.blue,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white);
      Firestore.instance
          .collection('Medical')
          .document(_fbKey.currentState.value['name'])
          .setData({
        'name': _fbKey.currentState.value['name'],
        'Phone': _fbKey.currentState.value['phone'],
        'optional': _fbKey.currentState.value['optional'],
        'email': _fbKey.currentState.value['email'],
        'referral': _fbKey.currentState.value['referral'],
        'Address': _fbKey.currentState.value['address'],
        'selected': _fbKey.currentState.value['selected'],
        'orderDate': formatted,
      });
      uploadFile(_fbKey.currentState.value['name']);
    } else {
      Fluttertoast.showToast(
          msg: "Please Select atleast one Image!",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 55,
          backgroundColor: Colors.red[800],
          gravity: ToastGravity.CENTER,
          textColor: Colors.white);
    }
  }

  uploadFile(name) async {
    print(name + ' File is getting uploaded');
    if (name != null) {
      if (_image != null) {
        print('Image 1 getting uploaded');
        StorageReference storageReference = FirebaseStorage.instance
            .ref()
            .child(name + '/${Path.basename(_image.path)}');
        StorageUploadTask uploadTask = storageReference.putFile(_image);
        await uploadTask.onComplete;
      }
      if (_image2 != null) {
        print('Image 2 getting uploaded');
        StorageReference storageReference2 = FirebaseStorage.instance
            .ref()
            .child(name + '/${Path.basename(_image2.path)}');
        StorageUploadTask uploadTask2 = storageReference2.putFile(_image2);
        await uploadTask2.onComplete;
      }
      Fluttertoast.showToast(
          msg: "Uploaded Successfully",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 7,
          backgroundColor: Colors.green,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white);
    } else {
      print("no-------------------");
    }
  }
}
