class CategoriesModel {
  bool? status;
  String? message;
  CategoriesData? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData {
  int? currentPage;
  List<DataModel>? data = [];

  CategoriesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((value) {
      data!.add(DataModel.fromJson(value));
    });
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
