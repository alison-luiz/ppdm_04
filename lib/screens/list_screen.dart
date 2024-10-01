import 'package:flutter/material.dart';
import 'form_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String> _items = [];

  void _addItem(String item) {
    setState(() {
      _items.add(item);
    });
  }

  void _editItem(String newItem, int index) {
    setState(() {
      _items[index] = newItem;
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _navigateToForm({String? item, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormScreen(item: item),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      if (index == null) {
        _addItem(result['item']);
      } else {
        _editItem(result['item'], index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Itens'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_items[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () =>
                        _navigateToForm(item: _items[index], index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteItem(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
