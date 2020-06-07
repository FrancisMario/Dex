


class OrderPackage {
   String name;
   String geolocation;
   String lastname;
   String phone;
   String delivery_address;
   String delivery_date;
   String delivery_time;
   String pickup_date;
   String pickup_time;
   String pickup_address;
   String sender_id;
   String order_date;
   String order_time;
   String order_details;
   String package_size;
   String package_description;
   String delivery_note;


  //    Map<String, dynamic> toMap() {
  //   return {
  //     'name': name,
  //     // 'geolocation': geolocation,
  //     // 'lastname': lastname, not yet sure if i wanna add this kinda complexity to my code
  //     'phone': phone,
  //     'delivery_address': delivery_address,
  //     'delivery_date': delivery_date,
  //     'delivery_time': delivery_time,
  //     'pickup_date': pickup_date,
  //     'sender_id': sender_id,
  //     'order_date': order_date,
  //     // 'order_time': order_time,
  //     // 'order_details': order_details,
  //     'package_description': package_description,
  //     'delivery_note': delivery_note,
  //   };
  // }

 
}



// the cre
class Credential {
   final String phone;
   final String name;
   final String user_id; 
  
  Credential({this.phone, this.name,  this.user_id});
  Map<String, dynamic> toMap() {
    return {
      'user_id' : user_id, 
      'name': name,
      'phone': phone,
    };
}

 factory Credential.fromJson(Map<String, dynamic> json) {
    return Credential(
      user_id: json['user_id'],
      phone: json['phone'],
      name: json['name'],
    );
  }
}

class Stat {
    final int totalDelivery;
    final String accountType;
    final String accountOwner;

    Stat({this.totalDelivery,this.accountOwner,this.accountType});

    Map<String, dynamic> toMap() {
    return {
      'totalDelivery': totalDelivery,
      'accountType': accountType,
      'accountOwner': accountOwner
    };
}

 factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      totalDelivery: json['totalDelivery'],
      accountOwner: json['accountOwner'],
      accountType: json['accountType']
    );
  }
}

class Address {
  final String name;
  final String table_id;
  final String description;
  final String coordinates;

  Address({this.table_id,this.description,this.name,this.coordinates});

     Map<String, dynamic> toMap() {
    return {
      'name': name,
      'table_id': table_id,
      'description': description,
      'geolocation': coordinates
    };
  }

 factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      name: json['name'],
      table_id: json['table_id'],
      description: json['description'],
      coordinates: json['geolocation']
    );
  }
}


class RecordList {
     List<Record> list; 
     
     RecordList(this.list);

 List<Record> toMap() {
    return list;
  }

factory RecordList.fromJson(List<dynamic> json) {
  List<Record> list = []; 

  for(var  i = 0; i < json.length;i++){
    print("helooooo");
    print(list);
            list.add(Record.fromJson(json[i]));
    print(list[0].date);
  }
  return RecordList(list);
  }

}


class Record {
  final String name;
  final String time;
  final String date;
  final String contact;
  final String address;
  //  Address destination;

  Record({this.name, this.contact, this.address, this.date, this.time,  }){
      // this.destination = Address.fromJson(destination);
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'date': date,
      'name': name,
      'contact' :contact,
      'address' :address,
    };
  }
 factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      time: json['time'],
      date: json['date'],
      name: json['name'],
      contact: json['contact'],
      address: json['address'],
    );
  }
}

class DeliveryOrder {
  final String name;
  final String geolocation;
  final String lastname;
  final String phone;
  final String delivery_address;
  final String delivery_date;
  final String delivery_time;
  final String pickup_date;
  final String sender_id;
  final String order_date;
  final String order_time;
  final String order_details;
  final String package_size;
  final String package_description;
  final String delivery_note;

  DeliveryOrder({this.lastname, this.phone, this.delivery_address, this.delivery_date, this.delivery_time, this.pickup_date, this.sender_id, this.order_date, this.order_time, this.order_details, this.package_size, this.package_description, this.delivery_note, this.name,this.geolocation,});

     Map<String, dynamic> toMap() {
    return {
      'name': name,
      // 'geolocation': geolocation,
      // 'lastname': lastname, not yet sure if i wanna add this kinda cpmexity to my code
      'phone': phone,
      'delivery_address': delivery_address,
      'delivery_date': delivery_date,
      'delivery_time': delivery_time,
      'pickup_date': pickup_date,
      'sender_id': sender_id,
      'order_date': order_date,
      // 'order_time': order_time,
      // 'order_details': order_details,
      'package_description': package_description,
      'delivery_note': delivery_note,
    };
  }

 factory DeliveryOrder.fromJson(Map<String, dynamic> json) {
    return DeliveryOrder(
      name: json['name'],
      geolocation : json['geolocation'],
      // lastname: json['lastname'],
      phone: json['phone'],
      delivery_address: json['delivery_address'],
      delivery_date : json['delivery_date'],
      delivery_time : json['delivery_time'],
      pickup_date : json['pickup_date'],
      sender_id : json['sender_id'],
      order_date : json['order_date'],
      // order_time : json['order_time'],
      order_details: json['order_details'],
      package_description: json['package_description'],
      delivery_note: json['delivery_note'],
    );
  }
}