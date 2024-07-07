import 'package:flutter/material.dart';
import 'package:fundvgsache/models/lostItem.dart';
//import 'package:fundvgsache/models/lostItem.dart';
class ItemFormPage extends StatefulWidget {
  @override
  _ItemFormPageState createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _marqueController = TextEditingController();
  final TextEditingController _beschreibungController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _finderIdController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _bildController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      LostItems newItem = LostItems(
        itemName: _nameController.text,
        itemMarque: _marqueController.text,
        itemBeschreibung: _beschreibungController.text,
        itemLocationFund: _locationController.text,
        itemDateFund: _dateController.text,
        finderId: int.tryParse(_finderIdController.text),
        itemStatus: _statusController.text,
        itemBild: _bildController.text,
      );
      // Faites quelque chose avec newItem, comme l'insérer dans la base de données
      print(newItem.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Item Perdu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom de l\'item'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom de l\'item';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _marqueController,
                decoration: InputDecoration(labelText: 'Marque de l\'item'),
              ),
              TextFormField(
                controller: _beschreibungController,
                decoration: InputDecoration(labelText: 'Description de l\'item'),
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Lieu de trouvaille'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le lieu de trouvaille';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date de trouvaille',
                  hintText: 'AAAA-MM-JJ',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la date de trouvaille';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _finderIdController,
                decoration: InputDecoration(labelText: 'ID du trouveur'),
              ),
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Statut de l\'item'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le statut de l\'item';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bildController,
                decoration: InputDecoration(labelText: 'Image de l\'item'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: Icon(Icons.save),
        tooltip: 'Enregistrer l\'item',
      ),
    );
  }
}