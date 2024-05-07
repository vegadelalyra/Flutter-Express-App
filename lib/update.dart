import 'package:flutter/material.dart';
import 'package:flutter_client/edit.dart';
import 'package:flutter_client/model/product_model.dart';
import 'package:flutter_client/services/api.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update operation'),
      ),
      body: FutureBuilder(
          future: Api.getProduct(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditScreen(data: pdata[index]),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit)));
                  });
            }
          }),
    );
  }
}
