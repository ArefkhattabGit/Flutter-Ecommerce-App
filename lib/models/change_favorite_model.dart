class favoritModel {
  bool? status;

  String? message;

  favoritModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
