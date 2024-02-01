import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/providers/user_places.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  
  _savePlace(){
    final enterTitle = _titleController.text;
    if(enterTitle.isEmpty){
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(enterTitle);
    Navigator.pop(context);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Place"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                controller: _titleController,
              ),
              const SizedBox(height: 16,),
              ElevatedButton.icon(
                  onPressed: ()=>_savePlace(),
                  icon: const Icon(Icons.add),
                  label: const Text("Add Place"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
