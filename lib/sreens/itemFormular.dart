import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fundvgsache/konztante.dart';
import 'package:fundvgsache/models/lostItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'homesreens.dart';

class ItemFormPage extends StatefulWidget {
  @override
  _ItemFormPageState createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  File? image;
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String itemImage = "Fügen Sie hier ein Bild";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _marqueController = TextEditingController();
  final TextEditingController _beschreibungController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _finderIdController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _submitForm() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("Niemand ist verbunden");
      return;
    }
    if (_formKey.currentState!.validate()) {
      LostItems newItem = LostItems(
        itemName: _nameController.text,
        itemMarque: _marqueController.text,
        itemBeschreibung: _beschreibungController.text,
        itemLocationFund: _locationController.text,
        itemDateFound: _dateController.text,
        finderId: user.uid,
        itemKategorie: "gefunden",
        itemBild: itemImage,
        creatAm: DateTime.now(),
      );

      final CollectionReference collref =
          FirebaseFirestore.instance.collection('LostItem');

      try {
        await collref.add(newItem.toMap());
        print("Hinzufügung des Items geklappt");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homescreen()));
      } catch (e) {
        print("Fehler bei der Hinzufügung des Items: $e");
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);

    if (file != null) {
      setState(() {
        image = File(file.path);
      });

      try {
        String uniqueFileName =
            DateTime.now().millisecondsSinceEpoch.toString();
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child('images');
        Reference referenceImageToUpload =
            referenceDirImages.child(uniqueFileName);

        await referenceImageToUpload.putFile(File(file.path));
        String downloadURL = await referenceImageToUpload.getDownloadURL();

        setState(() {
          itemImage = downloadURL;
        });
        print("Bild heruntergeladen: $downloadURL");
      } catch (e) {
        print("$e");
      }
    }
  }

  Future<void> _showImageSourceActionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Aus Galerie wählen'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Mit Kamera aufnehmen'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neue Anzeige hinzufügen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  const Text("add Data"),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: 300,
                          child: image == null
                              ? const Center(
                                  child: Text("kein Bild ausgewählt"))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        ElevatedButton(
                          onPressed: () => _showImageSourceActionSheet(context),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: kPrimaryColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  itemImage.length > 20
                                      ? itemImage.substring(0, 15) + '...'
                                      : itemImage,
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      _showImageSourceActionSheet(context),
                                  icon: const Icon(Icons.file_copy,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name des item'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Geben Sie bitte den Name des items';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _marqueController,
                decoration: InputDecoration(labelText: 'Marque des item'),
              ),
              TextFormField(
                controller: _beschreibungController,
                decoration: InputDecoration(labelText: 'Beschreibung des item'),
              ),
              TextFormField(
                controller: _locationController,
                decoration:
                    InputDecoration(labelText: 'FundOrt des items eingeben'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie hier wo Sie es gefunden haben';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Wann haben Sie es gefunden',
                  hintText: 'AAAA-MM-JJ',
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie ein gültiges Datum';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: const Icon(Icons.save),
        tooltip: 'Item speichern',
      ),
    );
  }
}
