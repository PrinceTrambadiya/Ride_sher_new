class PlaceItemRes {
  String name;
  String address;
  double lat;
  double lng;
  PlaceItemRes(this.name, this.address, this.lat, this.lng);

  static List<PlaceItemRes> fromJson(Map<String, dynamic> json) {
    print("parsing data");
    List<PlaceItemRes> rs = List();

    var results = json['results'] as List;
    for (var item in results) {
      var p = PlaceItemRes(item['name'], item['formatted_address'], item['geometry']['location']['lat'], item['geometry']['location']['lng']);
//      print('formate add====='+item['formatted_address'].toString());
//      print('name======'+item['name'].toString());
      rs.add(p);
      
    }
    return rs;
  }
}