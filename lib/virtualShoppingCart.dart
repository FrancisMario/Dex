
import 'package:dex/product.dart';
import 'package:dex/dataStructures.dart';

class VirtualShoppingCart {

  List<Product> products;
  Address address;
  
  void addProduct(Product p){
      products.add(p);
  }
  
  void removeProduct(int index){
      products.removeAt(index);
  }
  
  List<Product> readProduct(){
    return products;
  }

  length(){
    return products.length;
  }


}
