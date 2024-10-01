import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  final String? item;
  const FormScreen({super.key, this.item});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.item ?? '');
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {'item': _controller.text});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Adicionar Item' : 'Editar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Item'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um texto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
