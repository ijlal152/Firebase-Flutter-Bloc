part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  // const ProductState();
  
  // @override
  // List<Object> get props => [];
}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductAddingState extends ProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductAddedState extends ProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductNotAddedState extends ProductState{
  final String errorMessage;
  ProductNotAddedState(this.errorMessage);
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

class ProductLoadingState extends ProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductLoadedState extends ProductState{
  List<ProductModel> mydata;
  ProductLoadedState(this.mydata);
  @override
  // TODO: implement props
  List<Object?> get props => [mydata];
}


