// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task 2',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _items = [];

  final GlobalKey<AnimatedListState> _key = GlobalKey();


  void _addItem() {
    _items.insert(0, "Item ${_items.length + 1}");
    _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
  }


  void _removeItem(int index) {
    _key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: const Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.redAccent,
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text("Deleted", style: TextStyle(fontSize: 24)),
          ),
        ),
      );
    }, duration: const Duration(seconds: 1));

    _items.removeAt(index);
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: const Text('Flutter Map'),
          centerTitle: true,
          toolbarHeight: 100,
          backgroundColor: Colors.brown,
          
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 20),
              child: IconButton(onPressed: ()=>_addItem(), icon: const Icon(Icons.add,color: Colors.white,size: 40,)),
            ),
            Expanded(
              child: AnimatedList(
                physics: const BouncingScrollPhysics(),
                key: _key,
                initialItemCount: 0,
                padding: const EdgeInsets.all(10),
                itemBuilder: (_, index, animation) {
                  return SizeTransition(
                    key: UniqueKey(),
                    sizeFactor: animation,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 10,
                      color: Colors.orange,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(15),
                        title:
                        Text(_items[index], style: const TextStyle(fontSize: 24)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeItem(index),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}