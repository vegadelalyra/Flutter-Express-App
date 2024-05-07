import 'package:flutter/material.dart';
import 'package:flutter_client/model/product_model.dart';
import 'package:flutter_client/services/api.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete Operation')),
      body: FutureBuilder(
        future: Api.getProduct(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Product> pdata = List<Product>.from(snapshot.data);

            return ListView.builder(
                itemCount: pdata.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.storage),
                    title: Text('${pdata[index].name}'),
                    subtitle: Text('${pdata[index].desc}'),
                    trailing: IconButton(
                      onPressed: () {
                        Api.deleteProduct(pdata[index].id);
                        pdata.removeAt(index);
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
