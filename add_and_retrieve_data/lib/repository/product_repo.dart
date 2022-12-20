import 'dart:io';

import 'package:add_and_retrieve_data/Models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductRepository{
  final fireCloud = FirebaseFirestore.instance.collection('TestDatabase');

  Future<void> AddData({required String name, required String price}) async{
    try{
      await fireCloud.add({"name": name, "price": price});
    }on FirebaseException catch (e){
      if(kDebugMode){
        print("Failed with error '${e.code}' : ${e.message}");
      }
    }catch (e){
      throw Exception(e.toString());
    }
  }

  Future<List<ProductModel>> get() async {
    List<ProductModel> proList = [];
    
    //User? user = _firebaseAuth.currentUser;
    try{
      //final pro = await FirebaseFirestore.instance.collection('TestDatabase').get();
      final pro = await FirebaseFirestore.instance.collection('TestDatabase').get();
      pro.docs.forEach((element) { 
        fireCloud.doc(element.id).collection('NewCollection').get().then((value) {
          value.docs.forEach((element) { 
            print(element.data());
            return proList.add(ProductModel.fromJson(element.data()));
          });
        });
        //return proList.add(ProductModel.fromJson(element.data()));
        //return proList.add(ProductModel.fromJson(element.data()));
      });
      return proList;
    } on FirebaseException catch(e){
      if(kDebugMode){
        print("Failed with error: '${e.code}': ${e.message}");
      }
      return proList;
    } catch(e){
      throw Exception(e.toString());
    }
  }
  
}