import 'package:add_and_retrieve_data/Models/product_model.dart';
import 'package:add_and_retrieve_data/bloc/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final nameController = TextEditingController();
  final priceController = TextEditingController();

  Future<void> _create() async {
    await showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx){
          return Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20
              ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                const SizedBox(height: 20,),

                ElevatedButton(
                    onPressed: () async{
                      final String name = nameController.text;
                      final double price = double.parse(priceController.text);
                      if(price != null){
                        _postData(context);

                        nameController.text = '';
                        priceController.text = '';

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add Data')),
              ],
            ),
          );
        }
    );
  }

  void _postData(context) {
      BlocProvider.of<ProductBloc>(context).add(AddProductEvent(nameController.text, priceController.text));
  }

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(GetData());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Firestore'),
        centerTitle: true,
      ),

      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state){
          if(state is ProductLoadedState){
            List<ProductModel> data = state.mydata;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index){
                return Card(
                  child: ListTile(
                    title: Text(data[index].name),
                    trailing: Text(data[index].name),
                  ),
                );
              }
              );
          } else if(state is ProductLoadingState){
            return const Center(child: CircularProgressIndicator(),);
          }else{
            return Container();
          }
        }
        ),



      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}