part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  //const ProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends ProductEvent{
  final String name;
  final String price;

  AddProductEvent(this.name, this.price);
}

class GetData extends ProductEvent{
  GetData();
}
