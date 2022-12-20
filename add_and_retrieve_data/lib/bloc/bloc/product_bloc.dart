import 'package:add_and_retrieve_data/Models/product_model.dart';
import 'package:add_and_retrieve_data/repository/product_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<AddProductEvent>((event, emit) async{
      emit(ProductAddingState());
      await Future.delayed(const Duration(seconds: 1));
      try{
        await productRepository.AddData(name: event.name, price: event.price);
        emit(ProductAddedState());
      }catch (e){
        emit(ProductNotAddedState(e.toString()));
      }
    });

    on<GetData>((event, emit) async{
      emit(ProductLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      try{
        final data = await productRepository.get();
        emit(ProductLoadedState(data));
      } catch (e){
        emit(ProductNotAddedState(e.toString()));
      }
    });



  }
}
