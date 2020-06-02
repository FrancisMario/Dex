import 'package:flutter/material.dart';

class Product {   
  final String product_name;   
  final String product_description;   
  final String category_id;   
  final String entity_id;   
  final String product_id;   
  final int price;   
  final String image;
   int quantity;
 
  Product({this.quantity,this.product_name, this.product_description, this.price, this.image, this.category_id, this.entity_id, this.product_id}); 
 
   Map<String, dynamic> toMap() {
    return {
      'product_name': product_name,
      'product_description':product_description,
      'category_id': category_id,
      'entity_id': entity_id,
      'product_id': product_id,
      'price': price,
      'image': image
    };
}

  void increment(){
    this.quantity -= 1;
  }

  void decrement(){
    this.quantity += 1;

  }
  int getTotal(){
    return this.price * this.quantity;
  }
 factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      product_name: json['user_id'],
      product_description: json['product_description'],
      category_id: json['category_id'],
      entity_id: json['ectity_id'],
      product_id: json['product_id'],
      price: json['price'],
      image: json['image_0'],
    );
  }
  
  }